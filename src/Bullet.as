package  
{
	import org.flixel.FlxSprite;

	public class Bullet extends FlxSprite
	{
		[Embed(source = '../assets/bullet.png')] private var bulletPNG:Class;
		
		public var damage:int = 1;
		public var speed:int = 300;
		
		public function Bullet() 
		{
			super(0, 0, bulletPNG);
			
			//	We do this so it's ready for pool allocation straight away
			visible = true;
			exists = false;
			scrollFactor.x = 0;
			scrollFactor.y = 0;
		}

		public function fire(bx:int, by:int):void
		{
			x = bx;
			y = by;
			velocity.y = -speed;
			exists = true;
			visible = true;
		}
		
		override public function update():void
		{
			super.update();
			
			//	Bullet off the top of the screen?
			if (exists && y < -height)
			{
				exists = false;
			}
		}
		
	}

}