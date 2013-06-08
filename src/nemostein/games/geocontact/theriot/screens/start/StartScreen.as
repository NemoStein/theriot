package nemostein.games.geocontact.theriot.screens.start
{
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.games.geocontact.theriot.assets.screens.DefaultBackground;
	import nemostein.games.geocontact.theriot.assets.screens.start.CreditsButton;
	import nemostein.games.geocontact.theriot.assets.screens.start.Logo;
	import nemostein.games.geocontact.theriot.assets.screens.start.StartButton;
	import nemostein.games.geocontact.theriot.core.SimpleButton;
	import nemostein.games.geocontact.theriot.screens.credits.CreditsScreen;
	import nemostein.games.geocontact.theriot.screens.loadgame.LoadGameScreen;
	import nemostein.games.geocontact.theriot.screens.Screen;
	
	public class StartScreen extends Screen
	{
		override protected function initialize():void
		{
			super.initialize();
			
			var background:Entity = new Entity(new DefaultBackground());
			var logo:Entity = new Entity(new Logo());
			var planet:Planet = new Planet();
			var startButton:SimpleButton = new SimpleButton(new StartButton(), 170, 50, onLoadGameButtonExecute, 0, 1, 1);
			var creditsButton:SimpleButton = new SimpleButton(new CreditsButton(), 125, 31, onCreditsButtonExecute, 0, 1, 1);
			
			logo.x = 232;
			logo.y = 160;
			
			planet.x = 331;
			planet.y = 140;
			
			startButton.x = 364;
			startButton.y = 395;
			
			creditsButton.x = 387;
			creditsButton.y = 464;
			
			add(background);
			add(logo);
			add(planet);
			add(startButton);
			add(creditsButton);
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