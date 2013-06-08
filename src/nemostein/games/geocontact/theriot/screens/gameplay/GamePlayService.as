package nemostein.games.geocontact.theriot.screens.gameplay
{
	import flash.geom.Rectangle;
	import nemostein.framework.dragonfly.modules.container.Container;
	import nemostein.framework.dragonfly.modules.io.Input;
	import nemostein.games.geocontact.theriot.screens.defeat.DefeatScreen;
	import nemostein.games.geocontact.theriot.screens.gameplay.hud.FactoryButton;
	import nemostein.games.geocontact.theriot.screens.gameplay.hud.FactoryLockText;
	import nemostein.games.geocontact.theriot.screens.gameplay.hud.HUD;
	import nemostein.games.geocontact.theriot.screens.gameplay.hud.UpgradeButton;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.Ammo;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats.ComplexStats;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats.FactoryStats;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats.Stats;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.Unit;
	import nemostein.games.geocontact.theriot.screens.Screen;
	import nemostein.games.geocontact.theriot.screens.victory.VictoryScreen;
	
	public class GamePlayService
	{
		private var _gamePlay:GamePlayScreen;
		private var _input:Input;
		
		private var _levelLayer:Container;
		private var _unitsLayer:Container;
		
		private var _unitsPlayer:Vector.<Unit>;
		private var _unitsAI:Vector.<Unit>;
		
		private var _level:Level;
		private var _hud:HUD;
		
		private var _currentFactoryTab:FactoryButton;
		
		private var _complexEnergyLimit:UpgradeButton;
		private var _complexEnergyRecharge:UpgradeButton;
		
		private var _turretRange:UpgradeButton;
		private var _turretRate:UpgradeButton;
		private var _turretPower:UpgradeButton;
		
		private var _factoryRange:UpgradeButton;
		private var _factoryRate:UpgradeButton;
		private var _factoryPower:UpgradeButton;
		private var _factorySpeed:UpgradeButton;
		private var _factoryArmor:UpgradeButton;
		private var _factoryHealth:UpgradeButton;
		private var _factoryAssemblyRate:UpgradeButton;
		private var _factoryAssemblyCost:UpgradeButton;
		private var _factoryBuild:UpgradeButton;
		private var _factoryLockText:FactoryLockText;
		
		public var complexAI:Complex;
		public var complexPlayer:Complex;
		
		public function GamePlayService(gamePlay:GamePlayScreen, input:Input)
		{
			_gamePlay = gamePlay;
			_input = input;
		}
		
		public function loadLevel(levelClass:Class):void
		{
			_gamePlay.resetBattleTimer();
			
			if (_levelLayer)
			{
				_gamePlay.remove(_levelLayer);
			}
			
			if (_unitsLayer)
			{
				_gamePlay.remove(_unitsLayer);
			}
			
			if (_hud)
			{
				_gamePlay.remove(_hud);
			}
			
			_levelLayer = new Container();
			_unitsLayer = new Container();
			
			_unitsPlayer = new Vector.<Unit>();
			_unitsAI = new Vector.<Unit>();
			
			_level = new levelClass();
			_levelLayer.add(_level);
			
			_hud = new HUD();
			
			_gamePlay.add(_levelLayer);
			_gamePlay.add(_unitsLayer);
			_gamePlay.add(_hud);
		}
		
		public function addUnit(unit:Unit):void
		{
			if (unit.ai)
			{
				_unitsAI.push(unit);
				unit.enemyUnits = _unitsPlayer;
				
				unit.x = _level.slotAI.x;
				unit.y = _level.slotAI.y;
			}
			else
			{
				_unitsPlayer.push(unit);
				unit.enemyUnits = _unitsAI;
				
				unit.x = _level.slotPlayer.x;
				unit.y = _level.slotPlayer.y;
			}
			
			_unitsLayer.add(unit);
			
			unit.path = _level.getPath(unit.ai);
		}
		
		public function removeUnit(unit:Unit):void
		{
			var unitIndex:int;
			
			if (unit.ai)
			{
				unitIndex = _unitsAI.indexOf(unit);
				if (unitIndex >= 0)
				{
					_unitsAI.splice(unitIndex, 1);
					_unitsLayer.remove(unit);
				}
			}
			else
			{
				unitIndex = _unitsPlayer.indexOf(unit)
				if (unitIndex >= 0)
				{
					_unitsPlayer.splice(unitIndex, 1);
					_unitsLayer.remove(unit);
				}
			}
		}
		
		public function fire(ammoClass:Class, fromUnit:Unit, atUnit:Unit):void
		{
			var ammo:Ammo = new ammoClass();
			
			ammo.x = fromUnit.x;
			ammo.y = fromUnit.y;
			
			ammo.power = fromUnit.power;
			ammo.target = atUnit;
			
			_unitsLayer.add(ammo);
		}
		
		public function removeAmmo(ammo:Ammo):void
		{
			_unitsLayer.remove(ammo);
		}
		
		public function setPlayerComplex(complexPlayer:Complex):void
		{
			this.complexPlayer = complexPlayer;
		}
		
		public function setAIComplex(complexAI:Complex):void
		{
			this.complexAI = complexAI;
		}
		
		public function hitEnemyComplex(unit:Unit):void
		{
			var complex:Complex;
			
			if (unit.ai)
			{
				complex = complexPlayer;
			}
			else
			{
				complex = complexAI;
			}
			
			complex.hit(unit.health);
		}
		
		public function complexDestroyed(complex:Complex):void
		{
			if (complex.ai)
			{
				playerVictory();
			}
			else
			{
				playerDefeat();
			}
		}
		
		private function playerVictory():void
		{
			Screen.service.load(Screen.service.getScreen(VictoryScreen));
		}
		
		private function playerDefeat():void
		{
			Screen.service.load(Screen.service.getScreen(DefeatScreen));
		}
		
		public function getBattleElapsedTime():int
		{
			return _gamePlay.battleElapsedTime;
		}
		
		public function getMaxBattleControl():Number
		{
			return 1;
		}
		
		public function playerBattleControl():Number
		{
			return 0.25;
		}
		
		public function enemyBattleControl():Number
		{
			return 0.25;
		}
		
		public function getPlayerMetal():Number
		{
			return complexPlayer.metal;
		}
		
		public function getAIMetal():Number
		{
			return complexAI.metal;
		}
		
		public function get level():Level
		{
			return _level;
		}
		
		public function registerComplexUpgrades(energyLimit:UpgradeButton, energyRecharge:UpgradeButton):void
		{
			_complexEnergyLimit = energyLimit;
			_complexEnergyRecharge = energyRecharge;
			
			var stats:ComplexStats = complexPlayer.stats;
			
			_complexEnergyLimit.value = stats.energyLimit.value;
			_complexEnergyLimit.price = stats.energyLimit.price;
			
			_complexEnergyRecharge.value = stats.energyRecharge.value;
			_complexEnergyRecharge.price = stats.energyRecharge.price;
			
			_complexEnergyLimit.onExecute = complexEnergyLimitOnExecute;
			_complexEnergyRecharge.onExecute = complexEnergyRechargeOnExecute;
		}
		
		public function registerTurretUpgrades(range:UpgradeButton, rate:UpgradeButton, power:UpgradeButton):void
		{
			_turretRange = range;
			_turretRate = rate;
			_turretPower = power;
			
			var stats:ComplexStats = complexPlayer.stats;
			
			_turretRange.value = stats.turretRange.value;
			_turretRange.price = stats.turretRange.price;
			
			_turretRate.value = stats.turretRate.value;
			_turretRate.price = stats.turretRate.price;
			
			_turretPower.value = stats.turretPower.value;
			_turretPower.price = stats.turretPower.price;
			
			_turretRange.onExecute = turretRangeOnExecute;
			_turretRate.onExecute = turretRateOnExecute;
			_turretPower.onExecute = turretPowerOnExecute;
		}
		
		public function registerFactoryUpgrades(range:UpgradeButton, rate:UpgradeButton, power:UpgradeButton, speed:UpgradeButton, armor:UpgradeButton, health:UpgradeButton, assemblyRate:UpgradeButton, assemblyCost:UpgradeButton, build:UpgradeButton, lockText:FactoryLockText):void
		{
			_factoryRange = range;
			_factoryRate = rate;
			_factoryPower = power;
			_factorySpeed = speed;
			_factoryArmor = armor;
			_factoryHealth = health;
			_factoryAssemblyRate = assemblyRate;
			_factoryAssemblyCost = assemblyCost;
			_factoryBuild = build;
			_factoryLockText = lockText;
			
			_factoryRange.onExecute = factoryRangeOnExecute;
			_factoryRate.onExecute = factoryRateOnExecute;
			_factoryPower.onExecute = factoryPowerOnExecute;
			_factorySpeed.onExecute = factorySpeedOnExecute;
			_factoryArmor.onExecute = factoryArmorOnExecute;
			_factoryHealth.onExecute = factoryHealthOnExecute;
			_factoryAssemblyRate.onExecute = factoryAssemblyRateOnExecute;
			_factoryAssemblyCost.onExecute = factoryAssemblyCostOnExecute;
			_factoryBuild.onExecute = factoryBuildOnExecute;
			
			_factoryRange.hide();
			_factoryRate.hide();
			_factoryPower.hide();
			_factorySpeed.hide();
			_factoryArmor.hide();
			_factoryHealth.hide();
			_factoryAssemblyRate.hide();
			_factoryAssemblyCost.hide();
			_factoryBuild.hide();
			_factoryLockText.hide();
		}
		
		public function switchFactoryTabTo(factoryButton:FactoryButton):void
		{
			if (_currentFactoryTab)
			{
				hideFactoryButtons();
				_currentFactoryTab.toggle(false);
			}
			
			_currentFactoryTab = factoryButton;
			_currentFactoryTab.toggle(true);
			
			if (_currentFactoryTab.enabled)
			{
				_factoryRange.show();
				_factoryRate.show();
				_factoryPower.show();
				_factorySpeed.show();
				_factoryArmor.show();
				_factoryHealth.show();
				_factoryAssemblyRate.show();
				_factoryAssemblyCost.show();
				
				var stats:FactoryStats = _currentFactoryTab.factory.stats;
				
				_factoryRange.value = stats.unitRange.value;
				_factoryRange.price = stats.unitRange.price;
				
				_factoryRate.value = stats.unitRate.value;
				_factoryRate.price = stats.unitRate.price;
				
				_factoryPower.value = stats.unitPower.value;
				_factoryPower.price = stats.unitPower.price;
				
				_factorySpeed.value = stats.unitSpeed.value;
				_factorySpeed.price = stats.unitSpeed.price;
				
				_factoryArmor.value = stats.unitArmor.value;
				_factoryArmor.price = stats.unitArmor.price;
				
				_factoryHealth.value = stats.unitHealth.value;
				_factoryHealth.price = stats.unitHealth.price;
				
				_factoryAssemblyRate.value = stats.assembyRate.value;
				_factoryAssemblyRate.price = stats.assembyRate.price;
				
				_factoryAssemblyCost.value = stats.assembyCost.value;
				_factoryAssemblyCost.price = stats.assembyCost.price;
			}
			else if (_currentFactoryTab.unlocked)
			{
				_factoryBuild.show();
				_factoryBuild.price = 50;
			}
			else
			{
				_factoryLockText.show();
			}
		}
		
		public function giveMetal(metal:Number, toAI:Boolean):void
		{
			if (toAI)
			{
				complexAI.addMetal(metal);
			}
			else
			{
				complexPlayer.addMetal(metal);
			}
		}
		
		public function takeMetal(metal:Number, toAI:Boolean):void
		{
			if (toAI)
			{
				complexAI.addMetal(-metal);
			}
			else
			{
				complexPlayer.addMetal(-metal);
			}
		}
		
		private function hideFactoryButtons():void
		{
			_factoryRange.hide();
			_factoryRate.hide();
			_factoryPower.hide();
			_factorySpeed.hide();
			_factoryArmor.hide();
			_factoryHealth.hide();
			_factoryAssemblyRate.hide();
			_factoryAssemblyCost.hide();
			
			_factoryBuild.hide();
			
			_factoryLockText.hide();
		}
		
		private function complexEnergyLimitOnExecute():void
		{
			var stats:Stats = complexPlayer.stats.energyLimit;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_complexEnergyLimit.value = stats.value;
				_complexEnergyLimit.price = stats.price;
			}
		}
		
		private function complexEnergyRechargeOnExecute():void
		{
			var stats:Stats = complexPlayer.stats.energyRecharge;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_complexEnergyRecharge.value = stats.value;
				_complexEnergyRecharge.price = stats.price;
			}
		}
		
		private function turretRangeOnExecute():void
		{
			var stats:Stats = complexPlayer.stats.turretRange;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_turretRange.value = stats.value;
				_turretRange.price = stats.price;
			}
		}
		
		private function turretRateOnExecute():void
		{
			var stats:Stats = complexPlayer.stats.turretRate;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_turretRate.value = stats.value;
				_turretRate.price = stats.price;
			}
		}
		
		private function turretPowerOnExecute():void
		{
			var stats:Stats = complexPlayer.stats.turretPower;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_turretPower.value = stats.value;
				_turretPower.price = stats.price;
			}
		}
		
		private function factoryRangeOnExecute():void
		{
			var stats:Stats = _currentFactoryTab.factory.stats.unitRange;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_factoryRange.value = stats.value;
				_factoryRange.price = stats.price;
			}
		}
		
		private function factoryRateOnExecute():void
		{
			var stats:Stats = _currentFactoryTab.factory.stats.unitRate;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_factoryRate.value = stats.value;
				_factoryRate.price = stats.price;
			}
		}
		
		private function factoryPowerOnExecute():void
		{
			var stats:Stats = _currentFactoryTab.factory.stats.unitPower;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_factoryPower.value = stats.value;
				_factoryPower.price = stats.price;
			}
		}
		
		private function factorySpeedOnExecute():void
		{
			var stats:Stats = _currentFactoryTab.factory.stats.unitSpeed;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_factorySpeed.value = stats.value;
				_factorySpeed.price = stats.price;
			}
		}
		
		private function factoryArmorOnExecute():void
		{
			var stats:Stats = _currentFactoryTab.factory.stats.unitArmor;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_factoryArmor.value = stats.value;
				_factoryArmor.price = stats.price;
			}
		}
		
		private function factoryHealthOnExecute():void
		{
			var stats:Stats = _currentFactoryTab.factory.stats.unitHealth;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_factoryHealth.value = stats.value;
				_factoryHealth.price = stats.price;
			}
		}
		
		private function factoryAssemblyRateOnExecute():void
		{
			var stats:Stats = _currentFactoryTab.factory.stats.assembyRate;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_factoryAssemblyRate.value = stats.value;
				_factoryAssemblyRate.price = stats.price;
			}
		}
		
		private function factoryAssemblyCostOnExecute():void
		{
			var stats:Stats = _currentFactoryTab.factory.stats.assembyCost;
			
			if (playerHaveMetal(stats.price))
			{
				takeMetal(stats.price, false);
				
				stats.upgrade();
				
				_factoryAssemblyCost.value = stats.value;
				_factoryAssemblyCost.price = stats.price;
			}
		}
		
		private function factoryBuildOnExecute():void
		{
			_currentFactoryTab.factory.enable();
			
			switchFactoryTabTo(_currentFactoryTab);
		}
		
		private function playerHaveMetal(price:Number):Boolean
		{
			return price < getPlayerMetal();
		}
	}
}