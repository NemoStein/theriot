package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.modules.container.entity.AnchorAlign;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.framework.dragonfly.modules.io.MouseAware;
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
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayService;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Factory;
	import nemostein.utils.MathUtils;
	
	public class HUD extends Entity implements MouseAware
	{
		private var _service:GamePlayService;
		private var _hitArea:Vector.<Point>;
		private var _firstFactoryButton:FactoryButton;
		
		override protected function initialize():void
		{
			super.initialize();
			
			setParallax(0, 0);
			
			_service = GamePlay.service;
			
			buildHitArea();
			
			addBase();
			addOptionsButton();
			addWeather();
			addTimeElapsed();
			addControlBar();
			addMinimap();
			addEnergyBar();
			addMetalIndicator();
			addComplexUpgrades();
			addTurretUpgrades();
			addFactoryTabs();
			addFactoryUpgrades();
			
			switchToFirstTab();
		}
		
		private function buildHitArea():void
		{
			_hitArea = new Vector.<Point>();
			
			_hitArea.push(new Point(0, 0));
			_hitArea.push(new Point(215, 0));
			_hitArea.push(new Point(200, 15));
			_hitArea.push(new Point(200, 166));
			_hitArea.push(new Point(186, 179));
			_hitArea.push(new Point(186, 600));
			_hitArea.push(new Point(0, 600));
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
		
		private function addMetalIndicator():void
		{
			var metalIndicator:MetalIndicator = new MetalIndicator();
			
			metalIndicator.x = 48;
			metalIndicator.y = 218;
			
			add(metalIndicator);
		}
		
		private function addComplexUpgrades():void
		{
			var energyLimitButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsEnergyLimit);
			var energyRechargeButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsEnergyRecharge);
			
			energyLimitButton.x = 11;
			energyLimitButton.y = 252;
			
			energyRechargeButton.x = 66;
			energyRechargeButton.y = 252;
			
			_service.registerComplexUpgrades(energyLimitButton, energyRechargeButton);
			
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
			
			_service.registerTurretUpgrades(rangeButton, rateButton, powerButton);
			
			add(rangeButton);
			add(rateButton);
			add(powerButton);
		}
		
		private function addFactoryTabs():void
		{
			var factories:Vector.<Factory> = _service.complexPlayer.factories;
			
			for (var i:int = 0; i < factories.length; ++i)
			{
				var factory:Factory = factories[i];
				if (factory)
				{
					var factoryButton:FactoryButton = new FactoryButton(factory, i);
					add(factoryButton);
					
					factoryButton.x = 11 + i * 25;
					factoryButton.y = 386;
					
					if (i == 0)
					{
						_firstFactoryButton = factoryButton;
					}
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
			var buildButton:UpgradeButton = new UpgradeButton(AssetStatesGameplayHudIconsBuild);
			var lockText:FactoryLockText = new FactoryLockText();
			
			buildButton.hideValue();
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
			
			_service.registerFactoryUpgrades(rangeButton, rateButton, powerButton, speedButton, armorButton, healthButton, assemblyRateButton, assemblyCostButton, buildButton, lockText);
			
			add(rangeButton);
			add(rateButton);
			add(powerButton);
			add(speedButton);
			add(armorButton);
			add(healthButton);
			add(assemblyRateButton);
			add(assemblyCostButton);
			add(buildButton);
			add(lockText);
		}
		
		private function switchToFirstTab():void
		{
			GamePlay.service.switchFactoryTabTo(_firstFactoryButton);
		}
		
		public function onMouseDown(key:int, mouse:Point):Boolean
		{
			return !MathUtils.isInsidePolygon(_hitArea, mouse);
		}
		
		public function onMouseUp(key:int, mouse:Point):Boolean
		{
			return true;
		}
	}
}