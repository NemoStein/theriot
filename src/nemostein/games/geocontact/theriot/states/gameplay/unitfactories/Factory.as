package nemostein.games.geocontact.theriot.states.gameplay.unitfactories
{
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayScreen;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.stats.FactoryStats;
	import nemostein.utils.ErrorUtils;
	
	public class Factory
	{
		public var stats:FactoryStats;
		
		private var _complex:Complex;
		private var _name:String;
		private var _dependency:Factory;
		
		private var _assemblyReady:Boolean;
		private var _assemblyTime:Number;
		private var _assembyDelay:Number;
		
		private var _enabled:Boolean;
		
		public function Factory(complex:Complex, name:String, dependency:Factory = null)
		{
			_complex = complex;
			_name = name;
			
			if(dependency)
			{
				_dependency = dependency;
			}
			else
			{
				enable();
			}
			
			_assembyDelay = 0;
			_assemblyTime = 0;
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
				
				if (_assemblyReady && _complex.drain(stats.assembyCost.value))
				{
					GamePlayScreen.service.addUnit(new unitClass(this));
					
					_assemblyReady = false;
				}
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
			return _complex.ai;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		protected function get unitClass():Class
		{
			throw ErrorUtils.abstractMethod(this, "Factory", "unitClass");
		}
		
		public function enable():void
		{
			_enabled = true;
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
	}
}