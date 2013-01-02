package nemostein.games.geocontact.theriot.states.gameplay.leveltest
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import nemostein.bezier.Paths;
	import nemostein.bezier.PathService;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.levelTest.AssetStatesGameplayLevelTestBackground;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.levelTest.AssetStatesGameplayLevelTestPaths;
	import nemostein.games.geocontact.theriot.states.gameplay.Level;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.SimpleComplex;
	
	public class LevelTest extends Level
	{
		private var _background:Entity;
		
		override protected function initialize():void
		{
			_background = new Entity();
			_background.draw(new AssetStatesGameplayLevelTestBackground().bitmapData);
			
			super.initialize();
		}
		
		override protected function get paths():Paths
		{
			return PathService.resolvePaths(new AssetStatesGameplayLevelTestPaths());
		}
		
		override protected function get levelBackground():Entity 
		{
			return _background;
		}
		
		override protected function get levelBounds():Rectangle 
		{
			return new Rectangle(0, 0, _background.width, _background.height);
		}
		
		override protected function get complexPlayerClass():Class
		{
			return SimpleComplex;
		}
		
		override protected function get complexAIClass():Class
		{
			return SimpleComplex;
		}
		
		override public function get slotPlayer():Point
		{
			return new Point(180, 256);
		}
		
		override public function get slotAI():Point
		{
			return new Point(1593, 1008);
		}
	}
}