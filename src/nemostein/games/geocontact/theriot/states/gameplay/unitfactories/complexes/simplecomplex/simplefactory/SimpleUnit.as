package nemostein.games.geocontact.theriot.states.gameplay.unitfactories.complexes.simplecomplex.simplefactory
{
	import nemostein.framework.dragonfly.AnchorAlign;
	import nemostein.framework.dragonfly.Animation;
	import nemostein.games.geocontact.theriot.assets.AssetTest;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Factory;
	import nemostein.games.geocontact.theriot.states.gameplay.unitfactories.Unit;
	import nemostein.games.geocontact.theriot.states.gameplay.GamePlayService;
	
	public class SimpleUnit extends Unit
	{
		static public const RUN:String = "run";
		static public const FIRE:String = "fire";
		static public const DIE:String = "die";
		
		private var lookAngles:Array;
		private var lookAngle:int;
		
		public function SimpleUnit(factory:Factory)
		{
			super(factory, SimpleBullet);
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			//if (!factory.complex.ai)
			//{
				//drawRectangle(8, 8, 0xffff0000);
			//}
			//else
			//{
				//drawRectangle(8, 8, 0xff0000ff);
			//}
			//
			//alignAnchor(AnchorAlign.CENTER, AnchorAlign.CENTER);
			
			draw(new AssetTest().bitmapData);
			
			width = 26;
			height = 26;
			
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
			if (keyframe == 0)
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