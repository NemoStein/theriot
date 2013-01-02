package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import nemostein.framework.dragonfly.modules.text.ShadowedText;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlay;
	import nemostein.utils.StringUtils;
	
	public class ScrapsIndicator extends ShadowedText
	{
		public function ScrapsIndicator()
		{
			super("$0", "Lead III", 8, 0xffc0e5f0);
		}
		
		override protected function update():void
		{
			text = "$" + StringUtils.formatNumber(GamePlay.service.getPlayerScraps(), ",", ".");
			
			super.update();
		}
	}
}