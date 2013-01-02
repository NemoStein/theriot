package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import nemostein.framework.dragonfly.Bar;
	import nemostein.framework.dragonfly.modules.container.entity.AnchorAlign;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.framework.dragonfly.modules.text.ShadowedText;
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
		private var _energyText:ShadowedText;
		
		private var _length:Number;
		
		private var _getEnergy:Function;
		private var _getEnergyLimit:Function;
		
		public function EnergyBar()
		{
			var playerComplex:Complex = GamePlay.service.complexPlayer;
			
			_getEnergy = playerComplex.getEnergy;
			_getEnergyLimit = playerComplex.getEnergyLimit;
			
			super(_getEnergy, _getEnergyLimit);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			var startData:BitmapData = new AssetStatesGameplayHudEnergyBarStart().bitmapData;
			var middleData:BitmapData = new AssetStatesGameplayHudEnergyBarMiddle().bitmapData;
			var endData:BitmapData = new AssetStatesGameplayHudEnergyBarEnd().bitmapData;
			
			var middleWidth:int = 163;
			var origin:BitmapData = middleData;
			var matrix:Matrix = new Matrix();
			
			matrix.scale(middleWidth / origin.width, 1);
			
			middleData = new BitmapData(middleWidth, origin.height, false);
			middleData.draw(origin, matrix);
			
			_start = new Entity();
			_middle = new Entity();
			_end = new Entity();
			
			_energyText = new ShadowedText("0/0", "Lead III", 8, 0xffc0e5f0);
			_energyText.alignAnchor(AnchorAlign.TOP, AnchorAlign.RIGHT);
			
			_start.draw(startData);
			_middle.draw(middleData);
			_end.draw(endData);
			
			_middle.x = _start.width;
			_end.x = _start.width + _middle.width;
			
			_energyText.x = 162;
			_energyText.y = 1;
			
			add(_start);
			add(_middle);
			add(_end);
			add(_energyText);
			
			_length = _start.width + _middle.width + _end.width;
			
			width = _length;
			height = _start.height;
		}
		
		override protected function update():void
		{
			_energyText.text = int(_getEnergy()) + "/" + int(_getEnergyLimit());
			
			super.update();
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
			
			value < 1 ? _start.hide() : _start.show();
			value < 2 ? _end.hide() : _end.show();
			value < 3 ? _middle.hide() : _middle.show();
		
			//_start.visible = !(value < 1);
			//_end.visible = !(value < 2);
			//_middle.visible = !(value < 3);
		}
	}
}