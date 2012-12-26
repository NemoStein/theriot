package nemostein.games.geocontact.theriot.states.gameplay.hud
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import nemostein.framework.dragonfly.Entity;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.weather.AssetStatesGameplayHudWeatherClear;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.weather.AssetStatesGameplayHudWeatherEletricalStorm;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.weather.AssetStatesGameplayHudWeatherFog;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.weather.AssetStatesGameplayHudWeatherHeat;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.weather.AssetStatesGameplayHudWeatherMeteorShower;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.weather.AssetStatesGameplayHudWeatherRain;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.weather.AssetStatesGameplayHudWeatherSnowfall;
	import nemostein.games.geocontact.theriot.assets.states.gameplay.hud.weather.AssetStatesGameplayHudWeatherWind;
	import nemostein.games.geocontact.theriot.states.gameplay.weathers.Weather;
	
	public class WeatherDisplay extends Entity
	{
		private var _currentWeathers:Vector.<Weather>;
		private var _weatherIcons:Vector.<BitmapData>;
		private var _changingWeather:Boolean;
		private var _scrollAmount:Number;
		
		override protected function initialize():void
		{
			super.initialize();
			
			_currentWeathers = new Vector.<Weather>();
			_weatherIcons = new Vector.<BitmapData>();
			
			_weatherIcons[Weather.CLEAR] = new AssetStatesGameplayHudWeatherClear().bitmapData;
			_weatherIcons[Weather.ELETRICAL_STORM] = new AssetStatesGameplayHudWeatherEletricalStorm().bitmapData;
			_weatherIcons[Weather.FOG] = new AssetStatesGameplayHudWeatherFog().bitmapData;
			_weatherIcons[Weather.HEAT] = new AssetStatesGameplayHudWeatherHeat().bitmapData;
			_weatherIcons[Weather.METEOR_SHOWER] = new AssetStatesGameplayHudWeatherMeteorShower().bitmapData;
			_weatherIcons[Weather.RAIN] = new AssetStatesGameplayHudWeatherRain().bitmapData;
			_weatherIcons[Weather.SNOWFALL] = new AssetStatesGameplayHudWeatherSnowfall().bitmapData;
			_weatherIcons[Weather.WIND] = new AssetStatesGameplayHudWeatherWind().bitmapData;
			
			_scrollAmount = 0;
			drawRectangle(97, 17, 0);
			
			for (var i:int = 0; i < 6; ++i)
			{
				var weather:Weather = new Weather();
				weather.type = int(Math.random() * 8);
				
				_currentWeathers.push(weather);
			}
			
			_changingWeather = true;
		}
		
		override protected function update():void
		{
			if (!_changingWeather)
			{
				var weather:Weather = getNextWeather();
				if (weather)
				{
					_currentWeathers.push(weather);
					_changingWeather = true;
				}
			}
			else
			{
				sprite.fillRect(frame, 0);
				
				var totalScroll:int = _weatherIcons[_currentWeathers[0].type].width;
				_scrollAmount += totalScroll * time;
				
				if (_scrollAmount >= totalScroll + 2)
				{
					_scrollAmount = 0;
					_currentWeathers.shift();
					_changingWeather = false;
				}
				
				var destination:Point = new Point(int(-_scrollAmount + 2), 0);
				
				for (var i:int = 0; i < _currentWeathers.length; ++i)
				{
					var icon:BitmapData = _weatherIcons[_currentWeathers[i].type];
					
					sprite.copyPixels(icon, icon.rect, destination);
					
					destination.x += icon.width + 2;
				}
			}
			
			super.update();
		}
		
		private function getNextWeather():Weather
		{
			if (Math.random() < 0.005)
			{
				var weather:Weather = new Weather();
				weather.type = int(Math.random() * 8);
				
				return weather;
			}
			
			return null;
		}
	}
}