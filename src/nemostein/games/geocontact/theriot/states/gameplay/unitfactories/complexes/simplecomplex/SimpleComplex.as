package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex
{
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory.SimpleFactory;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Factory;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.stats.ComplexStats;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.stats.LinearStats;
	
	public class SimpleComplex extends Complex
	{
		override protected function initialize():void
		{
			super.initialize();
			
			stats = new ComplexStats();
			
			stats.energyLimit = new LinearStats(100, 10, 1.1);
			stats.energyRecharge = new LinearStats(15, 10, 1.1);
			stats.turretPower = new LinearStats(35, 10, 1.1);
			stats.turretRange = new LinearStats(200, 10, 1.1);
			stats.turretRate = new LinearStats(125, 10, 1.1);
			
			var factoryC:Factory = new SimpleFactory(this, "C");
			var factoryA:Factory = new SimpleFactory(this, "A", factoryC);
			var factoryA1:Factory = new SimpleFactory(this, "A1", factoryA);
			var factoryB:Factory = new SimpleFactory(this, "B", factoryC);
			var factoryB1:Factory = new SimpleFactory(this, "B1", factoryB);
			var factoryB2:Factory = new SimpleFactory(this, "B2", factoryB);
			
			addFactory(factoryC);
			addFactory(factoryA);
			addFactory(factoryA1);
			addFactory(factoryB);
			addFactory(factoryB1);
			addFactory(factoryB2);
		}
	}
}