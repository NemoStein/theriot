package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import nemostein.framework.dragonfly.Bar;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.energyBar.AssetStatesGameplayHudEnergyBarEnd;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.energyBar.AssetStatesGameplayHudEnergyBarMiddle;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.energyBar.AssetStatesGameplayHudEnergyBarStart;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	
	public class EnergyBar extends Bar
	{
		private var _start:Entity;
		private var _middle:Entity;
		private var _end:Entity;
		
		private var _length:Number;
		
		public function EnergyBar()
		{
			var playerComplex:Complex = GamePlay.service.complexPlayer;
			
			super(playerComplex.getEnergy, playerComplex.getEnergyLimit);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var startData:BitmapData = new AssetStatesGameplayHudEnergyBarStart().bitmapData;
			var middleData:BitmapData = new AssetStatesGameplayHudEnergyBarMiddle().bitmapData;
			var endData:BitmapData = new AssetStatesGameplayHudEnergyBarEnd().bitmapData;
			
			var middleWidth:int = 162;
			var origin:BitmapData = middleData;
			var matrix:Matrix = new Matrix();
			
			matrix.scale(middleWidth / origin.width, 1);
			
			middleData = new BitmapData(middleWidth, origin.height, false);
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
			
			_length = _start.width + _middle.width + _end.width;
			
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
			_middle.width = value - 2;
			_end.x = _start.width + _middle.width;
			
			_start.visible = !(value < 1);
			_end.visible = !(value < 2);
			_middle.visible = !(value < 3);
		}
	}
}