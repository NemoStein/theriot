package nemostein.games.geocontact.theriot.states.gameplay.unitfactories
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.framework.dragonfly.modules.io.MouseAware;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.stats.ComplexStats;
	
	public class Complex extends Entity implements MouseAware
	{
		public var stats:ComplexStats;
		
		private var _ai:Boolean;
		
		private var _energy:Number;
		private var _factories:Vector.<Factory>;
		private var _dead:Boolean;
		private var _metal:Number;
		
		override protected function initialize():void
		{
			super.initialize();
			
			_metal = 200;
			_energy = 0;
			_factories = new Vector.<Factory>();
		}
		
		override protected function update():void
		{
			if (_energy < stats.energyLimit.value)
			{
				_energy += stats.energyRecharge.value * time;
				
				if (_energy > stats.energyLimit.value)
				{
					_energy = stats.energyLimit.value;
				}
			}
			
			for (var i:int = 0; i < _factories.length; ++i)
			{
				var factory:Factory = _factories[i];
				if (factory)
				{
					factory.update(time);
				}
			}
			
			super.update();
		}
		
		protected function addFactory(factory:Factory):void
		{
			_factories.push(factory);
		}
		
		public function drain(enery:Number):Boolean
		{
			if (_energy >= enery)
			{
				_energy -= enery;
				
				return true;
			}
			
			return false;
		}
		
		public function hit(power:Number):void
		{
			_energy -= power;
			
			if (_energy <= 0)
			{
				_energy = 0;
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
		
		public function get metal():Number
		{
			return _metal;
		}
		
		public function getEnergy():Number
		{
			return _energy;
		}
		
		public function getEnergyLimit():Number
		{
			return stats.energyLimit.value;
		}
		
		public function onMouseDown(key:int, mouse:Point):Boolean
		{
			return true;
		}
		
		public function onMouseUp(key:int, mouse:Point):Boolean
		{
			return true;
		}
		
		public function addMetal(metal:int, pure:Boolean = false):void
		{
			_metal += metal;
		}
	}
}