package nemostein.games.geocontact.theriot.screens.loadgame
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import nemostein.framework.dragonfly.modules.container.entity.AnchorAlign;
	import nemostein.framework.dragonfly.modules.text.Text;
	import nemostein.framework.dragonfly.modules.widgets.Button;
	import nemostein.games.geocontact.theriot.assets.screens.loadgame.Slot1Background;
	import nemostein.games.geocontact.theriot.assets.screens.loadgame.Slot1DeleteButton;
	import nemostein.games.geocontact.theriot.assets.screens.loadgame.Slot2Background;
	import nemostein.games.geocontact.theriot.assets.screens.loadgame.Slot2DeleteButton;
	import nemostein.games.geocontact.theriot.assets.screens.loadgame.Slot3Background;
	import nemostein.games.geocontact.theriot.assets.screens.loadgame.Slot3DeleteButton;
	import nemostein.games.geocontact.theriot.core.SimpleButton;
	import nemostein.games.geocontact.theriot.system.GameData;
	
	public class Slot extends Button
	{
		private var _index:int;
		private var _text:Text;
		private var _deleteButton:SimpleButton;
		private var _confirmButton:Button;
		private var _gameData:GameData;
		
		public function Slot(index:int)
		{
			_index = index;
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var backgroundData:BitmapData;
			var deleteButtonData:BitmapData;
			
			switch (_index)
			{
				case 1: 
				{
					backgroundData = new Slot1Background();
					deleteButtonData = new Slot1DeleteButton();
					break;
				}
				
				case 2: 
				{
					backgroundData = new Slot2Background();
					deleteButtonData = new Slot2DeleteButton();
					break;
				}
				
				case 3: 
				{
					backgroundData = new Slot3Background();
					deleteButtonData = new Slot3DeleteButton();
					break;
				}
				
				default: 
				{
					throw new ArgumentError("There is no Slot Index " + _index);
				}
			}
			
			draw(backgroundData, 385, 92);
			useFullHitArea();
			
			_deleteButton = new SimpleButton(deleteButtonData, 42, 42, onDeleteButtonExecute, 0, 1, 1);
			_confirmButton = new Button();
			_text = new Text("New Game", "Neuropol", 48);
			
			_deleteButton.die();
			_deleteButton.x = 286;
			_deleteButton.y = 8 - _index;
			
			_confirmButton.die();
			_confirmButton.width = 41;
			_confirmButton.height = 71;
			_confirmButton.x = 333;
			_confirmButton.y = 13 - _index;
			_confirmButton.onLeave = onConfirmButtonLeave;
			_confirmButton.onEnter = onConfirmButtonEnter;
			_confirmButton.onExecute = onConfirmButtonExecute;
			
			_text.alignAnchor(AnchorAlign.TOP, AnchorAlign.CENTER);
			_text.x = 168;
			_text.y = 38;
			
			add(_deleteButton);
			add(_confirmButton);
			add(_text);
			
			loadGame();
		}
		
		private function useFullHitArea():void
		{
			drawHitArea(new Point(22, 13 - _index), new Point(324, 13 - _index), new Point(324, 21 - _index), new Point(324, 74 - _index), new Point(314, 84 - _index), new Point(22, 84 - _index), new Point(12, 74 - _index), new Point(12, 21 - _index));
		}
		
		private function useDeleteHitArea():void
		{
			drawHitArea(new Point(22, 13 - _index), new Point(286, 13 - _index), new Point(286, 50 - _index), new Point(324, 50 - _index), new Point(324, 74 - _index), new Point(314, 84 - _index), new Point(22, 84 - _index), new Point(12, 74 - _index), new Point(12, 21 - _index));
		}
		
		private function loadGame():void
		{
			_gameData = GameData.loadGame(_index);
			if (_gameData)
			{
				var level:int = _gameData.level;
				var sufix:String = "th";
				
				if (level == 1)
				{
					sufix = "st";
				}
				else if (level == 2)
				{
					sufix = "nd";
				}
				else if (level == 3)
				{
					sufix = "rd";
				}
				
				_text.text = level + sufix + " Riot";
				_deleteButton.revive();
				
				useDeleteHitArea();
			}
		}
		
		private function onDeleteButtonExecute():void
		{
			_confirmButton.revive();
			moveSpriteToFrame(1);
		}
		
		private function onConfirmButtonLeave():void
		{
			moveSpriteToFrame(1);
		}
		
		private function onConfirmButtonEnter():void
		{
			moveSpriteToFrame(2);
		}
		
		private function onConfirmButtonExecute():void
		{
			_gameData = null;
			
			_deleteButton.die();
			_confirmButton.die();
			_text.text = "New Game";
			
			useFullHitArea();
			moveSpriteToFrame(0);
			
			GameData.deleteGame(_index);
		}
		
		override public function entered(point:Point = null):void
		{
			_text.color = 0xff84d9f5;
			super.entered(point);
		}
		
		override public function leaved(point:Point = null):void
		{
			_text.color = 0xffffffff;
			super.leaved(point);
		}
		
		override public function executed(point:Point = null):void
		{
			if (!_gameData)
			{
				_gameData = new GameData();
				_gameData.slot = _index;
			}
			
			GameData.current = _gameData;
			super.executed(point);
		}
	}
}