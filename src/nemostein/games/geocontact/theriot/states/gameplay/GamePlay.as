package nemostein.games.geocontact.theriot.states.gameplay 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import nemostein.framework.dragonfly.Container;
	import nemostein.framework.dragonfly.Core;
	import nemostein.framework.dragonfly.io.Keys;
	import nemostein.framework.dragonfly.io.MouseAware;
	
	public class GamePlay extends Container implements MouseAware
	{
		//{ static
		
		static private var _gamePlayService:GamePlayService;
		
		static public function get service():GamePlayService
		{
			return _gamePlayService;
		}
		
		//}
		
		private var _scrolling:Boolean;
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_gamePlayService = new GamePlayService(this, input);
		}
		
		override protected function update():void 
		{
			if (_scrolling)
			{
				var mouseDelta:Point = input.mouseDelta;
				
				camera.x -= mouseDelta.x;
				camera.y -= mouseDelta.y;
			}
			
			super.update();
		}
		
		public function onMouseDown(key:int, mouse:Point):Boolean 
		{
			if (key == Keys.LEFT_MOUSE)
			{
				_scrolling = true;
				return false;
			}
			
			return true;
		}
		
		public function onMouseUp(key:int, mouse:Point):Boolean 
		{
			if (key == Keys.LEFT_MOUSE)
			{
				_scrolling = false;
				return false;
			}
			
			return true;
		}
		
		public function get bounds():Rectangle 
		{
			return Core.bounds;
		}
	}
}