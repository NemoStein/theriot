package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.Timer;
	import nemostein.framework.dragonfly.Game;
	import nemostein.games.geocontact.theriot.TheRiot;
	import nemostein.intro.IntroSequence;
	import nemostein.utils.MathUtils;
	
	[SWF(width=900,height=600,backgroundColor="#000000",frameRate="30")]
	[Frame(factoryClass="Preloader")]
	
	public class Main extends Sprite
	{
		private var _introSequence:IntroSequence;
		
		public function Main():void
		{
			if (stage)
			{
				onAddedToStage();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
		}
		
		private function onAddedToStage(event:Event = null):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_introSequence = new IntroSequence(onIntroSequenceComplete);
			
			//_introSequence.addIntro(new SponsorIntro());
			//_introSequence.addIntro(new DeveloperIntro());
			//_introSequence.addIntro(new GameIntro());
			
			addChild(_introSequence);
			
			_introSequence.start();
		}
		
		private function onIntroSequenceComplete():void
		{
			removeChild(_introSequence);
			
			var timer:Timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerTimerComplete);
			timer.start();
		}
		
		private function onTimerTimerComplete(event:TimerEvent):void 
		{
			var game:Game = new TheRiot();
			game.start(stage);
			//game.showFps();
		}
	}
}