package nemostein.games.geocontact.theriot.states.gameplay.unitfactories 
{
	import nemostein.framework.dragonfly.Entity;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayService;
	
	public class Bullet extends Entity
	{
		protected var gamePlayService:GamePlayService;
		
		protected var speed:Number;
		
		private var _target:Target;
		private var _power:Number;
		
		public function Bullet(target:Target, power:Number)
		{
			gamePlayService = GamePlay.service;
			
			_target = target;
			_power = power;
			
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			relative = false;
		}
		
		override protected function update():void 
		{
			super.update();
			
			var moveSpeed:Number = speed * time;
			
			var distanceX:Number = _target.x - x;
			var distanceY:Number = _target.y - y;
			var squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
			
			if (squareDistance > moveSpeed * moveSpeed)
			{
				var direction:Number = Math.atan2(distanceY, distanceX);
				
				x += Math.cos(direction) * moveSpeed;
				y += Math.sin(direction) * moveSpeed;
			}
			else
			{
				x = _target.x;
				y = _target.y;
				
				_target.hit(_power);
				parent.remove(this);
			}
		}
	}
}