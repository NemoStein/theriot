package nemostein.games.geocontact.theriot.screens 
{
	import flash.geom.Rectangle;
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
			var screenBounds:Rectangle = getBounds();
			
			bounds.x = screenBounds.x;
			bounds.y = screenBounds.y;
			bounds.width = screenBounds.width;
			bounds.height = screenBounds.height;
		}
		
		public function exit(nextScreen:Screen):Boolean
		{
			return true;
		}
		
		public function getBounds():Rectangle
		{
			return new Rectangle(0, 0, 900, 600);
		}
		
		public function get forceCreation():Boolean 
		{
			return false;
		}
	}
}