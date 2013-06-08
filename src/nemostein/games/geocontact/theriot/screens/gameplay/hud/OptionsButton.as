package nemostein.games.geocontact.theriot.screens.gameplay.hud
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.framework.dragonfly.modules.widgets.Button;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.buttons.HUDButtonReadyDown;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.buttons.HUDButtonReadyUp;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.icons.IconOptions;
	
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
			
			_up.draw(new HUDButtonReadyUp());
			_down.draw(new HUDButtonReadyDown());
			_icon.draw(new IconOptions());
			
			_down.hide();
			
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
			_up.hide();
			_down.show();
			
			_icon.y += 1;
			
			super.pressed(point);
		}
		
		override public function released(point:Point = null):void
		{
			_up.show();
			_down.hide();
			
			_icon.y -= 1;
			
			super.released(point);
		}
	}
}