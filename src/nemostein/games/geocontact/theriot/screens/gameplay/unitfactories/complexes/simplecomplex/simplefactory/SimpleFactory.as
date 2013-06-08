package nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.complexes.simplecomplex.simplefactory
{
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.Factory;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats.FactoryStats;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats.LinearStats;
	
	public class SimpleFactory extends Factory
	{
		public function SimpleFactory()
		{
			stats = new FactoryStats();
			
			stats.assembyCost = new LinearStats(5, 10, 1.1);
			stats.assembyRate = new LinearStats(10, 10, 1.1);
			stats.unitHealth = new LinearStats(10, 10, 1.1);
			stats.unitArmor = new LinearStats(1, 10, 1.1);
			stats.unitSpeed = new LinearStats(35, 10, 1.1);
			stats.unitPower = new LinearStats(2, 10, 1.1);
			stats.unitRange = new LinearStats(85, 10, 1.1);
			stats.unitRate = new LinearStats(50, 10, 1.1);
		}
		
		override protected function get unitClass():Class
		{
			return SimpleUnit;
		}
	}
}