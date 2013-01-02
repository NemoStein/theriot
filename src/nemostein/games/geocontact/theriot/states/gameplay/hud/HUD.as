package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import nemostein.framework.dragonfly.modules.container.Container;
	import nemostein.framework.dragonfly.modules.container.entity.AnchorAlign;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
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
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Factory;
	
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
			var factories:Vector.<Factory> = GamePlay.service.complexPlayer.factories;
			
			for (var i:int = 0; i < factories.length; ++i)
			{
				var factory:Factory = factories[i];
				if (factory)
				{
					var factoryButton:FactoryButton = new FactoryButton(factory, i);
					add(factoryButton);
					
					factoryButton.x = 11 + i * 25;
					factoryButton.y = 386;
				}
			}
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
			
			var upgrades:Entity = new Entity();
			var buildButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsBuild);
			var lockText:FactoryLockText = new FactoryLockText();
			
			lockText.alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
			
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
			
			lockText.x = 93;
			lockText.y = 480;
			
			upgrades.add(rangeButton);
			upgrades.add(rateButton);
			upgrades.add(powerButton);
			upgrades.add(speedButton);
			upgrades.add(armorButton);
			upgrades.add(healthButton);
			upgrades.add(assemblyRateButton);
			upgrades.add(assemblyCostButton);
			
			GamePlay.service.registerFactoryUpgrades(upgrades, buildButton, lockText);
			
			add(upgrades);
			add(buildButton);
			add(lockText);
		}
	}
}