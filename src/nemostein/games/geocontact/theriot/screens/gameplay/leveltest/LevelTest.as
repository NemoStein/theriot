package nemostein.games.geocontact.theriot.screens.gameplay.leveltest
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import nemostein.bezier.Paths;
	import nemostein.bezier.PathService;
	import nemostein.framework.dragonfly.modules.container.entity.Entity;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.levelTest.LevelTestBackground;
	import nemostein.games.geocontact.theriot.assets.screens.gameplay.levelTest.LevelTestPaths;
	import nemostein.games.geocontact.theriot.screens.gameplay.Level;
	import nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.complexes.simplecomplex.SimpleComplex;
	
	public class LevelTest extends Level
	{
		private var _background:Entity;
		
		override protected function initialize():void
		{
			_background = new Entity();
			_background.draw(new LevelTestBackground());
			
			super.initialize();
		}
		
		override public function get levelBounds():Rectangle
		{
			return new Rectangle(0, 0, _background.width, _background.height);
		}
		
		override protected function get paths():Paths
		{
			return PathService.resolvePaths(new LevelTestPaths());
		}
		
		override protected function get levelBackground():Entity
		{
			return _background;
		}
		
		override protected function get complexPlayerClass():Class
		{
			return SimpleComplex;
		}
		
		override protected function get complexAIClass():Class
		{
			return SimpleComplex;
		}
		
		override protected function get initialMetalPlayer():int
		{
			return 1000;
		}
		
		override protected function get initialMetalAI():int
		{
			return 200;
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