package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	public class Enemy extends FlxSprite
	{
		[Embed(source = '../assets/space-baddie.png')] private var enemyPNG:Class;
		
		private var fireTime:FlxDelay;
		private var willFire:Boolean = false;
		
		public function Enemy() 
		{
			super(0, 0, enemyPNG);
			//this.loadGraphic(enemyPNG,true, false, 33, 15);
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			exists = false;
		}
		
		public function launch():void
		{
			x = 64 + int(Math.random() * (FlxG.width - 128));
			y = -16;
			velocity.x = -50 + int(Math.random() * 100);
			velocity.y = 50;
			
			//	Will they shoot at the player? 70% chance of doing so
			if (FlxMath.chanceRoll(70))
			{
				willFire = true;
				fireTime = new FlxDelay(1000 + int(Math.random() * 500));
				fireTime.start();
			}
			
			health = 4;
			exists = true;
			visible = true;
		}
		
		override public function kill():void
		{
			super.kill();
			
			FlxG.score += 100;
		}
		
		override public function update():void
		{
			super.update();
			
			if (willFire && fireTime.hasExpired)
			{
				Registry.enemyBullets.fire(x, y);
				willFire = false;
			}
			
			if (y > FlxG.height)
			{
				exists = false;
			}
		}
		
	}

}