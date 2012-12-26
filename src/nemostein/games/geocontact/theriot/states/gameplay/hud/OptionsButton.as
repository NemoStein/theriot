package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import nemostein.framework.dragonfly.Button;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall1down;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall1up;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.icons.AssetStatesGameplayHudIconsOptions;
	
	public class OptionsButton extends Button
	{
		private var _up:Entity;
		private var _down:Entity;
		private var _icon:Entity;
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_up = new Entity();
			_down = new Entity();
			_icon = new Entity();
			
			_up.draw(new AssetStatesGameplayHudButtonsSmall1up().bitmapData);
			_down.draw(new AssetStatesGameplayHudButtonsSmall1down().bitmapData);
			_icon.draw(new AssetStatesGameplayHudIconsOptions().bitmapData);
			
			_down.visible = false;
			
			_icon.x = 3;
			_icon.y = 3;
			
			width = _up.width;
			height = _up.height;
			
			add(_up);
			add(_down);
			add(_icon);
		}
		
		override public function pressed(point:Point = null):void 
		{
			_up.visible = false;
			_down.visible = true;
			
			_icon.y += 1;
			
			super.pressed(point);
		}
		
		override public function released(point:Point = null):void 
		{
			_up.visible = true;
			_down.visible = false;
			
			_icon.y -= 1;
			
			super.released(point);
		}
	}
}