package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory 
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Bullet;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Target;
	
	public class SimpleBullet extends Bullet 
	{
		public function SimpleBullet(target:Target, power:Number)
		{
			super(target, power);
		}
		
		override protected function initialize():void 
		{
			speed = 200;
			
			speed *= Math.random() + 0.5;
			
			super.initialize();
			
			drawRectangle(3, 3, 0xff00ff00);
			
			alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
		}
	}
}