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
			stats.energyRecharge = 15;
			stats.turretPower = 35;
			stats.turretRange = 200;
			stats.turretRate = 125;
			
			stats.energyLimit *= Math.random() * 0.3 + 0.85;
			stats.energyRecharge *= Math.random() * 0.3 + 0.85;
			stats.turretPower *= Math.random() * 0.3 + 0.85;
			stats.turretRange *= Math.random() * 0.3 + 0.85;
			stats.turretRate *= Math.random() * 0.3 + 0.85;
			
			var simpleFactoryC:SimpleFactory = new SimpleFactory(this, "C");
			var simpleFactoryA:SimpleFactory = new SimpleFactory(this, "A", simpleFactoryC);
			var simpleFactoryA1:SimpleFactory = new SimpleFactory(this, "A1", simpleFactoryA);
			var simpleFactoryB:SimpleFactory = new SimpleFactory(this, "B", simpleFactoryC);
			var simpleFactoryB1:SimpleFactory = new SimpleFactory(this, "B1", simpleFactoryB);
			var simpleFactoryB2:SimpleFactory = new SimpleFactory(this, "B2", simpleFactoryB);
			
			simpleFactoryC.enable();
			
			addFactory(simpleFactoryC, 0);
			addFactory(simpleFactoryA, 1);
			addFactory(simpleFactoryA1, 2);
			addFactory(simpleFactoryB, 3);
			addFactory(simpleFactoryB1, 4);
			addFactory(simpleFactoryB2, 5);
		}
	}
}