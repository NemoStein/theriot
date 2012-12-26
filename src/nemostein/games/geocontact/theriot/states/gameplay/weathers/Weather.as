package nemostein.games.geocontact.theriot.states.gameplay.weathers
{
	
	public class Weather
	{
		static public const CLEAR:int = 0;
		static public const ELETRICAL_STORM:int = 1;
		static public const FOG:int = 2;
		static public const HEAT:int = 3;
		static public const METEOR_SHOWER:int = 4;
		static public const RAIN:int = 5;
		static public const SNOWFALL:int = 6;
		static public const WIND:int = 7;
		
		private var _type:int;
		
		public function Weather()
		{
		
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
		}
	}
}