package nemostein.games.geocontact.theriot.states.gameplay.unitfactories
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.framework.dragonfly.io.MouseAware;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	
	public class Complex extends Entity implements MouseAware
	{
		public var stats:ComplexStats;
		
		private var _ai:Boolean;
		
		private var _enery:Number;
		private var _factories:Vector.<Factory>;
		private var _dead:Boolean;
		
		override protected function initialize():void
		{
			super.initialize();
			
			_enery = 0;
			_factories = new Vector.<Factory>(6, true);
		}
		
		override protected function update():void
		{
			if (_enery < stats.energyLimit)
			{
				_enery += stats.energyRecharge * time;
				
				if (_enery > stats.energyLimit)
				{
					_enery = stats.energyLimit;
				}
			}
			
			for (var i:int = 0; i < _factories.length; ++i) 
			{
				var factory:Factory = _factories[i];
				if(factory)
				{
					factory.update(time);
				}
			}
			
			super.update();
		}
		
		protected function addFactory(factory:Factory, slot:int):void
		{
			_factories[slot] = factory;
		}
		
		public function drain(enery:Number):Boolean
		{
			if (_enery >= enery)
			{
				_enery -= enery;
				
				return true;
			}
			
			return false;
		}
		
		public function hit(power:Number):void 
		{
			_enery -= power;
			
			if (_enery <= 0)
			{
				_enery = 0;
				die();
			}
		}
		
		override public function die():void 
		{
			if (!_dead)
			{
				_dead = true;
				GamePlay.service.complexDestroyed(this);
				
				for each (var factory:Factory in _factories) 
				{
					factory.destroy();
				}
				
				super.die();
			}
		}
		
		public function controlledByAI():void
		{
			_ai = true;
		}
		
		public function get ai():Boolean
		{
			return _ai;
		}
		
		public function get factories():Vector.<Factory> 
		{
			return _factories;
		}
		
		public function getEnergy():Number
		{
			return _enery;
		}
		
		public function getEnergyLimit():Number
		{
			return stats.energyLimit;
		}
		
		public function onMouseDown(key:int, mouse:Point):Boolean
		{
			return true;
		}
		
		public function onMouseUp(key:int, mouse:Point):Boolean
		{
			return true;
		}
	}
}