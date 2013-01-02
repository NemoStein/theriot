package nemostein.games.geocontact.theriot.states.gameplay.unitfactories
{
	import nemostein.bezier.Path;
	import nemostein.bezier.PathTracker;
	import nemostein.framework.dragonfly.modules.container.entity.AlphaEntity;
	import nemostein.framework.dragonfly.modules.container.entity.Animation;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.utils.ErrorUtils;
	import nemostein.utils.MathUtils;
	
	public class Unit extends AlphaEntity
	{
		static public const AIR:String = "air";
		static public const GROUND:String = "ground";
		
		static public const RUN:String = "run";
		static public const FIRE:String = "fire";
		static public const DIE:String = "die";
		static public const DEAD:String = "dead";
		
		static private const UP:int = 1;
		static private const DOWN:int = 2;
		static private const LEFT:int = 3;
		static private const RIGHT:int = 4;
		
		private var _factory:Factory;
		
		private var _pathTracker:PathTracker;
		
		private var _lookingAt:int;
		private var _type:String;
		
		private var _reloading:Boolean;
		private var _reloadTime:Number;
		private var _reloadDelay:Number;
		private var _rangeSquare:Number;
		private var _dying:Boolean;
		private var _target:Unit;
		private var _deathAnimation:int;
		
		private var _delayToFade:Number;
		private var _timeToFade:Number;
		
		public var health:Number;
		public var armor:Number;
		public var speed:Number;
		public var power:Number;
		public var range:Number;
		public var rate:Number;
		
		public var enemyUnits:Vector.<Unit>;
		
		public function Unit(factory:Factory)
		{
			_factory = factory;
			
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var stats:FactoryStats = _factory.stats;
			
			health = stats.unitHealth;
			armor = stats.unitArmor;
			speed = stats.unitSpeed;
			power = stats.unitPower;
			range = stats.unitRange;
			rate = stats.unitRate;
			
			_reloading = false;
			_reloadTime = 0;
			_reloadDelay = 100 / rate;
			_rangeSquare = range * range;
			
			_delayToFade = 2.5;
			_timeToFade = 0;
			
			_type = unitType;
			
			addAnimation(RUN, [0, 1, 2], 10);
			addAnimation(FIRE, [3, 4, 5, 6], 10, false, fireAnimationCallback);
			addAnimation(DIE, [7, 8, 9], 7, false, deathAnimationCallback);
			addAnimation(DEAD, [10, 11], 5);
			
			playAnimation(RUN);
		}
		
		private function fireAnimationCallback(animation:Animation, keyframe:int, cycle:Boolean):void
		{
			if (keyframe == 2)
			{
				GamePlay.service.fire(ammoClass, this, _target);
			}
			else if (cycle)
			{
				_target = null;
			} 
		}
		
		private function deathAnimationCallback(animation:Animation, keyframe:int, cycle:Boolean):void
		{
			if (cycle && animation.id == DIE)
			{
				playAnimation(DEAD);
			}
		}
		
		override protected function update():void
		{
			if (!_dying)
			{
				if (_reloading)
				{
					_reloadTime += time;
					
					if (_reloadTime >= _reloadDelay)
					{
						_reloadTime = 0;
						_reloading = false;
					}
				}
				
				var quarterPi:Number = MathUtils.QUARTER_PI;
				var lookAngle:Number;
				
				var enemy:Unit = enemyInRange();
				
				var willFire:Boolean = enemy && !_reloading;
				if (willFire)
				{
					lookAngle = Math.atan2(enemy.y - y, enemy.x - x);
					
					fire(enemy);
					_reloading = true;
				}
				
				var willMove:Boolean = (!_target || _type == AIR) && _pathTracker;
				if (willMove)
				{
					playAnimation(RUN, false);
					
					var moving:Boolean = _pathTracker.move(speed * time);
					if (moving)
					{
						lookAngle = Math.atan2(_pathTracker.y - y, _pathTracker.x - x);
						
						x = _pathTracker.x;
						y = _pathTracker.y;
					}
					else
					{
						GamePlay.service.hitEnemyComplex(this);
						die();
					}
				}
				
				if(!isNaN(lookAngle))
				{
					if (lookAngle < -quarterPi * 3 || lookAngle > quarterPi * 3)
					{
						_lookingAt = LEFT;
					}
					else if (lookAngle < -quarterPi)
					{
						_lookingAt = UP;
					}
					else if (lookAngle > quarterPi)
					{
						_lookingAt = DOWN;
					}
					else
					{
						_lookingAt = RIGHT;
					}
					
					if (_lookingAt == UP)
					{
						frame.y = 0;
					}
					else if (_lookingAt == LEFT || _lookingAt == RIGHT)
					{
						frame.y = height;
						
						if (_lookingAt == LEFT && !flipped || _lookingAt != LEFT && flipped)
						{
							flip();
						}
					}
					else if (_lookingAt == DOWN)
					{
						frame.y = height * 2;
					}
				}
			}
			else if(animation.id == DEAD)
			{
				_timeToFade += time;
				
				if (_timeToFade >= _delayToFade)
				{
					alpha -= 0.75 * time;
					
					if (alpha <= 0)
					{
						GamePlay.service.removeUnit(this);
						super.die();
					}
				}
			}
			
			super.update();
		}
		
		protected function fire(unit:Unit):void
		{
			_target = unit;
			playAnimation(FIRE);
		}
		
		public function hit(power:Number):void
		{
			var damage:Number = power - (Math.random() * 0.75 + 0.5) * armor;
			
			if (damage < 1)
			{
				damage = 1;
			}
			
			health -= damage;
			
			if (health < 0)
			{
				die();
			}
		}
		
		protected function enemyInRange():Unit
		{
			for (var i:int = 0; i < enemyUnits.length; ++i)
			{
				var enemy:Unit = enemyUnits[i];
				
				if (enemy.active && !enemy._dying)
				{
					var distanceX:Number = enemy.x - x;
					var distanceY:Number = enemy.y - y;
					var distaceSquare:Number = distanceX * distanceX + distanceY * distanceY;
					
					if (distaceSquare <= _rangeSquare)
					{
						return enemy;
					}
				}
			}
			
			return null;
		}
		
		override public function die():void
		{
			if (!_dying)
			{
				_dying = true;
				playAnimation(DIE, false);
			}
		}
		
		public function get ai():Boolean
		{
			return _factory.ai;
		}
		
		public function get path():Path
		{
			return _pathTracker.path;
		}
		
		public function set path(value:Path):void
		{
			_pathTracker = new PathTracker(value, ai);
		}
		
		protected function get ammoClass():Class
		{
			throw ErrorUtils.abstractMethod(this, "Unit", "ammoClass");
		}
		
		protected function get unitType():String
		{
			throw ErrorUtils.abstractMethod(this, "Unit", "unitType");
		}
	}
}