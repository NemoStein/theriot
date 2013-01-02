package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import nemostein.framework.dragonfly.modules.text.ShadowedText;
	import nemostein.framework.dragonfly.modules.text.Text;
	
	public class FactoryLockText extends ShadowedText
	{
		private var _template:String;
		
		public function FactoryLockText()
		{
			_template = "This factory is Locked\rBuy Factory $$ to unlock";
			
			super(_template, "Lead III", 8, 0xffc0e5f0, Text.CENTER);
		}
	}
}