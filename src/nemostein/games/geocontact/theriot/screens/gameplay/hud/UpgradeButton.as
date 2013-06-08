package nemostein.games.geocontact.theriot.screens.gameplay.hud
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.modules.container.entity.AnchorAlign;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.framework.dragonfly.modules.text.ShadowedText;
	import nemostein.framework.dragonfly.modules.widgets.Button;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.buttons.HUDButtonBigDown;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.buttons.HUDButtonBigUp;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.hud.icons.IconPlus;
	import nemostein.utils.MathUtils;
	
	public class UpgradeButton extends Button
	{
		private var _iconClass:Class;
		
		private var _up:Entity;
		private var _down:Entity;
		private var _icon:Entity;
		private var _plus:Entity;
		private var _price:ShadowedText;
		private var _value:ShadowedText;
		
		public function UpgradeButton(iconClass:Class)
		{
			_iconClass = iconClass;
			
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_up = new Entity();
			_down = new Entity();
			_plus = new Entity();
			_icon = new Entity();
			
			_up.draw(new HUDButtonBigUp());
			_down.draw(new HUDButtonBigDown());
			_plus.draw(new IconPlus());
			_icon.draw(new _iconClass());
			
			_price = new ShadowedText("$0", "Lead III", 8, 0xffc0e5f0);
			_value = new ShadowedText("0", "Lead III", 8, 0xffc0e5f0);
			
			_price.setShadow( -1, 1, 0x80000000);
			_value.setShadow( -1, 1, 0x80000000);
			
			_price.alignAnchor(AnchorAlign.TOP, AnchorAlign.RIGHT);
			_value.alignAnchor(AnchorAlign.TOP, AnchorAlign.RIGHT);
			
			width = _up.width;
			height = _up.height;
			
			_down.hide();
			
			_plus.x = 2;
			_plus.y = 4;
			
			_price.x = 50;
			_price.y = 2;
			
			_value.x = 50;
			_value.y = 30;
			
			_icon.x = int((width - _icon.width) / 2);
			_icon.y = int((height - _icon.height) / 2);
			
			add(_up);
			add(_down);
			add(_plus);
			add(_price);
			add(_value);
			add(_icon);
		}
		
		public function set price(value:int):void 
		{
			_price.text = "$" + value;
		}
		
		public function set value(value:Number):void 
		{
			_value.text = MathUtils.round(value, 2) + "";
		}
		
		public function hideValue():void 
		{
			_value.hide();
		}
		
		override public function pressed(point:Point = null):void
		{
			_up.hide();
			_down.show();
			
			_plus.y += 1;
			_price.y += 1;
			_value.y += 1;
			_icon.y += 1;
			
			super.pressed(point);
		}
		
		override public function released(point:Point = null):void
		{
			_up.show();
			_down.hide();
			
			_plus.y -= 1;
			_price.y -= 1;
			_value.y -= 1;
			_icon.y -= 1;
			
			super.released(point);
		}
	}
}