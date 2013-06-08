package nemostein.games.geocontact.theriot.screens.start
{
	import nemostein.framework.dragonfly.modules.container.entity.AnchorAlign;
	import nemostein.framework.dragonfly.modules.container.entity.Animation;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.games.geocontact.theriot.assets.screens.start.StartScreenLogoMoon;
	
	internal class Moon extends Entity
	{
		override protected function initialize():void
		{
			super.initialize();
			
			draw(new StartScreenLogoMoon(), 150, 125);
			
			addAnimation("",
			[
				 0,  1,  2,  3,  4,  5,
				 6,  7,  8,  9, 10, 11,
				12, 13, 14, 15, 16, 17,
				18, 19, 20, 21, 22, 23,
				24, 25, 26, 27, 28, 29,
				30, 31, 32, 33, 34, 35
			], 20).play();
		}
	}
}