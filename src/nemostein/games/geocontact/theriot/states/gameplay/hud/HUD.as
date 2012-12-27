package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.framework.dragonfly.plugins.shadowedtext.ShadowedText;
	import nemostein.framework.dragonfly.Text;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.AssetStatesGameplayHudBase;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsArmor;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsAssemblyCost;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsAssemblyRate;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsBuild;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsEnergyLimit;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsEnergyRecharge;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsHealth;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsPower;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsRange;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsRate;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsSpeed;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs1;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs2;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs3;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs4;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs5;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs6;
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
			addFactoryTabs();
			addFactoryUpgrades();
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
			var scrapsIndicator:ScrapsIndicator = new ScrapsIndicator();
			
			scrapsIndicator.x = 48;
			scrapsIndicator.y = 218;
			
			add(scrapsIndicator);
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
		
		private function addFactoryTabs():void
		{
			var tab1:Entity = new Entity(new AssetStatesGameplayHudTabs1().bitmapData);
			var tab2:Entity = new Entity(new AssetStatesGameplayHudTabs2().bitmapData);
			var tab3:Entity = new Entity(new AssetStatesGameplayHudTabs3().bitmapData);
			var tab4:Entity = new Entity(new AssetStatesGameplayHudTabs4().bitmapData);
			var tab5:Entity = new Entity(new AssetStatesGameplayHudTabs5().bitmapData);
			var tab6:Entity = new Entity(new AssetStatesGameplayHudTabs6().bitmapData);
			
			var factoryC:FactoryButton = new FactoryButton("C");
			var factoryA:FactoryButton = new FactoryButton("A");
			var factoryA1:FactoryButton = new FactoryButton("A1");
			var factoryB:FactoryButton = new FactoryButton("B");
			var factoryB1:FactoryButton = new FactoryButton("B1");
			var factoryB2:FactoryButton = new FactoryButton("B2");
			
			tab1.x = 9;
			tab2.x = 9;
			tab3.x = 9;
			tab4.x = 9;
			tab5.x = 9;
			tab6.x = 9;
			
			tab1.y = 384;
			tab2.y = 384;
			tab3.y = 384;
			tab4.y = 384;
			tab5.y = 384;
			tab6.y = 384;
			
			//tab1.hide();
			tab2.hide();
			tab3.hide();
			tab4.hide();
			tab5.hide();
			tab6.hide();
			
			factoryC.enable();
			factoryA.unlock();
			factoryB.unlock();
			
			factoryC.x = 11;
			factoryA.x = 36;
			factoryA1.x = 61;
			factoryB.x = 86;
			factoryB1.x = 111;
			factoryB2.x = 136;
			
			factoryC.y = 386;
			factoryA.y = 386;
			factoryA1.y = 386;
			factoryB.y = 386;
			factoryB1.y = 386;
			factoryB2.y = 386;
			
			add(tab1);
			add(tab2);
			add(tab3);
			add(tab4);
			add(tab5);
			add(tab6);
			
			add(factoryC);
			add(factoryA);
			add(factoryA1);
			add(factoryB);
			add(factoryB1);
			add(factoryB2);
		}
		
		private function addFactoryUpgrades():void
		{
			var rangeButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsRange);
			var rateButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsRate);
			var powerButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsPower);
			var speedButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsSpeed);
			var armorButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsArmor);
			var healthButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsHealth);
			var assemblyRateButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsAssemblyRate);
			var assemblyCostButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsAssemblyCost);
			var buildButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsBuild);
			
			var lockedText:ShadowedText = new ShadowedText("This factory is Locked\rBuy Factory $$ to unlock", "Lead III", 8, 0xffc0e5f0, Text.CENTER);
			
			lockedText.alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
			
			rangeButton.x = 11;
			rangeButton.y = 416;
			
			rateButton.x = 66;
			rateButton.y = 416;
			
			powerButton.x = 121;
			powerButton.y = 416;
			
			speedButton.x = 11;
			speedButton.y = 459;
			
			armorButton.x = 66;
			armorButton.y = 459;
			
			healthButton.x = 121;
			healthButton.y = 459;
			
			assemblyRateButton.x = 11;
			assemblyRateButton.y = 502;
			
			assemblyCostButton.x = 66;
			assemblyCostButton.y = 502;
			
			buildButton.x = 121;
			buildButton.y = 502;
			
			lockedText.x = 93;
			lockedText.y = 480;
			
			//rangeButton.hide();
			//rateButton.hide();
			//powerButton.hide();
			//speedButton.hide();
			//armorButton.hide();
			//healthButton.hide();
			//assemblyRateButton.hide();
			//assemblyCostButton.hide();
			buildButton.hide();
			lockedText.hide();
			
			add(rangeButton);
			add(rateButton);
			add(powerButton);
			add(speedButton);
			add(armorButton);
			add(healthButton);
			add(assemblyRateButton);
			add(assemblyCostButton);
			add(buildButton);
			add(lockedText);
		}
	}
}