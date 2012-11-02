package nemostein.games.geocontact.theriot.states.gameplay.unitfactories
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.io.MouseAware;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayService;
	
	public class Factory extends Target implements MouseAware
	{
		public var complex:Complex;
		public var halted:Boolean;
		
		protected var gamePlayService:GamePlayService;
		
		protected var energy:Number;
		protected var energyLimit:Number;
		protected var chargeRate:Number;
		
		protected var firePower:Number;
		protected var fireRate:Number;
		protected var fireRange:Number;
		protected var fireCost:Number;
		
		protected var assemblyRate:Number;
		protected var assemblyCost:Number;
		
		protected var unitHealth:int;
		protected var unitArmor:int;
		protected var unitSpeed:int;
		protected var unitFirePower:int;
		protected var unitFireRate:int;
		protected var unitFireRange:int;
		
		private var _unitClass:Class;
		
		private var _reloading:Boolean;
		private var _reloadDelay:Number;
		private var _reloadTime:Number;
		
		private var _assemblyReady:Boolean;
		private var _assemblyTime:Number;
		private var _assemblyDelay:Number;
		
		private var _unitId:int;
		private var _squareFireRange:Number;
		private var _pendingFire:Boolean;
		
		public function Factory(complex:Complex, unitClass:Class)
		{
			this.complex = complex;
			
			gamePlayService = GamePlay.service;
			
			_unitClass = unitClass;
			
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			relative = false;
			
			energy = energyLimit;
			
			_assemblyDelay = 1 / (assemblyRate / 10);
			_assemblyTime = 0;
			
			_reloadDelay = 1 / (fireRate / 10);
			_reloadTime = 0;
			
			_squareFireRange = fireRange * fireRange;
		}
		
		override protected function update():void
		{
			super.update();
			
			if (energy < energyLimit)
			{
				var charge:Number = chargeRate * time;
				if (halted)
				{
					// TODO: Is it a good metric?
					charge *= 2;
				}
				
				var energyMissing:Number = energyLimit - energy;
				
				if (charge > energyMissing)
				{
					charge = energyMissing;
				}
				
				recharge(complex.drain(charge));
			}
			
			if (!halted)
			{
				if (!_assemblyReady)
				{
					_assemblyTime += time;
					
					if (_assemblyTime >= _assemblyDelay)
					{
						_assemblyTime -= _assemblyDelay;
						_assemblyReady = true;
					}
				}
				else if (energy >= assemblyCost)
				{
					_assemblyReady = false;
					drain(assemblyCost);
					
					// TODO: Get unit from a pool
					var unit:Unit = new _unitClass(this);
					
					unit.setup(unitHealth, unitArmor, unitSpeed, unitFirePower, unitFireRate, unitFireRange);
					
					unit.x = x;
					unit.y = y;
					
					unit.revive();
					unit.id = id + ":" + _unitId++;
					
					complex.addUnit(unit);
				}
			}
			else if (!_pendingFire)
			{
				halted = false;
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
			else if (_pendingFire && energy >= fireCost)
			{
				_pendingFire = false;
				_reloading = true;
				drain(fireCost);
				
				var units:Vector.<Unit> = complex.enemyComplex.units;
				var targets:Vector.<Unit> = new Vector.<Unit>();
				var ratios:Vector.<Number> = new Vector.<Number>();
				
				var unitsLength:int = units.length;
				for (var i:int = 0; i < unitsLength; ++i)
				{
					var target:Unit = units[i];
					if (target.active)
					{
						var distanceX:Number = target.x - x;
						var distanceY:Number = target.y - y;
						var squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
						
						if (squareDistance <= _squareFireRange)
						{
							targets.push(target);
							ratios.push(squareDistance / _squareFireRange);
						}
					}
				}
				
				var targetsLength:int = targets.length;
				for (var j:int = 0; j < targetsLength; ++j)
				{
					var enemy:Unit = targets[j];
					var ratio:Number = ratios[j];
					
					enemy.hit(ratio * firePower);
				}
			}
		
			// TODO: Find a way to defer energy consumption
		}
		
		override public function hit(power:Number):void
		{
			super.hit(power);
			
			drain(power);
			
			halted = true;
			_pendingFire = true;
		}
		
		private function recharge(power:Number):void
		{
			energy += power;
			
			if (energy > energyLimit)
			{
				energy = energyLimit;
			}
		}
		
		private function drain(power:Number):void
		{
			energy -= power;
			
			if (energy < 0)
			{
				energy = 0;
			}
		}
		
		override public function die():void
		{
			super.die();
			
			complex.destroyFactory(this);
		}
		
		public function canWork():Boolean
		{
			return halted && energy >= fireCost || energy >= assemblyCost;
		}
		
		public function onMouseDown(key:int, mouse:Point):Boolean
		{
			if (isInside(mouse))
			{
				gamePlayService.bringFactorySelectorWheel(this);
				return false;
			}
			else
			{
				gamePlayService.closeWheel();
				return true;
			}
		}
		
		public function onMouseUp(key:int, mouse:Point):Boolean
		{
			return true;
		}
		
		public function getCurrentStats():Object
		{
			return {
				"energyLimit": energyLimit,
				"chargeRate": chargeRate,
				"firePower": firePower,
				"fireRate": fireRate,
				"fireRange": fireRange,
				"fireCost": fireCost,
				"assemblyRate": assemblyRate,
				"assemblyCost": assemblyCost,
				"botHealth": unitHealth,
				"botArmor": unitArmor,
				"botSpeed": unitSpeed,
				"botFirePower": unitFirePower,
				"botFireRate": unitFireRate,
				"botFireRange": unitFireRange
			};
		}
	}
}