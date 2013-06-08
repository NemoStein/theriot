package nemostein.games.geocontact.theriot.screens.start
{
	import nemostein.framework.dragonfly.modules.container.entity.AnchorAlign;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.games.geocontact.theriot.assets.screens.start.StartScreenLogoPlanet;
	
	internal class Planet extends Entity
	{
		override protected function initialize():void
		{
			super.initialize();
			
			draw(new StartScreenLogoPlanet());
			
			var moon:Moon = new Moon();
			
			moon.x = -55;
			moon.y = -17;
			
			add(moon);
		}
	}
}