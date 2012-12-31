package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.ammo 
{
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Ammo;
	
	public class SimpleAmmo extends Ammo 
	{
		override protected function initialize():void 
		{
			super.initialize();
			
			drawRectangle(3, 3, 0xffff0000);
			speed = 500;
		}
	}
}