package  
{
	import org.flixel.FlxCamera;
	public class Registry
	{
		public static var player:Player;
		public static var playerBullets:BulletManager;
		public static var enemyBullets:EnemyBulletManager;
		public static var enemies:EnemyManager;
		public static var background:ScrollingBackground;
		public static var fx:Fx;
		public static var hud:HUD;
		public static var mainCamera:FlxCamera;
		
		public function Registry() 
		{
		}
		
		public static function init():void
		{
			mainCamera = new FlxCamera(0, 0, 240, 320, 0);
			player = new Player;
			playerBullets = new BulletManager;
			
			enemies = new EnemyManager;
			enemyBullets = new EnemyBulletManager;
			
			background = new ScrollingBackground;
			fx = new Fx;
			hud = new HUD;
		}
		
		public static function destroy():void
		{
			player = null;
			playerBullets = null;
			
			enemies = null;
			enemyBullets = null;
			
			background = null;
			fx = null;
		}
		
	}

}