package nemostein.games.geocontact.theriot.states.start
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.games.geocontact.theriot.assets.states.start.AssetStatesStartPlanet;
	
	public class Planet extends Entity
	{
		override protected function initialize():void
		{
			super.initialize();
			
			draw(new AssetStatesStartPlanet().bitmapData);
			alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
			
			var moon:Moon = new Moon();
			
			add(moon);
		}
	}
}