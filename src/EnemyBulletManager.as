package  
{
	import org.flixel.*;

	public class EnemyBulletManager extends FlxGroup
	{
		public function EnemyBulletManager() 
		{
			super();

			//flixel 2.5 change
			//scrollFactor depreciated!!
			//scrollFactor.x = 0;
			//scrollFactor.y = 0;
			
			//	There are 40 enemy bullets in our pool
			for (var i:int = 0; i < 40; i++)
			{
				add(new EnemyBullet);
			}
		}
		
		public function fire(bx:int, by:int):void
		{
			//flixel 2.5 change
			//use getFirstAvailable() instead of getFirstAvail()
			
			if (getFirstAvailable())
			{
				EnemyBullet(getFirstAvailable()).fire(bx, by);
			}
			
		}
		
	}

}