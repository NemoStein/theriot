package nemostein.games.geocontact.theriot.screens.gameplay.hud
{
	import nemostein.framework.dragonfly.modules.text.ShadowedText;
	import nemostein.games.geocontact.theriot.screens.gameplay.GamePlayScreen;
	
	public class TimeElapsed extends ShadowedText
	{
		public function TimeElapsed()
		{
			super("00:00.000", "Lead III", 8, 0xffc0e5f0);
		}
		
		override protected function update():void
		{
			var timeElapsed:int = GamePlayScreen.service.getBattleElapsedTime();
			
			var minute:String = int(timeElapsed / 1000 / 60).toString();
			var seconds:String = int(timeElapsed / 1000 % 60).toString();
			var miliseconds:String = (timeElapsed % 1000).toString();
			
			while (minute.length < 2)
			{
				minute = "0" + minute;
			}
			
			while (seconds.length < 2)
			{
				seconds = "0" + seconds;
			}
			
			while (miliseconds.length < 3)
			{
				miliseconds = "0" + miliseconds;
			}
			
			text = minute + ":" + seconds + "." + miliseconds;
			
			super.update();
		}
	}
}