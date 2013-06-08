package nemostein.games.geocontact.theriot.screens.gameplay.unitfactories
{
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.games.geocontact.theriot.screens.gameplay.GamePlayScreen;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.complexes.simplecomplex.simplefactory.SimpleFactory;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats.ComplexStats;
	
	public class Complex extends Entity
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
			
			_metal = 0;
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
		
		protected function addFactory(name:String, FactoryClass:Class, dependency:Factory = null):Factory
		{
			var factory:Factory = new FactoryClass();
			
			factory.name = name;
			factory.complex = this;
			factory.dependency = dependency;
			
			_factories.push(factory);
			
			return factory;
		}
		
		protected function addFactorySprite(FactoryDataClass:Class, x:int, y:int, factory:Factory):void 
		{
			var entity:Entity = new Entity(new FactoryDataClass());
			
			entity.x = x;
			entity.y = y;
			entity.die();
			
			factory.addSprite(entity);
			add(entity);
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
				GamePlayScreen.service.complexDestroyed(this);
				
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
		
		public function addMetal(metal:int, pure:Boolean = false):void
		{
			_metal += metal;
		}
	}
}