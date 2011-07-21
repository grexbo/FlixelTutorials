package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	import flash.utils.getTimer;

	public class Player extends FlxSprite
	{
		[Embed(source = '../assets/player.png')] private var playerPNG:Class;
		
		private var bulletDelay:int = 75;
		private var lastFired:int;
		private var xSpeed:uint = 200;
		private var ySpeed:uint = 100;
		public var lives:uint = 3;
		
		//partial invisibility on player life loss
		private var isInvinsible:Boolean = false;
		private var invincibleTimer:FlxDelay;
		
		public var fireType:int = 1;
		
		public function Player() 
		{
			super(FlxG.width / 2, FlxG.height - 16, playerPNG);
			
			scrollFactor.x = 1;
			scrollFactor.y = 0;
			
			health = 100;
			
			//create timer for invincibility here to use in update
			//do not start yet,we are mortal on create
			invincibleTimer = new FlxDelay(2000);
			
			x = 180;
			y = 200;
		}
		
		override public function kill():void
		{
			lives--;
			
			//added some invisibility after life loss
			if (lives != 0) 
			{
				invincibleTimer = new FlxDelay(2000);
				invincibleTimer.start();
				isInvinsible = true;
			}
			
			health = 100;
		}
		
		public function bulletHitPlayer(bullet:FlxObject, player:FlxObject):void
		{
			if (FlxCollision.pixelPerfectCheck(bullet as FlxSprite, player as FlxSprite))
			{
				if (!isInvinsible)
				{   // if player is vulnerable
					//Hurt the player by the bullet damage amount
					hurt(EnemyBullet(bullet).damage);
				}
				//	Kill off the bullet, we're done with it now
				bullet.kill();
				
				//	Small FX
				Registry.fx.explodeBlock(x, y);
					
				//flixel 2.5 change
				//FlxG.quake.start();
				FlxG.shake(0.05, 0.5);
			}
			
		}
		
		override public function update():void
		{
			super.update();
			
			//check if invincibility ended
			if (invincibleTimer.hasExpired) isInvinsible = false;
			
			//if invinsible do some effect!
			if (isInvinsible )
			{
				this.blend = "screen"; 
				//some slowmotion?
				FlxG.timeScale = 0.5;
				//this.allowCollisions = 0;
			} else 
			{
				this.blend = null; 
				FlxG.timeScale = 1;
				//this.allowCollisions = 1;
			}
				
			
			velocity.x = 0;
			velocity.y = 0;
			
			//	Need to adds bound checking to these (as it can probably go too far left right now)
			if (FlxG.keys.LEFT && x > 0)
			{
				velocity.x -= xSpeed;
			}
			
			if (FlxG.keys.RIGHT && x < FlxG.width - width)
			{
				velocity.x += xSpeed;
			}
			
			if (FlxG.keys.UP && y >= 100)
			{
				velocity.y -= ySpeed;
				
				if (y < 100)
				{
					y = 100;
				}
			}
			
			if (FlxG.keys.DOWN && y < FlxG.height - height)
			{
				velocity.y += ySpeed;
			}
			
			//	Keep the ship on the screen at all times
			if (x < 0)
			{
				x = 0;
			}
			else if (x > FlxG.width - width)
			{
				x = FlxG.width - width;
			}
			
			//	Fire!
			if (FlxG.keys.CONTROL && getTimer() > lastFired + bulletDelay)
			{
				switch (fireType)
				{
					case 1:
						Registry.playerBullets.fire(x + 5, y);
						break;
						
					case 2:
						//	Double fire!
						Registry.playerBullets.fire(x, y);
						Registry.playerBullets.fire(x + 10, y);
						break;
						
					case 3:
						//	Quad fire!
						Registry.playerBullets.fire(x - 8, y);
						Registry.playerBullets.fire(x, y - 4);
						Registry.playerBullets.fire(x + 10, y - 4);
						Registry.playerBullets.fire(x + 18, y);
						break;
				}
				
				lastFired = getTimer();
			}
			
		}
		
	}

}