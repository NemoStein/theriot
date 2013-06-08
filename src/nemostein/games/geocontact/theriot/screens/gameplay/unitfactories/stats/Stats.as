package nemostein.games.geocontact.theriot.screens.gameplay.unitfactories.stats
{
	import nemostein.utils.ErrorUtils;
	
	public class Stats
	{
		private var _value:Number;
		private var _price:Number;
		
		public function Stats(value:Number, price:Number)
		{
			_value = value;
			_price = price;
		}
		
		public function upgrade():void
		{
			_value = calculateNextValue();
			_price = calculateNextPrice();
		}
		
		public function calculateNextValue():Number
		{
			return valueFormula();
		}
		
		public function calculateNextPrice():Number
		{
			return priceFormula();
		}
		
		protected function valueFormula():Number
		{
			throw ErrorUtils.abstractMethod(this, "Stats", "valueFormula");
		}
		
		protected function priceFormula():Number
		{
			throw ErrorUtils.abstractMethod(this, "Stats", "priceFormula");
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function get price():Number
		{
			return _price;
		}
	}
}