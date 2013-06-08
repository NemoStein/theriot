package nemostein.games.geocontact.theriot.screens.loadgame
{
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.games.geocontact.theriot.assets.screens.BackButton;
	import nemostein.games.geocontact.theriot.assets.screens.DefaultBackground;
	import nemostein.games.geocontact.theriot.core.SimpleButton;
	import nemostein.games.geocontact.theriot.screens.levelselect.LevelSelectScreen;
	import nemostein.games.geocontact.theriot.screens.Screen;
	import nemostein.games.geocontact.theriot.screens.start.StartScreen;
	
	public class LoadGameScreen extends Screen
	{
		
		override protected function initialize():void
		{
			super.initialize();
			
			var background:Entity = new Entity(new DefaultBackground());
			
			var slot1:Slot = new Slot(1);
			var slot2:Slot = new Slot(2);
			var slot3:Slot = new Slot(3);
			
			var backButton:SimpleButton = new SimpleButton(new BackButton(), 81, 28, onBackButtonExecute);
			
			slot1.x = 74;
			slot1.y = 98;
			
			slot2.x = 74;
			slot2.y = 190;
			
			slot3.x = 74;
			slot3.y = 282;
			
			backButton.x = 745;
			backButton.y = 28;
			
			slot1.onExecute = onSlotExecute;
			slot2.onExecute = onSlotExecute;
			slot3.onExecute = onSlotExecute;
			
			add(background);
			add(slot1);
			add(slot2);
			add(slot3);
			add(backButton);
		}
		
		private function onSlotExecute():void
		{
			service.load(service.getScreen(LevelSelectScreen));
		}
		
		private function onBackButtonExecute():void
		{
			service.load(service.getScreen(StartScreen));
		}
		
		override public function get forceCreation():Boolean 
		{
			return true;
		}
	}
}