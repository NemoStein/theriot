package nemostein.games.geocontact.theriot.states.gameplay.unitfactories
{
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayService;
	
	public class Unit extends Target
	{
		public var health:Number;
		public var armor:Number;
		public var speed:Number;
		public var firePower:Number;
		public var fireRate:Number;
		public var fireRange:Number;
		
		protected var gamePlayService:GamePlayService;
		protected var factory:Factory;
		
		private var _bulletClass:Class;
		private var _reloading:Boolean;
		private var _reloadTime:Number;
		private var _reloadDelay:Number;
		
		private var _enemy:Target;
		
		private var _squareSearchRange:Number;
		private var _squareFireRange:Number;
		
		public function Unit(factory:Factory, bulletClass:Class)
		{
			this.factory = factory;
			
			gamePlayService = GamePlay.service;
			
			_bulletClass = bulletClass;
			
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			relative = false;
		}
		
		override protected function update():void
		{
			super.update();
			
			var moveSpeed:Number = speed * time;
			
			if (!_enemy || _enemy is Factory)
			{
				var newEnemy:Target = findEnemyTarget();
				
				if (!_enemy || newEnemy is Unit || !(_enemy as Factory).canWork() && (newEnemy as Factory).canWork())
				{
					_enemy = newEnemy;
				}
			}
			
			if (_enemy && _enemy.active)
			{
				if (!engageEnemy())
				{
					var distanceX:Number = _enemy.x - x;
					var distanceY:Number = _enemy.y - y;
					var direction:Number = Math.atan2(distanceY, distanceX);
					
					x += Math.cos(direction) * moveSpeed;
					y += Math.sin(direction) * moveSpeed;
				}
				else if (!_reloading)
				{
					fire();
				}
			}
			else
			{
				_enemy = null;
			}
			
			if (_reloading)
			{
				_reloadTime += time;
				
				if (_reloadTime >= _reloadDelay)
				{
					_reloadTime -= _reloadDelay;
					_reloading = false;
				}
			}
		}
		
		private function findEnemyTarget():Target
		{
			var squareSearchRange:Number = _squareSearchRange;
			var localX:Number = x;
			var localY:Number = y;
			
			var closestEnemy:Target;
			var closestEnemyDistance:Number = Infinity;
			
			var units:Vector.<Unit> = factory.complex.enemyComplex.units;
			
			var length:int = units.length;
			for (var i:int = 0; i < length; ++i)
			{
				var target:Target = units[i];
				if (target.activate)
				{
					var distanceX:Number = target.x - localX;
					var distanceY:Number = target.y - localY;
					var squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
					
					if (squareDistance <= squareSearchRange && squareDistance < closestEnemyDistance)
					{
						closestEnemyDistance = squareDistance;
						closestEnemy = target;
					}
				}
			}
			
			if (!closestEnemy)
			{
				var workingFactories:Vector.<Factory> = new Vector.<Factory>();
				var factories:Vector.<Factory> = factory.complex.enemyComplex.factories;
				var factoriesLength:int = factories.length;
				
				for (var j:int = 0; j < factoriesLength; j++) 
				{
					var factory:Factory = factories[j];
					if (!factory.halted)
					{
						workingFactories.push(factory);
					}
				}
				
				var workingFactoriesLength:int = workingFactories.length;
				if(workingFactoriesLength)
				{
					closestEnemy = workingFactories[int(Math.random() * workingFactoriesLength)];
				}
				else
				{
					closestEnemy = factories[int(Math.random() * factoriesLength)];
				}
			}
			
			return closestEnemy;
		}
		
		private function engageEnemy():Boolean
		{
			var distanceX:Number = _enemy.x - x;
			var distanceY:Number = _enemy.y - y;
			var squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
			
			return squareDistance <= _squareFireRange;
		}
		
		protected function fire():void
		{
			_reloading = true;
			
			var bulletClass:Bullet = new _bulletClass(_enemy, firePower);
			
			bulletClass.x = x;
			bulletClass.y = y;
			
			gamePlayService.addBullet(bulletClass);
		}
		
		override public function hit(power:Number):void
		{
			super.hit(power);
			
			var damage:Number = power - armor;
			if (damage < 1)
			{
				damage = 1;
			}
			
			health -= damage;
			
			if (health <= 0)
			{
				die();
			}
		}
		
		override public function die():void
		{
			super.die();
			
			factory.complex.destroyUnit(this);
		}
		
		public function setup(health:Number, armor:Number, speed:Number, firePower:Number, fireRate:Number, fireRange:Number):void 
		{
			this.health = health;
			this.armor = armor;
			this.speed = speed;
			this.firePower = firePower;
			this.fireRate = fireRate;
			this.fireRange = fireRange;
			
			_reloadDelay = 1 / (fireRate / 10);
			_reloadTime = 0;
			
			_squareSearchRange = (fireRange * 2) * (fireRange * 2);
			_squareFireRange = fireRange * fireRange;
		}
	}
}