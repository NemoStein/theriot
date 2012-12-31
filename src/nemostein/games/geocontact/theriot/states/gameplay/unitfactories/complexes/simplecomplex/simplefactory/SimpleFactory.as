package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory
{
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Factory;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.FactoryStats;
	
	public class SimpleFactory extends Factory
	{
		public function SimpleFactory(complex:Complex)
		{
			super(complex, "C");
			
			stats = new FactoryStats();
			
			stats.assembyCost = 5;
			stats.assembyRate = 10;
			stats.unitHealth = 10;
			stats.unitArmor = 0;
			stats.unitSpeed = 35;
			stats.unitPower = 2;
			stats.unitRange = 85;
			stats.unitRate = 50;
			
			//stats.assembyCost *= Math.random() * 0.8 + 0.6;
			//stats.assembyRate *= Math.random() * 0.8 + 0.6;
			//stats.unitHealth *= Math.random() * 0.8 + 0.6;
			//stats.unitArmor *= Math.random() * 0.8 + 0.6;
			//stats.unitSpeed *= Math.random() * 0.8 + 0.6;
			//stats.unitPower *= Math.random() * 0.8 + 0.6;
			//stats.unitRange *= Math.random() * 0.8 + 0.6;
			//stats.unitRate *= Math.random() * 0.8 + 0.6;
		}
		
		override protected function get unitClass():Class
		{
			return SimpleUnit;
		}
	}
}