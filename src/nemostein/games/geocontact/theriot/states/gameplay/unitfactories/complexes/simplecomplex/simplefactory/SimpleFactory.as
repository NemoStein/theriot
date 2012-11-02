package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.Bar;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Factory;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayService;
	
	public class SimpleFactory extends Factory
	{
		public function SimpleFactory(complex:Complex)
		{
			super(complex, SimpleUnit);
		}
		
		override protected function initialize():void
		{
			energyLimit = 250;
			chargeRate = 150;
			
			firePower = 500;
			fireRate = 10;
			fireRange = 150;
			fireCost = 200;
			
			assemblyRate = 5;
			assemblyCost = 75;
			
			unitHealth = 20;
			unitArmor = 4;
			unitSpeed = 50;
			unitFirePower = 10;
			unitFireRate = 10;
			unitFireRange = 75;
			
			//energyLimit *= Math.random() + 0.5;
			//chargeRate *= Math.random() + 0.5;
			//
			//firePower *= Math.random() + 0.5;
			//fireRate *= Math.random() + 0.5;
			//fireRange *= Math.random() + 0.5;
			//fireCost *= Math.random() + 0.5;
			//
			//assemblyRate *= Math.random() + 0.5;
			//assemblyCost *= Math.random() + 0.5;
			
			unitHealth *= Math.random() + 0.5;
			unitArmor *= Math.random() + 0.5;
			unitSpeed *= Math.random() + 0.5;
			unitFirePower *= Math.random() + 0.5;
			unitFireRate *= Math.random() + 0.5;
			unitFireRange *= Math.random() + 0.5;
			
			super.initialize();
			
			if (!complex.ai)
			{
				drawRectangle(20, 20, 0xffaa0000);
			}
			else
			{
				drawRectangle(20, 20, 0xff0000aa);
			}
			
			alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
			
			var entity:Entity = new Entity();
			entity.drawRectangle(50, 7, 0xff4466aa);
			
			var bar:Bar = new Bar(entity, getEnergy, getEnergyLimit);
			
			bar.x = -25;
			bar.y = 10;
			
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