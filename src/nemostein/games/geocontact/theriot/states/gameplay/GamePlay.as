package nemostein.games.geocontact.theriot.states.gameplay 
{
	import nemostein.framework.dragonfly.Container;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Complex;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.SimpleComplex;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory.SimpleFactory;
	
	public class GamePlay extends Container 
	{
		static private var _gamePlayService:GamePlayService;
		
		static public function get service():GamePlayService
		{
			return _gamePlayService;
		}
		
		private var _complexA:Complex;
		private var _complexB:Complex;
		
		override protected function initialize():void 
		{
			super.initialize();
			
			_gamePlayService = new GamePlayService(this, input);
			
			_complexA = new SimpleComplex();
			_complexB = new SimpleComplex(true);
			
			_complexA.enemyComplex = _complexB;
			_complexB.enemyComplex = _complexA;
			
			_complexA.id = "A";
			_complexB.id = "B";
			
			_complexA.addFactory(SimpleFactory);
			_complexB.addFactory(SimpleFactory);
			
			_gamePlayService.addComplex(_complexA);
			_gamePlayService.addComplex(_complexB);
		}
		
		override protected function update():void 
		{
			super.update();
		}
	}
}