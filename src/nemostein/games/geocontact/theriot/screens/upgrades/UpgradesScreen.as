package nemostein.games.geocontact.theriot.screens.upgrades 
{
	import nemostein.framework.dragonfly.modules.uihelper.LabelledButton;
	import nemostein.framework.dragonfly.modules.uihelper.ScreenTitle;
	import nemostein.games.geocontact.theriot.screens.levelselect.LevelSelectScreen;
	import nemostein.games.geocontact.theriot.screens.Screen;
	
	public class UpgradesScreen extends Screen 
	{
		override protected function initialize():void
		{
			super.initialize();
			
			add(new ScreenTitle("Upgrades"));
			
			add(new LabelledButton("Back to Level Select", 50, 500, onBackButtonExecute));
		}
		
		private function onBackButtonExecute():void
		{
			service.load(service.getScreen(LevelSelectScreen));
		}
	}
}