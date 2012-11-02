package nemostein.games.geocontact.theriot
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import nemostein.framework.dragonfly.Core;
	import nemostein.framework.dragonfly.Game;
	import nemostein.framework.dragonfly.plugins.shadowedtext.ShadowedText;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	
	public class TheRiot extends Game
	{
		public function TheRiot()
		{
			super(900, 600);
		}
		
		override public function start(stage:Stage, container:DisplayObjectContainer = null):void
		{
			super.start(stage, container);
			
			var gamePlay:GamePlay = new GamePlay();
			add(gamePlay);
		}
	}
}