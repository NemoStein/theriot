package nemostein.games.geocontact.theriot.states.start
{
	import nemostein.framework.dragonfly.modules.uihelper.LabelledButton;
	import nemostein.framework.dragonfly.modules.uihelper.ScreenTitle;
	import nemostein.games.geocontact.theriot.states.credits.CreditsScreen;
	import nemostein.games.geocontact.theriot.states.loadgame.LoadGameScreen;
	import nemostein.games.geocontact.theriot.states.Screen;
	public class StartScreen extends Screen
	{
		override protected function initialize():void
		{
			super.initialize();
			
			add(new ScreenTitle("Start Screen"));
			
			add(new LabelledButton("Start / Continue", 50, 50, onLoadGameButtonExecute));
			add(new LabelledButton("Credits", 200, 50, onCreditsButtonExecute));
		}
		
		private function onLoadGameButtonExecute():void
		{
			service.load(service.getScreen(LoadGameScreen));
		}
		
		private function onCreditsButtonExecute():void
		{
			service.load(service.getScreen(CreditsScreen));
		}
	}
}