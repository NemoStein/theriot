package nemostein.games.geocontact.theriot.states.gameplay.unitfactories
{
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	import nemostein.bezier.Path;
	import nemostein.bezier.PathTracker;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.framework.dragonfly.Game;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.utils.ErrorUtils;
	import nemostein.utils.MathUtils;
	
	public class Unit extends Entity
	{
		static public const AIR:String = "air";
		static public const GROUND:String = "ground";
		
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
			
			_type = unitType;
		}
		
		override protected function update():void
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
			
			var enemy:Unit = enemyInRange();
			
			var willFire:Boolean = enemy && !_reloading;
			var willMove:Boolean = !enemy || _type == AIR;
			
			if (willFire)
			{
				fire(enemy);
				_reloading = true;
			}
			
			if (willMove && _pathTracker)
			{
				var moving:Boolean = _pathTracker.move(speed * time);
				if (moving)
				{
					var quarterPi:Number = MathUtils.QUARTER_PI;
					var motionAngle:Number = Math.atan2(_pathTracker.y - y, _pathTracker.x - x);
					
					if (motionAngle < -quarterPi * 3 || motionAngle > quarterPi * 3)
					{
						_lookingAt = LEFT;
					}
					else if (motionAngle < -quarterPi)
					{
						_lookingAt = UP;
					}
					else if (motionAngle < quarterPi)
					{
						_lookingAt = RIGHT;
					}
					else
					{
						_lookingAt = DOWN;
					}
					
					if (_lookingAt == UP)
					{
						frame.y = 0;
					}
					else if (_lookingAt == LEFT || _lookingAt == RIGHT)
					{
						frame.y = height;
					}
					else if (_lookingAt == DOWN)
					{
						frame.y = height * 2;
					}
					
					if (_lookingAt != LEFT && flipped)
					{
						flip();
					}
					else if (_lookingAt == LEFT && !flipped)
					{
						flip();
					}
					
					x = _pathTracker.x;
					y = _pathTracker.y;
				}
				else
				{
					die();
				}
			}
			
			super.update();
		}
		
		protected function fire(unit:Unit):void
		{
			GamePlay.service.fire(ammoClass, this, unit);
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
				
				if (enemy.active)
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
			GamePlay.service.removeUnit(this);
			
			super.die();
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