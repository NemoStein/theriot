package nemostein.games.geocontact.theriot.screens.gameplay.unitfactories
{
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.games.geocontact.theriot.screens.gameplay.GamePlayScreen;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats.FactoryStats;
	import nemostein.utils.ErrorUtils;
	
	public class Factory
	{
		public var name:String;
		public var stats:FactoryStats;
		public var complex:Complex;
		
		private var _dependency:Factory;
		
		private var _assemblyReady:Boolean;
		private var _assemblyTime:Number;
		private var _assembyDelay:Number;
		
		private var _enabled:Boolean;
		private var _sprites:Vector.<Entity>;
		
		public function Factory()
		{
			_assembyDelay = 0;
			_assemblyTime = 0;
			
			_sprites = new Vector.<Entity>();
		}
		
		public function update(time:Number):void
		{
			if (_enabled)
			{
				if (!_assemblyReady)
				{
					_assemblyTime += time;
					
					if (_assemblyTime >= _assembyDelay)
					{
						_assemblyTime -= _assembyDelay;
						_assembyDelay = 100 / stats.assembyRate.value;
						_assemblyReady = true;
					}
				}
				
				if (_assemblyReady && complex.drain(stats.assembyCost.value))
				{
					GamePlayScreen.service.addUnit(new unitClass(this));
					
					_assemblyReady = false;
				}
			}
			else if (!_dependency)
			{
				enable();
			}
		}
		
		public function destroy():void
		{
			
		}
		
		public function getAssemblyTime():Number
		{
			return _assemblyTime;
		}
		
		public function getAssemblyDelay():Number
		{
			return 100 / stats.assembyRate.value;
		}
		
		public function get ai():Boolean
		{
			return complex.ai;
		}
		
		protected function get unitClass():Class
		{
			throw ErrorUtils.abstractMethod(this, "Factory", "unitClass");
		}
		
		public function enable():void
		{
			_enabled = true;
			
			for each (var sprite:Entity in _sprites) 
			{
				sprite.show();
			}
		}
		
		public function addSprite(sprite:Entity):void 
		{
			_sprites.push(sprite);
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function get unlocked():Boolean
		{
			if (!_dependency)
			{
				return true;
			}
			
			return _dependency._enabled;
		}
		
		public function get dependency():Factory 
		{
			return _dependency;
		}
		
		public function set dependency(value:Factory):void 
		{
			_dependency = value;
		}
	}
}