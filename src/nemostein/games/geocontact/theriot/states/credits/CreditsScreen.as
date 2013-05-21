package nemostein.games.geocontact.theriot.states.credits
{
	import nemostein.games.geocontact.theriot.states.Screen;
	import nemostein.games.geocontact.theriot.states.start.StartScreen;
	import nemostein.framework.dragonfly.modules.uihelper.LabelledButton;
	import nemostein.framework.dragonfly.modules.uihelper.ScreenTitle;
	
	public class CreditsScreen extends Screen
	{
		
		override protected function initialize():void
		{
			super.initialize();
			
			add(new ScreenTitle("Credits"));
			
			add(new LabelledButton("Back to Start", 50, 500, onBackButtonExecute));
		}
		
		private function onBackButtonExecute():void
		{
			service.load(service.getScreen(StartScreen));
		}
	}
}