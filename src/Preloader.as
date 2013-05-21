package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	
	public class Preloader extends MovieClip
	{
		public function Preloader()
		{
			addEventListener(Event.ENTER_FRAME, checkFrame);
			
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
		
			// TODO show loader
		}
		
		private function ioError(event:IOErrorEvent):void
		{
			trace(event.text);
		}
		
		private function progress(event:ProgressEvent):void
		{
			// TODO update loader
		}
		
		private function checkFrame(event:Event):void
		{
			if (currentFrame == totalFrames)
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			
			startup();
		}
		
		private function startup():void
		{
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(Sprite(new mainClass()));
		}
	}
}