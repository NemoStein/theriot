package nemostein.games.geocontact.theriot.states.gameplay.unitfactories
{
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.framework.dragonfly.io.MouseAware;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.utils.ErrorUtils;
	
	public class Factory extends Entity implements MouseAware
	{
		public var stats:FactoryStats;
		
		private var _complex:Complex;
		
		private var _assemblyReady:Boolean;
		private var _assemblyTime:Number;
		
		public function Factory(complex:Complex)
		{
			_complex = complex;
			
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_assemblyTime = 0;
		}
		
		override protected function update():void
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
			
			super.update();
		}
		
		public function onMouseDown(key:int, mouse:Point):Boolean
		{
			return true;
		}
		
		public function onMouseUp(key:int, mouse:Point):Boolean
		{
			return true;
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
		
		protected function get unitClass():Class
		{
			throw ErrorUtils.abstractMethod(this, "Factory", "unitClass");
		}
	}
}