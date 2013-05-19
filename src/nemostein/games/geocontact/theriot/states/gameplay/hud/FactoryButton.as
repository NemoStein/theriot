package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.Button;
	import nemostein.framework.dragonfly.modules.container.entity.AnchorAlign;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.framework.dragonfly.modules.text.ShadowedText;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall1down;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall1up;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall2down;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall2up;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall3down;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.buttons.AssetStatesGameplayHudButtonsSmall3up;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs0;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs1;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs2;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs3;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs4;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.tabs.AssetStatesGameplayHudTabs5;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Factory;
	
	public class FactoryButton extends Button
	{
		private const _tabsData:Vector.<Class> = new <Class>
		[
			AssetStatesGameplayHudTabs0,
			AssetStatesGameplayHudTabs1,
			AssetStatesGameplayHudTabs2,
			AssetStatesGameplayHudTabs3,
			AssetStatesGameplayHudTabs4,
			AssetStatesGameplayHudTabs5
		];
		
		private var _factory:Factory;
		
		private var _tab:Entity;
		private var _up:Entity;
		private var _down:Entity;
		private var _label:ShadowedText;
		private var _slot:int;
		
		private var _enabled:Boolean;
		private var _unlocked:Boolean;
		
		public function FactoryButton(factory:Factory, slot:int)
		{
			_factory = factory;
			_slot = slot;
			
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_tab = new Entity();
			_up = new Entity();
			_down = new Entity();
			
			_tab.draw(new _tabsData[_slot]().bitmapData);
			_up.draw(new AssetStatesGameplayHudButtonsSmall3up().bitmapData);
			_down.draw(new AssetStatesGameplayHudButtonsSmall3down().bitmapData);
			
			_label = new ShadowedText(_factory.name, "Lead III", 8, 0xffc0e5f0);
			_label.setShadow(-1, 1, 0x80000000);
			_label.alignAnchor(AnchorAlign.TOP, AnchorAlign.CENTER);
			_label.x = 10;
			_label.y = 6;
			
			_tab.x = -2 - (_slot * 25);
			_tab.y = -2;
			
			_down.hide();
			_tab.hide();
			
			width = _up.width;
			height = _up.height;
			
			onExecute = execute;
			
			add(_tab);
			add(_up);
			add(_down);
			add(_label);
		}
		
		private function execute(point:Point):void
		{
			GamePlay.service.switchFactoryTabTo(this);
		}
		
		override protected function update():void
		{
			if (!_unlocked && _factory.unlocked)
			{
				unlock();
			}
			else if (!_enabled && _factory.enabled)
			{
				enable();
			}
			
			super.update();
		}
		
		override public function pressed(point:Point = null):void
		{
			_up.hide();
			_down.show();
			
			_label.y += 1;
			
			super.pressed(point);
		}
		
		override public function released(point:Point = null):void
		{
			_up.show();
			_down.hide();
			
			_label.y -= 1;
			
			super.released(point);
		}
		
		public function toggle(on:Boolean):void
		{
			if (on)
			{
				_tab.show();
			}
			else
			{
				_tab.hide();
			}
		}
		
		public function enable():void
		{
			_up.draw(new AssetStatesGameplayHudButtonsSmall1up().bitmapData);
			_down.draw(new AssetStatesGameplayHudButtonsSmall1down().bitmapData);
			
			_enabled = true;
		}
		
		public function unlock():void
		{
			_up.draw(new AssetStatesGameplayHudButtonsSmall2up().bitmapData);
			_down.draw(new AssetStatesGameplayHudButtonsSmall2down().bitmapData);
			
			_unlocked = true;
		}
		
		public function get enabled():Boolean
		{
			return _factory.enabled;
		}
		
		public function get unlocked():Boolean
		{
			return _factory.unlocked;
		}
		
		public function get factory():Factory
		{
			return _factory;
		}
	}
}