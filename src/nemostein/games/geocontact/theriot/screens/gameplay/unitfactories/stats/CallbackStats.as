package nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats
{

	public class CallbackStats extends Stats
	{
		private var _valueFormulaCallback:Function;
		private var _priceFormulaCallback:Function;
		
		public function CallbackStats(value:Number, price:Number, valueFormulaCallback:Function, priceFormulaCallback:Function)
		{
			super(value, price);
			
			_valueFormulaCallback = valueFormulaCallback;
			_priceFormulaCallback = priceFormulaCallback;
		}
		
		override protected function valueFormula():Number
		{
			return _valueFormulaCallback(value, price);
		}
		
		override protected function priceFormula():Number
		{
			return _priceFormulaCallback(value, price);
		}
	}
}