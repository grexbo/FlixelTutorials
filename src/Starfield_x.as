package  
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import org.flixel.*;

	//NOTE: THIS CLASS is NOT used in game (Flixel 2.5 version)
	//we use StartFieldFx plugin by Photonstorm
	public class Starfield extends FlxSprite
	{
		private var stars:Array;
		private var starColours:Array;
		private var fillRect:Rectangle;
		private var scratch:BitmapData;
		
		public function Starfield() 
		{
			super();
			
			makeGraphic(FlxG.width, FlxG.height, 0xff000000);
			
			fillRect = new Rectangle(0, 0, FlxG.width, FlxG.height);
			
			stars = new Array;
			
			for (var i:int = 0; i < 100; i++)
			{
				stars.push( { x: int(Math.random() * FlxG.width), y: int(Math.random() * FlxG.height), speed: 2 + int(Math.random() * 4) } );
			}
			
			//	The stars are coloured based on their speed (closer to camera = brighter)
			starColours = new Array(0, 0, 0xff888888, 0xffaaaaaa, 0xffcccccc, 0xffdedede, 0xffF7F7F7);
		}
		
		override public function update():void
		{
			super.update();
			
			scratch = pixels;
			
			scratch.fillRect(fillRect, 0x000000);
			
			for each (var star:Object in stars)
			{
				scratch.setPixel32(star.x, star.y, starColours[star.speed]);
				
				star.y += star.speed;
				
				if (star.y > FlxG.height)
				{
					star.x = int(Math.random() * FlxG.width);
					star.y = 0;
					star.speed = 2 + int(Math.random() * 4);
				}
			}
			
			pixels = scratch;
			
		}
		
	}

}