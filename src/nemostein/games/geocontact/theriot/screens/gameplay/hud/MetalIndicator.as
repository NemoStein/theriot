package nemostein.games.geocontact.theriot.screens.gameplay.hud
{
	import nemostein.framework.dragonfly.modules.text.ShadowedText;
	import nemostein.games.geocontact.theriot.screens.gameplay.GamePlayScreen;
	import nemostein.utils.StringUtils;
	
	public class MetalIndicator extends ShadowedText
	{
		public function MetalIndicator()
		{
			super("$0", "Lead III", 8, 0xffc0e5f0);
		}
		
		override protected function update():void
		{
			text = "$" + StringUtils.formatNumber(GamePlayScreen.service.getPlayerMetal(), ",", ".");
			
			super.update();
		}
	}
}