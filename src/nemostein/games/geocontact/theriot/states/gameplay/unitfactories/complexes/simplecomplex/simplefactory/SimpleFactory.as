package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory
{
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Factory;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.FactoryStats;
	
	public class SimpleFactory extends Factory
	{
		public function SimpleFactory(complex:Complex)
		{
			super(complex);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			stats = new FactoryStats();
			
			stats.assembyCost = 5;
			stats.assembyRate = 70;
			stats.unitHealth = 40;
			stats.unitArmor = 5;
			stats.unitSpeed = 30;
			stats.unitPower = 12;
			stats.unitRange = 125;
			stats.unitRate = 100;
			
			stats.assembyCost *= Math.random() * 0.3 + 0.85;
			stats.assembyRate *= Math.random() * 0.3 + 0.85;
			stats.unitHealth *= Math.random() * 0.3 + 0.85;
			stats.unitArmor *= Math.random() * 0.3 + 0.85;
			stats.unitSpeed *= Math.random() * 0.3 + 0.85;
			stats.unitPower *= Math.random() * 0.3 + 0.85;
			stats.unitRange *= Math.random() * 0.3 + 0.85;
			stats.unitRate *= Math.random() * 0.3 + 0.85;
		}
		
		override protected function get unitClass():Class
		{
			return SimpleUnit;
		}
	}
}