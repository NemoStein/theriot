package nemostein.games.geocontact.theriot.states.levelselect
{
	import nemostein.games.geocontact.theriot.states.achievements.AchievementsScreen;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayScreen;
	import nemostein.games.geocontact.theriot.states.loadgame.LoadGameScreen;
	import nemostein.games.geocontact.theriot.states.Screen;
	import nemostein.games.geocontact.theriot.states.start.StartScreen;
	import nemostein.games.geocontact.theriot.states.upgrades.UpgradesScreen;
	import nemostein.framework.dragonfly.modules.uihelper.LabelledButton;
	import nemostein.framework.dragonfly.modules.uihelper.ScreenTitle;
	
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
	}
}