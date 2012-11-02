package nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.factory 
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.plugins.shadowedtext.ShadowedText;
	import nemostein.games.geocontact.theriot.assets.upgradewheel.AssetUpgradeWheelFactorySelector;
	import nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.WheelMenu;

	public class FactorySelectorWheel extends WheelMenu
	{
		override protected function initialize():void 
		{
			fields =
			{
				"factories": new ShadowedText("Factories"),
				"units": new ShadowedText("Units")
			};
			
			fieldsOrder =
			[
				"factories",
				"units"
			];
			
			step = Math.PI;
			offset = Math.PI / 2;
			radius = 53;
			
			super.initialize();
			
			draw(new AssetUpgradeWheelFactorySelector().bitmapData);
			alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
		}
	}
}