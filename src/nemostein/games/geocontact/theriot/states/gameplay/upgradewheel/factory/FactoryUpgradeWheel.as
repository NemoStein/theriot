package nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.factory 
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.plugins.shadowedtext.ShadowedText;
	import nemostein.games.geocontact.theriot.assets.upgradewheel.AssetUpgradeWheelFactory;
	import nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.WheelMenu;
	
	public class FactoryUpgradeWheel extends WheelMenu
	{
		override protected function initialize():void 
		{
			fields =
			{
				"assemblyRate": new ShadowedText("Assembly\nRate\n0"),
				"energyLimit": new ShadowedText("Energy\nLimit\n0"),
				"chargeRate": new ShadowedText("Charge\nRate\n0")
			};
			
			fieldsOrder =
			[
				"assemblyRate",
				"energyLimit",
				"chargeRate"
			];
			
			step = Math.PI / 1.5;
			offset = Math.PI / 2;
			radius = 47;
			
			super.initialize();
			
			draw(new AssetUpgradeWheelFactory().bitmapData);
			alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
		}
	}
}