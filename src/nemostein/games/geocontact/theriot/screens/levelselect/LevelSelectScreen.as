package nemostein.games.geocontact.theriot.screens.levelselect
{
	import nemostein.framework.dragonfly.modules.uihelper.LabelledButton;
	import nemostein.framework.dragonfly.modules.uihelper.ScreenTitle;
	import nemostein.games.geocontact.theriot.screens.achievements.AchievementsScreen;
	import nemostein.games.geocontact.theriot.screens.gameplay.GamePlayScreen;
	import nemostein.games.geocontact.theriot.screens.Screen;
	import nemostein.games.geocontact.theriot.screens.start.StartScreen;
	import nemostein.games.geocontact.theriot.screens.upgrades.UpgradesScreen;
	import nemostein.games.geocontact.theriot.system.GameData;
	
	public class LevelSelectScreen extends Screen
	{
		override protected function initialize():void
		{
			super.initialize();
			
			add(new ScreenTitle("Level Select"));
			
			add(new LabelledButton("Play", 50, 50, onGamePlayExecute));
			add(new LabelledButton("Upgrade", 200, 50, onUpgradeExecute));
			add(new LabelledButton("Achievements", 350, 50, onBackAchievementsExecute));
			add(new LabelledButton("Back to Start", 50, 500, onBackButtonExecute));
		}
		
		private function onGamePlayExecute():void
		{
			service.load(service.getScreen(GamePlayScreen));
		}
		
		private function onUpgradeExecute():void
		{
			service.load(service.getScreen(UpgradesScreen));
		}
		
		private function onBackAchievementsExecute():void
		{
			service.load(service.getScreen(AchievementsScreen));
		}
		
		private function onBackButtonExecute():void
		{
			service.load(service.getScreen(StartScreen));
		}
		
		override public function enter(lastScreen:Screen, data:Object):void 
		{
			super.enter(lastScreen, data);
			
			var gameData:GameData = GameData.current;
			if (!gameData.level)
			{
				gameData.level = 1;
				
				GameData.current = gameData;
				GameData.saveGame(gameData.slot, gameData);
			}
		}
	}
}