package nemostein.games.geocontact.theriot
{
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.games.geocontact.theriot.assets.AssetCursor;
	
	public class Cursor extends Entity
	{
		static public const DEFAULT:String = "default";
		
		override protected function initialize():void
		{
			super.initialize();
			
			draw(new AssetCursor().bitmapData);
			width = 22;
			
			addAnimation(DEFAULT, [0, 1, 2, 3], 8);
			playAnimation(DEFAULT);
		}
	}
}