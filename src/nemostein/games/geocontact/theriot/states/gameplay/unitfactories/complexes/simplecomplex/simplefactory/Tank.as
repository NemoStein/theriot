package animationTest
{
	import nemostein.framework.dragonfly.Animation;
	import nemostein.framework.dragonfly.Core;
	
	public class Tank extends Core
	{
		static public const RUN:String = "run";
		static public const FIRE:String = "fire";
		static public const DIE:String = "die";
		
		private var lookAngles:Array;
		private var lookAngle:int;
		
		override protected function initialize():void
		{
			super.initialize();
			
			draw(new AssetTest().bitmapData);
			
			addAnimation(RUN, [0, 1, 2], 10, true, callback);
			addAnimation(FIRE, [3, 4, 5], 10, true, callback);
			addAnimation(DIE, [6, 7, 8], 10, true, callback);
			
			lookAngles = new Array();
			
			lookAngles[ 0] = 0;
			lookAngles[ 1] = 26;
			lookAngles[ 2] = 52;
			lookAngles[ 3] = 78;
			lookAngles[ 4] = 104;
			lookAngles[-4] = 104;
			lookAngles[-3] = 130;
			lookAngles[-2] = 156;
			lookAngles[-1] = 182;
			
			playAnimation(RUN);
		}
		
		private function callback(animation:Animation, keyframe:int):void
		{
			if(keyframe == 0)
			{
				if (animation.id == RUN)
				{
					playAnimation(FIRE);
				}
				else if (animation.id == FIRE)
				{
					playAnimation(DIE);
				}
				else
				{
					if (++lookAngle > 4)
					{
						lookAngle = -3;
					}
					
					frame.y = lookAngles[lookAngle];
					playAnimation(RUN);
				}
			}
		}
	}
}