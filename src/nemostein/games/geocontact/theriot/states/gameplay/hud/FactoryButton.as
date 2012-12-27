package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.Button;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.framework.dragonfly.plugins.shadowedtext.ShadowedText;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall1down;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall1up;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall2down;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall2up;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall3down;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall3up;
	
	public class FactoryButton extends Button
	{
		private var _factoryName:String;
		
		private var _up:Entity;
		private var _down:Entity;
		private var _label:ShadowedText;
		
		public function FactoryButton(factoryName:String)
		{
			_factoryName = factoryName;
			
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_up = new Entity();
			_down = new Entity();
			
			_up.draw(new AssetStatesGameplayHudButtonsSmall3up().bitmapData);
			_down.draw(new AssetStatesGameplayHudButtonsSmall3down().bitmapData);
			
			_label = new ShadowedText(_factoryName, "Lead III", 8, 0xffc0e5f0);
			_label.setShadow( -1, 1, 0x80000000);
			_label.alignAnchor(AnchorAlign.TOP, AnchorAlign.CENTER);
			
			width = _up.width;
			height = _up.height;
			
			_label.x = 10;
			_label.y = 6;
			
			_down.visible = false;
			
			add(_up);
			add(_down);
			add(_label);
		}
		
		override public function pressed(point:Point = null):void
		{
			_up.visible = false;
			_down.visible = true;
			
			_label.y += 1;
			
			super.pressed(point);
		}
		
		override public function released(point:Point = null):void
		{
			_up.visible = true;
			_down.visible = false;
			
			_label.y -= 1;
			
			super.released(point);
		}
		
		public function enable():void 
		{
			_up.draw(new AssetStatesGameplayHudButtonsSmall1up().bitmapData);
			_down.draw(new AssetStatesGameplayHudButtonsSmall1down().bitmapData);
		}
		
		public function unlock():void 
		{
			_up.draw(new AssetStatesGameplayHudButtonsSmall2up().bitmapData);
			_down.draw(new AssetStatesGameplayHudButtonsSmall2down().bitmapData);
		}
	}
}