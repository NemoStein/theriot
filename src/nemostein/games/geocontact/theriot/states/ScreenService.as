package nemostein.games.geocontact.theriot.states
{
	import flash.utils.Dictionary;
	import nemostein.framework.dragonfly.modules.container.Container;
	
	public class ScreenService
	{
		private var _screenContainer:Container;
		private var _currentScreen:Screen;
		private var _screenSet:Dictionary;
		
		public function ScreenService() 
		{
			_screenContainer = new Container();
			_screenSet = new Dictionary();
		}
		
		public function getScreen(ScreenClass:Class):Screen
		{
			var screen:Screen = _screenSet[ScreenClass];
			if (!screen || screen.forceCreation)
			{
				screen = new ScreenClass();
				_screenSet[ScreenClass] = screen;
			}
			
			return screen;
		}
		
		public function setScreen(ScreenClass:Class, screen:Screen):void
		{
			_screenSet[ScreenClass] = screen;
		}
		
		public function load(screen:Screen, data:Object = null):Boolean
		{
			if (_currentScreen)
			{
				if (!_currentScreen.exit(screen))
				{
					return false;
				}
				_screenContainer.remove(_currentScreen);
			}
			
			_screenContainer.add(screen);
			screen.enter(_currentScreen, data);
			
			_currentScreen = screen;
			
			return true;
		}
		
		public function get container():Container 
		{
			return _screenContainer;
		}
	}
}