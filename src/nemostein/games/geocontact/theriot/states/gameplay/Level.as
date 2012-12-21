package nemostein.games.geocontact.theriot.states.gameplay
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import nemostein.bezier.Path;
	import nemostein.bezier.Paths;
	import nemostein.framework.dragonfly.Container;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	import nemostein.utils.ErrorUtils;
	
	public class Level extends Container
	{
		private var _paths:Paths;
		
		override protected function initialize():void
		{
			super.initialize();
			
			_paths = paths;
			
			var complexPlayer:Complex = new complexPlayerClass();
			
			var complexAI:Complex = new complexAIClass();
			complexAI.controlledByAI();
			
			complexPlayer.x = slotPlayer.x;
			complexPlayer.y = slotPlayer.y;
			
			complexAI.x = slotAI.x;
			complexAI.y = slotAI.y;
			
			add(levelBackground);
			add(complexPlayer);
			add(complexAI);
			
			var gamePlayService:GamePlayService = GamePlay.service;
			
			gamePlayService.setPlayerComplex(complexPlayer);
			gamePlayService.setAIComplex(complexAI);
			gamePlayService.setBounds(levelBounds);
			
			debugDrawPaths();
		}
		
		public function getPath(reverse:Boolean = false, index:int = -1):Path
		{
			return _paths.getPath(reverse, index);
		}
		
		//{ Debug Draw
		
		private function debugDrawPaths():void
		{
			var shape:Shape = new Shape();
			
			shape.graphics.lineStyle(8, 0x802020);
			for (var i:int = 0; i < _paths.forward.length; ++i)
			{
				debugDrawPath(shape.graphics, _paths.forward[i], false);
			}
			
			shape.graphics.lineStyle(2, 0x208080);
			for (var j:int = 0; j < _paths.backward.length; ++j)
			{
				debugDrawPath(shape.graphics, _paths.backward[j], true);
			}
			
			var bitmapData:BitmapData = new BitmapData(bounds.width, bounds.height, true, 0);
			bitmapData.draw(shape);
			
			var entity:Entity = new Entity();
			entity.draw(bitmapData);
			
			add(entity);
		}
		
		private function debugDrawPath(graphics:Graphics, path:Path, reverse:Boolean):void
		{
			//trace(":>", path);
			
			var result:Point = new Point();
			
			path.quadBezierSegment.interpolate(0, result);
			graphics.moveTo(result.x, result.y);
			
			for (var i:int = 0; i <= 10; ++i)
			{
				path.quadBezierSegment.interpolate(i / 10, result);
				graphics.lineTo(result.x, result.y);
			}
			
			for each (var path:Path in(!reverse ? path.forward : path.backward))
			{
				debugDrawPath(graphics, path, reverse);
			}
		}
		
		//}
		
		//{ Abstracts
		
		protected function get paths():Paths
		{
			throw ErrorUtils.abstractMethod(this, "Level", "paths");
		}
		
		protected function get levelBackground():Entity
		{
			throw ErrorUtils.abstractMethod(this, "Level", "background");
		}
		
		protected function get levelBounds():Rectangle
		{
			throw ErrorUtils.abstractMethod(this, "Level", "bounds");
		}
		
		protected function get complexPlayerClass():Class
		{
			throw ErrorUtils.abstractMethod(this, "Level", "complexPlayerClass");
		}
		
		protected function get complexAIClass():Class
		{
			throw ErrorUtils.abstractMethod(this, "Level", "complexAIClass");
		}
		
		public function get slotPlayer():Point
		{
			throw ErrorUtils.abstractMethod(this, "Level", "slotPlayer");
		}
		
		public function get slotAI():Point
		{
			throw ErrorUtils.abstractMethod(this, "Level", "slotAI");
		}
	
		//}
	}
}