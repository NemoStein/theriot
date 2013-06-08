package nemostein.games.geocontact.theriot.system 
{
	import flash.net.SharedObject;
	
	public class GameData
	{
		//{ Static
		static private const LOCAL_STORAGE:String = "TheRiot";
		static private const SLOT_PREFIX:String = "slot";
		
		static public var current:GameData;
		
		static public function saveGame(slot:int, data:GameData):void 
		{
			var local:SharedObject = SharedObject.getLocal(LOCAL_STORAGE);
			local.data[SLOT_PREFIX + slot] = data;
			local.flush();
		}
		
		static public function loadGame(slot:int):GameData 
		{
			var local:SharedObject = SharedObject.getLocal(LOCAL_STORAGE);
			var data:Object = local.data[SLOT_PREFIX + slot];
			if (data)
			{
				var gameData:GameData = new GameData();
				for (var property:String in data) 
				{
					gameData[property] = data[property];
				}
				return gameData;
			}
			return null;
		}
		
		static public function deleteGame(slot:int):void
		{
			var local:SharedObject = SharedObject.getLocal(LOCAL_STORAGE);
			delete local.data[SLOT_PREFIX + slot];
			local.flush();
		}
		//}
		
		public var slot:int;
		public var level:int;
	}
}