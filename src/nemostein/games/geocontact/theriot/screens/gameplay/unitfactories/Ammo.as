package nemostein.games.geocontact.theriot.screens.gameplay.unitfactories
{
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.games.geocontact.theriot.screens.gameplay.GamePlayScreen;
	
	public class Ammo extends Entity
	{
		protected var speed:Number;
		
		public var target:Unit;
		public var power:Number;
		
		override protected function update():void 
		{
			var moveSpeed:Number = speed * time;
			var distanceX:Number = target.x - x;
			var distanceY:Number = target.y - y;
			var distance:Number = Math.sqrt(distanceX * distanceX + distanceY * distanceY);
			
			if (distance > moveSpeed)
			{
				x += distanceX / distance * moveSpeed;
				y += distanceY / distance * moveSpeed;
			}
			else
			{
				GamePlayScreen.service.removeAmmo(this);
				
				target.hit(power);
			}
			
			super.update();
		}
	}
}