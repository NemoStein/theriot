package nemostein.games.geocontact.theriot.states.gameplay.unitfactories
{
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.framework.dragonfly.io.MouseAware;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.utils.ErrorUtils;
	
	public class Factory
	{
		public var stats:FactoryStats;
		
		private var _complex:Complex;
		private var _name:String;
		
		private var _assemblyReady:Boolean;
		private var _assemblyTime:Number;
		
		public function Factory(complex:Complex, name:String)
		{
			_complex = complex;
			_name = name;
			
			_assemblyTime = 0;
		}
		
		public function update(time:Number):void
		{
			if (!_assemblyReady)
			{
				_assemblyTime += time;
				
				var assembyDelay:Number = 100 / stats.assembyRate;
				
				if (_assemblyTime >= assembyDelay)
				{
					_assemblyTime -= assembyDelay;
					_assemblyReady = true;
				}
			}
			
			if (_assemblyReady && _complex.drain(stats.assembyCost))
			{
				GamePlay.service.addUnit(new unitClass(this));
				
				_assemblyReady = false;
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
			return 100 / stats.assembyRate;
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
	}
}