package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	import flash.utils.getTimer;

	public class EnemyManager extends FlxGroup
	{
		private var lastReleased:int;
		private var releaseRate:int = 500;
		
		public function EnemyManager() 
		{
			super();
			
			//scrollFactor.x = 0;
			//scrollFactor.y = 0;
			
			for (var i:int = 0; i < 100; i++)
			{
				add(new Enemy);
			}
		}
		
		public function release():void
		{
			var enemy:Enemy = Enemy(getFirstAvailable());
			
			if (enemy)
			{
				enemy.launch();
			}
		}
		
		override public function update():void
		{
			super.update();
			
			if (getTimer() > lastReleased + releaseRate)
			{
				lastReleased = getTimer();
				
				release();
			}
		}
		
		public function bulletHitEnemy(bullet:FlxObject, enemy:FlxObject):void
		{
			if (FlxCollision.pixelPerfectCheck(bullet as FlxSprite, enemy as FlxSprite))
			{
				bullet.kill();
				
				enemy.hurt(1);
				
				Registry.fx.explodeBlock(enemy.x, enemy.y);
				
				FlxG.score += 10;
			}
		}
		
		
		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
		
			super.destroy();
		}
		
		
	}

}