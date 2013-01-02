package nemostein.games.geocontact.theriot.states.gameplay 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import nemostein.framework.dragonfly.Core;
	import nemostein.framework.dragonfly.modules.container.Container;
	import nemostein.framework.dragonfly.modules.io.Keys;
	import nemostein.framework.dragonfly.modules.io.MouseAware;
	
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
		private var _battleElapsedTime:int;
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_gamePlayService = new GamePlayService(this, input);
		}
		
		override protected function update():void 
		{
			_battleElapsedTime += elapsed;
			
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
		
		public function targetPlayerComplex():void 
		{
			game.cameraLookAt(service.complexPlayer.x, service.complexPlayer.y);
		}
		
		public function resetBattleTimer():void 
		{
			_battleElapsedTime = 0;
		}
		
		public function get battleElapsedTime():int
		{
			return _battleElapsedTime;
		}
		
		public function get bounds():Rectangle 
		{
			return Core.bounds;
		}
	}
}