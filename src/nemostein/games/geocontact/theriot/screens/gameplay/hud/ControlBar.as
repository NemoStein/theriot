package nemostein.games.geocontact.theriot.screens.gameplay.hud
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.framework.dragonfly.modules.widgets.Bar;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.controlBar.ControlBarAlliedEnd;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.controlBar.ControlBarAlliedMiddle;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.controlBar.ControlBarAlliedStart;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.controlBar.ControlBarEnemyEnd;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.controlBar.ControlBarEnemyMiddle;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.controlBar.ControlBarEnemyStart;
	import nemostein.games.geocontact.theriot.screens.gameplay.GamePlayScreen;
	import nemostein.games.geocontact.theriot.screens.gameplay.GamePlayService;
	
	public class ControlBar extends Bar
	{
		private var _start:Entity;
		private var _middle:Entity;
		private var _end:Entity;
		
		private var _length:Number;
		private var _enemy:Boolean;
		
		public function ControlBar(enemy:Boolean = false)
		{
			_enemy = enemy;
			
			var gamePlayService:GamePlayService = GamePlayScreen.service;
			var getMaxValue:Function = gamePlayService.getMaxBattleControl;
			var getValue:Function;
			
			if (!enemy)
			{
				getValue = gamePlayService.playerBattleControl;
			}
			else
			{
				getValue = gamePlayService.enemyBattleControl;
			}
			
			super(getValue, getMaxValue, false, enemy);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var startData:BitmapData;
			var middleData:BitmapData;
			var endData:BitmapData;
			
			if (!_enemy)
			{
				startData = new ControlBarAlliedStart();
				middleData = new ControlBarAlliedMiddle();
				endData = new ControlBarAlliedEnd();
			}
			else
			{
				startData = new ControlBarEnemyStart();
				middleData = new ControlBarEnemyMiddle();
				endData = new ControlBarEnemyEnd();
			}
			
			_length = 172;
			
			var origin:BitmapData = middleData;
			var matrix:Matrix = new Matrix();
			
			matrix.scale(_length / origin.width, 1);
			
			middleData = new BitmapData(_length, origin.height, false);
			middleData.draw(origin, matrix);
			
			_start = new Entity();
			_middle = new Entity();
			_end = new Entity();
			
			_start.draw(startData);
			_middle.draw(middleData);
			_end.draw(endData);
			
			_middle.x = _start.width;
			_end.x = _start.width + _middle.width;
			
			add(_start);
			add(_middle);
			add(_end);
			
			width = _length;
			height = _start.height;
		}
		
		override protected function getLength():Number
		{
			return _length;
		}
		
		override public function get width():Number
		{
			return _start.width + _middle.width + _end.width;
		}
		
		override public function set width(value:Number):void
		{
			_middle.width = value;
			_end.x = _start.width + _middle.width;
		}
	}
}