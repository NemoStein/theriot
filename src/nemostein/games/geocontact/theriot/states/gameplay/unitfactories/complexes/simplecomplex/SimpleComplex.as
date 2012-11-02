package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex 
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.Bar;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.framework.dragonfly.io.Keys;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory.SimpleFactory;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayService;
	
	public class SimpleComplex extends Complex
	{
		public function SimpleComplex(ai:Boolean = false) 
		{
			super(ai);
		}
		
		override protected function initialize():void 
		{
			energyLimit = 500;
			chargeRate = 100;
			
			super.initialize();
			
			if (!ai)
			{
				drawRectangle(50, 50, 0xff550000);
				x = 100;
			}
			else
			{
				drawRectangle(50, 50, 0xff000055);
				x = 800;
			}
			
			alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
			
			var entity:Entity = new Entity();
			entity.drawRectangle(80, 7, 0xff4466aa);
			
			var bar:Bar = new Bar(entity, getEnergy, getEnergyLimit);
			
			bar.x = -40;
			bar.y = 30;
			
			add(bar);
		}
		
		private function getEnergy():Number 
		{
			return energy;
		}
		
		private function getEnergyLimit():Number 
		{
			return energyLimit;
		}
	}
}