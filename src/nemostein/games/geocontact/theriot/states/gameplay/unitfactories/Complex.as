package nemostein.games.geocontact.theriot.states.gameplay.unitfactories
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.Bar;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.framework.dragonfly.io.MouseAware;
	import nemostein.games.geocontact.theriot.states.gameplay.Level;
	
	public class Complex extends Entity implements MouseAware
	{
		public var stats:ComplexStats;
		
		private var _ai:Boolean;
		
		private var _enery:Number;
		private var _factories:Vector.<Factory>;
		
		override protected function initialize():void
		{
			super.initialize();
			
			_enery = 0;
			_factories = new Vector.<Factory>();
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
			
			super.update();
		}
		
		protected function addFactory(factory:Factory):void
		{
			_factories.push(factory);
			add(factory);
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
		
		public function controlledByAI():void
		{
			_ai = true;
		}
		
		public function get ai():Boolean
		{
			return _ai;
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