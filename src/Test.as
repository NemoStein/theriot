package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	

	public class Test extends Sprite
	{
		public function Test()
		{
			var elements:Array = ["A", "B", "C", "D", "E", "F"];
			var count:int = elements.length;
			var total:int = 0;
			
			for (var i:int = 1; i <= count; ++i)
			{
				var indexes:Array = [];
				for (var l:int = 0; l < i; ++l)
				{
					indexes[l] = l;
				}
				
				var c:int = combinations(count, i);
				total += c;
				trace("---", c);
				
				for (var j:int = 0; j < c; ++j)
				{
					var combo:String = "";
					
					for (var k:int = 0; k < i; ++k)
					{
						combo += elements[indexes[k]];
					}
					
					trace(combo);
					
					var index:int = i - 1;
					do
					{
						indexes[index]++;
						
						if (indexes[index] >= count - (i - index - 1))
						{
							index--;
							
							indexes[index]++;
							for (var m:int = 0; m < i - index; ++m)
							{
								indexes[index + m + 1] = indexes[index + m] + 1;
							}
						}
					}
					while (indexes[index] >= count - (i - index - 1));
				}
				
				trace("");
				trace("Total", total);
			}
		}
		
		private function combinations(n:int, s:int):int
		{
			return factorial(n) / (factorial(s) * factorial(n - s));
		}
		
		private function factorial(x:uint):uint
		{
			if (x < 2)
			{
				return 1;
			}
			
			return x * factorial(x - 1);
		}
	}
}