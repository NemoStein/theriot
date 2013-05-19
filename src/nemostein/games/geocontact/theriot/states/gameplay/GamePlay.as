package nemostein.games.geocontact.theriot.states.gameplay
{
	import flash.geom.Rectangle;
	import nemostein.framework.dragonfly.Core;
	import nemostein.framework.dragonfly.modules.container.Container;
	
	public class GamePlay extends Container
	{
		//{ static
		
		static private var _gamePlayService:GamePlayService;
		
		static public function get service():GamePlayService
		{
			return _gamePlayService;
		}
		
		//}
		
		private var _battleElapsedTime:int;
		
		override protected function initialize():void
		{
			super.initialize();
			
			_gamePlayService = new GamePlayService(this, input);
		}
		
		override protected function update():void
		{
			_battleElapsedTime += elapsed;
			
			super.update();
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