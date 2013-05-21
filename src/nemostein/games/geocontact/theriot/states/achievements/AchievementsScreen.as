package nemostein.games.geocontact.theriot.states.achievements
{
	import nemostein.framework.dragonfly.modules.uihelper.LabelledButton;
	import nemostein.framework.dragonfly.modules.uihelper.ScreenTitle;
	import nemostein.games.geocontact.theriot.states.levelselect.LevelSelectScreen;
	import nemostein.games.geocontact.theriot.states.Screen;
	
	public class AchievementsScreen extends Screen
	{
		override protected function initialize():void
		{
			super.initialize();
			
			add(new ScreenTitle("Achievements"));
			
			add(new LabelledButton("Back to Level Select", 50, 500, onBackButtonExecute));
		}
		
		private function onBackButtonExecute():void
		{
			service.load(service.getScreen(LevelSelectScreen));
		}
	}
}