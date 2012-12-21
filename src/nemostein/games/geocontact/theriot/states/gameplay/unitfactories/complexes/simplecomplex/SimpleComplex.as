package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex
{
	import nemostein.games.geocontact.theriot.states.gameplay.Level;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory.SimpleFactory;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.ComplexStats;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.FactoryStats;
	
	public class SimpleComplex extends Complex
	{
		override protected function initialize():void 
		{
			super.initialize();
			
			stats = new ComplexStats();
			
			stats.energyLimit = 100;
			stats.energyRecharge = 25;
			stats.turretPower = 35;
			stats.turretRange = 200;
			stats.turretRate = 125;
			
			stats.energyLimit *= Math.random() * 0.3 + 0.85;
			stats.energyRecharge *= Math.random() * 0.3 + 0.85;
			stats.turretPower *= Math.random() * 0.3 + 0.85;
			stats.turretRange *= Math.random() * 0.3 + 0.85;
			stats.turretRate *= Math.random() * 0.3 + 0.85;
			
			addFactory(new SimpleFactory(this));
		}
	}
}