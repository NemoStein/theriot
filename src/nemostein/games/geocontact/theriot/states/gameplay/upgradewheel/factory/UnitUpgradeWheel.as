package nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.factory 
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.plugins.shadowedtext.ShadowedText;
	import nemostein.games.geocontact.theriot.assets.upgradewheel.AssetUpgradeWheelUnits;
	import nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.WheelMenu;
	
	public class UnitUpgradeWheel extends WheelMenu
	{
		override protected function initialize():void 
		{
			fields =
			{
				"botFirePower": new ShadowedText("Power\n0"),
				"botFireRate": new ShadowedText("Rate\n0"),
				"botFireRange": new ShadowedText("Range\n0"),
				"botSpeed": new ShadowedText("Speed\n0"),
				"botHealth": new ShadowedText("Health\n0"),
				"botArmor": new ShadowedText("Armor\n0")
			};
			
			fieldsOrder =
			[
				"botFirePower",
				"botFireRate",
				"botFireRange",
				"botSpeed",
				"botHealth",
				"botArmor"
			];
			
			step = Math.PI / 3;
			offset = step / 2;
			radius = 53;
			
			super.initialize();
			
			draw(new AssetUpgradeWheelUnits().bitmapData);
			alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
		}
	}
}