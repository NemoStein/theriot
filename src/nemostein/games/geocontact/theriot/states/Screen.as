package nemostein.games.geocontact.theriot.states 
{
	import nemostein.framework.dragonfly.modules.container.Container;
	
	public class Screen extends Container 
	{
		static private var _service:ScreenService = new ScreenService();
		static public function get service():ScreenService 
		{
			return _service;
		}
		
		public function enter(lastScreen:Screen, data:Object):void 
		{
			
		}
		
		public function exit(nextScreen:Screen):Boolean
		{
			return true;
		}
		
		public function get forceCreation():Boolean 
		{
			return false;
		}
	}
}