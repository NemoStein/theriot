package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.stats
{
	
	public class LinearStats extends Stats
	{
		private var _multiplier:Number;
		
		public function LinearStats(value:Number, price:Number, multiplier:Number)
		{
			super(value, price);
			
			_multiplier = multiplier;
		}
		
		override public function calculateNextValue():Number
		{
			return value * _multiplier;
		}
		
		override public function calculateNextPrice():Number
		{
			return price * _multiplier;
		}
	}
}