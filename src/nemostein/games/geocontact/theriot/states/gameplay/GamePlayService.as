package nemostein.games.geocontact.theriot.states.gameplay
{
	import nemostein.framework.dragonfly.io.Input;
	import nemostein.framework.dragonfly.plugins.orderedcontainer.OrderedContainer;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Bullet;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Factory;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Unit;
	import nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.complex.ComplexUpgradeWheel;
	import nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.factory.FactorySelectorWheel;
	import nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.factory.FactoryUpgradeWheel;
	import nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.factory.UnitUpgradeWheel;
	import nemostein.games.geocontact.theriot.states.gameplay.upgradewheel.WheelMenu;
	
	public class GamePlayService
	{	
		private var _gamePlay:GamePlay;
		private var _input:Input;
		
		private var _container:OrderedContainer;
		
		private var _complexUpgradeWheel:ComplexUpgradeWheel;
		private var _factorySelectorWheel:FactorySelectorWheel;
		private var _factoryUpgradeWheel:FactoryUpgradeWheel;
		private var _unitUpgradeWheel:UnitUpgradeWheel;
		
		private var _openedWheel:WheelMenu;
		
		public function GamePlayService(gamePlay:GamePlay, input:Input) 
		{
			_gamePlay = gamePlay;
			_input = input;
			
			initialize();
		}
		
		private function initialize():void 
		{
			_container = new OrderedContainer();
			
			_complexUpgradeWheel = new ComplexUpgradeWheel();
			_factorySelectorWheel = new FactorySelectorWheel();
			_factoryUpgradeWheel = new FactoryUpgradeWheel();
			_unitUpgradeWheel = new UnitUpgradeWheel();
			
			_complexUpgradeWheel.die();
			_factorySelectorWheel.die();
			_factoryUpgradeWheel.die();
			_unitUpgradeWheel.die();
			
			_gamePlay.add(_container);
			
			_gamePlay.add(_complexUpgradeWheel);
			_gamePlay.add(_factorySelectorWheel);
			_gamePlay.add(_factoryUpgradeWheel);
			_gamePlay.add(_unitUpgradeWheel);
		}
		
		public function bringComplexSelectorWheel(complex:Complex):void
		{
			_complexUpgradeWheel.revive();
			_complexUpgradeWheel.setStats(complex.getCurrentStats());
			
			_complexUpgradeWheel.x = complex.x;
			_complexUpgradeWheel.y = complex.y;
			
			_openedWheel = _complexUpgradeWheel;
		}
		
		public function bringFactorySelectorWheel(factory:Factory):void
		{
			_factorySelectorWheel.revive();
			_factorySelectorWheel.setStats(factory.getCurrentStats());
			
			_factorySelectorWheel.x = factory.x;
			_factorySelectorWheel.y = factory.y;
			
			_openedWheel = _factorySelectorWheel;
		}
		
		public function closeWheel():void
		{
			if (_openedWheel)
			{
				_openedWheel.die();
			}
		}
		
		public function addUnit(unit:Unit):void
		{
			_container.add(unit);
		}
		
		public function removeUnit(unit:Unit):void
		{
			_container.remove(unit);
		}
		
		public function addFactory(factory:Factory):void
		{
			_container.add(factory);
		}
		
		public function removeFactory(factory:Factory):void
		{
			_container.remove(factory);
		}
		
		public function addComplex(complex:Complex):void
		{
			_container.add(complex);
		}
		
		public function addBullet(bullet:Bullet):void 
		{
			_container.add(bullet);
		}
	}
}