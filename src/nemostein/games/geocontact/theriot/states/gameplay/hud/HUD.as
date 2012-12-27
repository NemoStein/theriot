package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import nemostein.framework.dragonfly.Entity;
	import nemostein.framework.dragonfly.plugins.shadowedtext.ShadowedText;
	import nemostein.framework.dragonfly.Text;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.AssetStatesGameplayHudBase;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsEnergyLimit;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsEnergyRecharge;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsPower;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsRange;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsRate;
	import nemostein.utils.StringUtils;
	
	public class HUD extends Entity
	{
		override protected function initialize():void
		{
			super.initialize();
			
			setParallax(0, 0);
			
			addBase();
			addOptionsButton();
			addWeather();
			addTimeElapsed();
			addControlBar();
			addMinimap();
			addEnergyBar();
			addScrapsIndicator();
			addComplexUpgrades();
			addTurretUpgrades();
		}
		
		private function addBase():void
		{
			var hudBase:Entity = new Entity();
			hudBase.draw(new AssetStatesGameplayHudBase().bitmapData);
			
			add(hudBase);
		}
		
		private function addOptionsButton():void 
		{
			var optionsButton:OptionsButton = new OptionsButton();
			
			optionsButton.x = 8;
			optionsButton.y = 8;
			
			add(optionsButton);
		}
		
		private function addWeather():void 
		{
			var weatherDisplay:WeatherDisplay = new WeatherDisplay();
			
			weatherDisplay.x = 35;
			weatherDisplay.y = 11;
			
			add(weatherDisplay);
		}
		
		private function addTimeElapsed():void 
		{
			var shadowedText:TimeElapsed = new TimeElapsed();
			
			shadowedText.x = 135;
			shadowedText.y = 22;
			
			add(shadowedText);
		}
		
		private function addControlBar():void 
		{
			var controlBarAllied:ControlBar = new ControlBar();
			var controlBarEnemy:ControlBar = new ControlBar(true);
			
			controlBarAllied.x = 10;
			controlBarAllied.y = 36;
			
			controlBarEnemy.x = 12;
			controlBarEnemy.y = 36;
			
			add(controlBarAllied);
			add(controlBarEnemy);
		}
		
		private function addMinimap():void
		{
			var minimap:Minimap = new Minimap();
			
			minimap.x = 8;
			minimap.y = 48;
			
			add(minimap);
		}
		
		private function addEnergyBar():void
		{
			var energyBar:EnergyBar = new EnergyBar();
			
			energyBar.x = 10;
			energyBar.y = 192;
			
			add(energyBar);
		}
		
		private function addScrapsIndicator():void
		{
			var shadowedText:ShadowedText = new ShadowedText("$" + StringUtils.formatNumber(int(Math.random() * int.MAX_VALUE), ",", "."), "Lead III", 8, 0xffc0e5f0);
			
			shadowedText.x = 48;
			shadowedText.y = 218;
			
			add(shadowedText);
		}
		
		private function addComplexUpgrades():void
		{
			var energyLimitButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsEnergyLimit);
			var energyRechargeButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsEnergyRecharge);
			
			energyLimitButton.x = 11;
			energyLimitButton.y = 252;
			
			energyRechargeButton.x = 66;
			energyRechargeButton.y = 252;
			
			add(energyLimitButton);
			add(energyRechargeButton);
		}
		
		private function addTurretUpgrades():void
		{
			var rangeButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsRange);
			var rateButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsRate);
			var powerButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsPower);
			
			rangeButton.x = 11;
			rangeButton.y = 319;
			
			rateButton.x = 66;
			rateButton.y = 319;
			
			powerButton.x = 121;
			powerButton.y = 319;
			
			add(rangeButton);
			add(rateButton);
			add(powerButton);
		}
	}
}