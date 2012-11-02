package nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.complex 
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.plugins.shadowedtext.ShadowedText;
	import nemostein.games.geocontact.theriot.assets.upgradewheel.AssetUpgradeWheelComplexSelector;
	import nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.WheelMenu;
	
	public class ComplexUpgradeWheel extends WheelMenu
	{
		override protected function initialize():void 
		{
			fields =
			{
				"chargeRate": new ShadowedText("Charge\nRate\n0"),
				"energyLimit": new ShadowedText("Energy\nLimit\n0"),
				"createFactory": new ShadowedText("Create Factory")
			};
			
			fieldsOrder =
			[
				"chargeRate",
				"energyLimit",
				"createFactory"
			];
			
			step = Math.PI / 1.5;
			offset = step / 4;
			radius = 47;
			
			super.initialize();
			
			draw(new AssetUpgradeWheelComplexSelector().bitmapData);
			alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
		}
	}
}