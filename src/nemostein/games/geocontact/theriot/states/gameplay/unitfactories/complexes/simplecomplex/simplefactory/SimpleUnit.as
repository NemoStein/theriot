package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory
{
	import nemostein.framework.dragonfly.modules.container.entity.AnchorAlign;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.units.AssetStatesGameplayUnits01;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.ammo.SimpleAmmo;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Factory;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Unit;
	
	public class SimpleUnit extends Unit
	{
		public function SimpleUnit(factory:Factory) 
		{
			super(factory);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			draw(new AssetStatesGameplayUnits01().bitmapData, 48, 32, true);
			alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
		}
		
		override protected function get ammoClass():Class
		{
			return SimpleAmmo;
		}
		
		override protected function get unitType():String
		{
			return Unit.GROUND;
		}
	}
}