package nemostein.games.geocontact.theriot.states.gameplay.unitfactories 
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.Container;
	import nemostein.framework.dragonfly.io.Keys;
	import nemostein.framework.dragonfly.io.MouseAware;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory.SimpleFactory;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayService;
	
	public class Complex extends Container implements MouseAware
	{
		public var enemyComplex:Complex;
		public var units:Vector.<Unit>;
		public var factories:Vector.<Factory>;
		
		protected var gamePlayService:GamePlayService;
		
		protected var energy:Number;
		protected var energyLimit:Number;
		protected var chargeRate:Number;
		
		private var _ai:Boolean;
		private var _nextSlot:int;
		private var _slots:Array;
		
		private var _factoryId:int;
		
		public function Complex(ai:Boolean = false) 
		{
			gamePlayService = GamePlay.service;
			
			_ai = ai;
			
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_slots = [];
			for (var i:int = 0; i < 15; i++) 
			{
				_slots[i] = null;
			}
			
			energy = energyLimit;
			
			units = new Vector.<Unit>();
			factories = new Vector.<Factory>();
			
			y = 300;
		}
		
		public function addFactory(factoryClass:Class):void 
		{
			var factory:Factory = new factoryClass(this);
			factory.id = id + ":" + _factoryId++;
			
			var slot:Point = getNextSlot();
			
			factory.x = slot.x;
			factory.y = slot.y;
			
			factories.push(factory);
			gamePlayService.addFactory(factory);
		}
		
		public function destroyFactory(factory:Factory):void 
		{
			var length:int = factories.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var listedFactory:Factory = factories[i];
				if (listedFactory == factory)
				{
					factories.splice(i, 1);
					gamePlayService.removeFactory(factory);
					break;
				}
			}
		}
		
		public function addUnit(unit:Unit):void 
		{
			units.push(unit);
			gamePlayService.addUnit(unit);
		}
		
		public function destroyUnit(unit:Unit):void 
		{
			var length:int = units.length;
			for (var i:int = 0; i < length; ++i) 
			{
				var listedUnit:Unit = units[i];
				if (listedUnit == unit)
				{
					units.splice(i, 1);
					gamePlayService.removeUnit(unit);
					break;
				}
			}
		}
		
		public function drain(charge:Number):Number 
		{
			var result:Number = charge;
			
			if(energy <= charge)
			{
				result = energy;
			}
			
			energy -= result;
			return result;
		}
		
		protected function getNextSlot():Point 
		{
			var slots:Array = [];
			for (var i:int = 0; i < _slots.length; i++) 
			{
				var slot:Object = _slots[i];
				if (slot == null)
				{
					slots.push(i);
				}
			}
			
			var y:int = 200;
			if(ai)
			{
				y = 700;
			}
			
			var slotIndex:int = int(Math.random() * slots.length);
			_slots[slots[slotIndex]] = { };
			
			return new Point(y, slots[slotIndex] * 30 + 75);
		}
		
		override protected function update():void 
		{
			super.update();
			
			var factoriesLenght:int = factories.length;
			var workingFactories:int;
			
			for (var i:int = 0; i < factoriesLenght; i++) 
			{
				var factory:Factory = factories[i];
				if(!factory.halted)
				{
					workingFactories++;
				}
			}
			
			var currentChargeRate:Number = chargeRate / factoriesLenght * workingFactories;
			if (currentChargeRate)
			{
				if(energy < energyLimit)
				{
					energy += currentChargeRate * time;
					
					if (energy > energyLimit)
					{
						energy = energyLimit;
					}
				}
			}
			else if (energy == 0)
			{
				var depletedFactories:int;
				var length:int = factories.length;
				for (var j:int = 0; j < length; j++) 
				{
					var haltedFactory:Factory = factories[j];
					if (!haltedFactory.canWork())
					{
						depletedFactories++;
					}
				}
				
				if (depletedFactories == factoriesLenght)
				{
					// TODO: My enemy won... Announce it
				}
			}
		}
		
		public function onMouseDown(key:int, mouse:Point):Boolean 
		{
			if(isInside(mouse))
			{
				addFactory(SimpleFactory);
				gamePlayService.bringComplexSelectorWheel(this);
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
				"chargeRate": chargeRate
			};
		}
		
		public function get ai():Boolean 
		{
			return _ai;
		}
	}
}