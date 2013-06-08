package nemostein.games.geocontact.theriot
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import nemostein.framework.dragonfly.Game;
	import nemostein.games.geocontact.theriot.assets.Neuropol;
	import nemostein.games.geocontact.theriot.screens.Screen;
	import nemostein.games.geocontact.theriot.screens.ScreenService;
	import nemostein.games.geocontact.theriot.screens.start.StartScreen;
	
	public class TheRiot extends Game
	{
		public function TheRiot()
		{
			super(900, 600);
		}
		
		override public function start(stage:Stage, container:DisplayObjectContainer = null):void
		{
			super.start(stage, container);
			
			registerFont(Neuropol);
			changeCursor(new Cursor());
			
			var screenService:ScreenService = Screen.service;
			add(screenService.container);
			
			screenService.load(new StartScreen());
		}
	}
}