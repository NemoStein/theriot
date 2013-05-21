package nemostein.games.geocontact.theriot.states.loadgame 
{
	import nemostein.games.geocontact.theriot.states.levelselect.LevelSelectScreen;
	import nemostein.games.geocontact.theriot.states.Screen;
	import nemostein.games.geocontact.theriot.states.start.StartScreen;
	import nemostein.framework.dragonfly.modules.uihelper.LabelledButton;
	import nemostein.framework.dragonfly.modules.uihelper.ScreenTitle;
	
	public class LoadGameScreen extends Screen 
	{
		
		override protected function initialize():void
		{
			super.initialize();
			
			add(new ScreenTitle("Star / Continue"));
			
			add(new LabelledButton("Save 1", 50, 50, onlevelSelectButtonExecute));
			add(new LabelledButton("Save 2", 50, 100, onlevelSelectButtonExecute));
			add(new LabelledButton("Save 3", 50, 150, onlevelSelectButtonExecute));
			add(new LabelledButton("Back to Start", 50, 500, onBackButtonExecute));
		}
		
		private function onlevelSelectButtonExecute():void
		{
			service.load(service.getScreen(LevelSelectScreen));
		}
		
		private function onBackButtonExecute():void
		{
			service.load(service.getScreen(StartScreen));
		}
	}
}