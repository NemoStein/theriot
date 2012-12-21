package nemostein.games.geocontact.theriot.states.gameplay
{
	import flash.geom.Rectangle;
	import nemostein.bezier.Path;
	import nemostein.framework.dragonfly.Container;
	import nemostein.framework.dragonfly.io.Input;
	import nemostein.games.geocontact.theriot.states.gameplay.hud.HUD;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Ammo;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Unit;
	
	public class GamePlayService
	{	
		private var _gamePlay:GamePlay;
		private var _input:Input;
		
		private var _levelLayer:Container;
		private var _unitsLayer:Container;
		
		private var _unitsPlayer:Vector.<Unit>;
		private var _unitsAI:Vector.<Unit>;
		
		private var _level:Level;
		public var complexAI:Complex;
		public var complexPlayer:Complex;
		
		public function GamePlayService(gamePlay:GamePlay, input:Input) 
		{
			_gamePlay = gamePlay;
			_input = input;
		}
		
		public function loadLevel(levelClass:Class):void 
		{
			_levelLayer = new Container();
			_unitsLayer = new Container();
			
			_unitsPlayer = new Vector.<Unit>();
			_unitsAI = new Vector.<Unit>();
			
			_level = new levelClass();
			_levelLayer.add(_level);
			
			var hud:HUD = new HUD();
			
			_gamePlay.add(_levelLayer);
			_gamePlay.add(_unitsLayer);
			_gamePlay.add(hud);
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
		
		public function setBounds(levelBounds:Rectangle):void 
		{
			_gamePlay.bounds.x = levelBounds.x - 100;
			_gamePlay.bounds.y = levelBounds.y - 100;
			_gamePlay.bounds.width = levelBounds.width;
			_gamePlay.bounds.height = levelBounds.height;
		}
		
		public function setPlayerComplex(complexPlayer:Complex):void 
		{
			this.complexPlayer = complexPlayer;
		}
		
		public function setAIComplex(complexAI:Complex):void 
		{
			this.complexAI = complexAI;
		}
		
		public function get level():Level 
		{
			return _level;
		}
	}
}