package nemostein.games.geocontact.theriot.states.gameplay.upgradewheel
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.framework.dragonfly.plugins.shadowedtext.ShadowedText;
	import nemostein.framework.dragonfly.Text;
	
	public class WheelMenu extends Entity
	{
		protected var step:Number;
		protected var offset:Number;
		protected var radius:Number;
		protected var fields:Object;
		protected var fieldsOrder:Array;
		
		override protected function initialize():void
		{
			super.initialize();
			
			for (var i:int = 0; i < fieldsOrder.length; i++) 
			{
				var field:ShadowedText = fields[fieldsOrder[i]];
				
				field.setFormat("Lead II", 8, 0xffffff, Text.CENTER);
				field.alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
				
				field.x = Math.cos(i * step + offset) * radius;
				field.y = Math.sin(i * step + offset) * radius + 3;
				
				add(field);
			}
		}
		
		public function setStats(stats:Object):void 
		{
			for (var i:int = 0; i < fieldsOrder.length; i++) 
			{
				var field:Text = fields[fieldsOrder[i]];
				var value:int = stats[fieldsOrder[i]];
				
				field.text = field.text.replace(/[0-9]+/, value);
			}
		}
	}
}