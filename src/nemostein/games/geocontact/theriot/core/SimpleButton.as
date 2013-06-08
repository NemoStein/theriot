package nemostein.games.geocontact.theriot.core
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import nemostein.framework.dragonfly.modules.widgets.Button;
	
	public class SimpleButton extends Button
	{
		private var _data:BitmapData;
		private var _width:int;
		private var _height:int;
		private var _onExecute:Function;
		private var _leavedFrame:int;
		private var _enteredFrame:int;
		private var _pressedFrame:int;
		
		public function SimpleButton(data:BitmapData, width:int, height:int, onExecute:Function, leavedFrame:int = 0, enteredFrame:int = 1, pressedFrame:int = 2)
		{
			_data = data;
			_width = width;
			_height = height;
			_onExecute = onExecute;
			_leavedFrame = leavedFrame;
			_enteredFrame = enteredFrame;
			_pressedFrame = pressedFrame;
			
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			draw(_data, _width, _height);
			
			onExecute = _onExecute;
		}
		
		override public function pressed(point:Point = null):void
		{
			moveSpriteToFrame(_pressedFrame);
			super.pressed(point);
		}
		
		override public function released(point:Point = null):void
		{
			moveSpriteToFrame(_enteredFrame);
			super.released(point);
		}
		
		override public function entered(point:Point = null):void
		{
			moveSpriteToFrame(_enteredFrame);
			super.entered(point);
		}
		
		override public function leaved(point:Point = null):void
		{
			moveSpriteToFrame(_leavedFrame);
			super.leaved(point);
		}
	}
}