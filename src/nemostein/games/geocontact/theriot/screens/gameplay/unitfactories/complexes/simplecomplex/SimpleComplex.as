package nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.complexes.simplecomplex
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.modules.container.entity.AnchorAlign;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.complexes.complex01.Complex01A;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.complexes.complex01.Complex01A1;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.complexes.complex01.Complex01B;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.complexes.complex01.Complex01B1;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.complexes.complex01.Complex01B1OverB;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.complexes.complex01.Complex01B2;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.complexes.complex01.Complex01B2OverB;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.complexes.complex01.Complex01BOverC;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.complexes.complex01.Complex01C;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.complexes.simplecomplex.simplefactory.SimpleFactory;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.Factory;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats.ComplexStats;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats.LinearStats;
	
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
			
			var factoryC:Factory = addFactory("C", SimpleFactory);
			var factoryA:Factory = addFactory("A", SimpleFactory, factoryC);
			var factoryA1:Factory = addFactory("A1", SimpleFactory, factoryA);
			var factoryB:Factory = addFactory("B", SimpleFactory, factoryC);
			var factoryB1:Factory = addFactory("B1", SimpleFactory, factoryB);
			var factoryB2:Factory = addFactory("B2", SimpleFactory, factoryB);
			
			addFactorySprite(Complex01B2,      143,   0, factoryB2);
			addFactorySprite(Complex01B1,        3,  24, factoryB1);
			addFactorySprite(Complex01B,        76,  47, factoryB);
			addFactorySprite(Complex01B2OverB, 156,  47, factoryB2);
			addFactorySprite(Complex01B1OverB,  82, 109, factoryB1);
			addFactorySprite(Complex01C,        76, 104, factoryC);
			addFactorySprite(Complex01BOverC,  106, 104, factoryB);
			addFactorySprite(Complex01A,         0, 116, factoryA);
			addFactorySprite(Complex01A1,        3, 174, factoryA1);
		}
	}
}
