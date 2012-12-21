package nemostein.games.geocontact.theriot.states.start
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.Animation;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.games.geocontact.theriot.assets.states.start.AssetStatesStartMoon;
	
	public class Moon extends Entity
	{
		static public const DEFAULT:String = "default";
		
		override protected function initialize():void
		{
			super.initialize();
			
			draw(new AssetStatesStartMoon().bitmapData);
			
			width = 150;
			height = 125;
			
			alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
			
			addAnimation(DEFAULT, [0, 1, 2, 3, 4, 5], 12, true, updateAnimation);
			playAnimation(DEFAULT);
		}
		
		private function updateAnimation(animation:Animation, keyframe:int):void
		{
			if (keyframe == 0)
			{
				frame.y += 125;
				
				if (frame.y >= 750)
				{
					frame.y = 0;
				}
			}
		}
	}
}