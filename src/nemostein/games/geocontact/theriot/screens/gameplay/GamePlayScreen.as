package nemostein.games.geocontact.theriot.screens.gameplay
{
	import flash.geom.Rectangle;
	import nemostein.framework.dragonfly.Core;
	import nemostein.framework.dragonfly.modules.uihelper.LabelledButton;
	import nemostein.framework.dragonfly.modules.uihelper.ScreenTitle;
	import nemostein.games.geocontact.theriot.screens.defeat.DefeatScreen;
	import nemostein.games.geocontact.theriot.screens.gameplay.leveltest.LevelTest;
	import nemostein.games.geocontact.theriot.screens.levelselect.LevelSelectScreen;
	import nemostein.games.geocontact.theriot.screens.Screen;
	import nemostein.games.geocontact.theriot.screens.victory.VictoryScreen;
	
	public class GamePlayScreen extends Screen
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
			
			//add(new ScreenTitle("GamePlayScreen"));
			//
			//add(new LabelledButton("Victory", 50, 50, onVictoryExecute));
			//add(new LabelledButton("Defeat", 200, 50, onDefeatExecute));
			//add(new LabelledButton("Back to Level Select", 50, 500, onBackButtonExecute));
		}
		
		//private function onVictoryExecute():void
		//{
			//Screen.service.load(Screen.service.getScreen(VictoryScreen));
		//}
		//
		//private function onDefeatExecute():void
		//{
			//Screen.service.load(Screen.service.getScreen(DefeatScreen));
		//}
		//
		//private function onBackButtonExecute():void
		//{
			//Screen.service.load(Screen.service.getScreen(LevelSelectScreen));
		//}
		
		override public function enter(lastScreen:Screen, data:Object):void
		{
			service.loadLevel(LevelTest);
			
			super.enter(lastScreen, data);
		}
		
		override protected function update():void
		{
			_battleElapsedTime += elapsed;
			
			super.update();
		}
		
		override public function getBounds():Rectangle 
		{
			var levelBounds:Rectangle = service.level.levelBounds.clone();
			levelBounds.x -= 186;
			levelBounds.width += 186;
			
			return levelBounds;
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