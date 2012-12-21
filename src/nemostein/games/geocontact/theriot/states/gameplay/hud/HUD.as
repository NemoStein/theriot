package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import flash.geom.Point;
	import nemostein.framework.dragonfly.Bar;
	import nemostein.framework.dragonfly.Container;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayService;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	
	public class HUD extends Container
	{
		override protected function initialize():void
		{
			super.initialize();
			
			addEnergyBar();
			addElapsedFightTime();
			addMinimap();
			addProgressBar();
			addResourcesIndicator();
			addWeatherIndicator();
		}
		
		private function addEnergyBar():void
		{
			var gamePlayService:GamePlayService = GamePlay.service;
			var playerComplex:Complex = gamePlayService.complexPlayer;
			
			var content:Entity = new Entity();
			content.drawRectangle(100, 6, 0xffaa1100);
			
			content.x = 2;
			content.y = 2;
			
			var energyBar:Bar = new Bar(content, playerComplex.getEnergy, playerComplex.getEnergyLimit);
			energyBar.drawRectangle(104, 10, 0xff441100);
			
			var slotPlayer:Point = gamePlayService.level.slotPlayer;
			
			energyBar.x = slotPlayer.x - 52;
			energyBar.y = slotPlayer.x + 10;
			
			add(energyBar);
		}
		
		private function addElapsedFightTime():void 
		{
			
		}
		
		private function addMinimap():void 
		{
			
		}
		
		private function addProgressBar():void 
		{
			
		}
		
		private function addResourcesIndicator():void 
		{
			
		}
		
		private function addWeatherIndicator():void 
		{
			
		}
	}
}