package  
{
	//RETURN FIRE SHOOTER EXAMPLE
	//Original by Photonstorm
	//http://www.photonstorm.com/archives/1191/flash-game-dev-tip-8-building-a-shoot-em-up-part-3-return-fire
	
	//flixel 2.5 update by Grexbo
	
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		public function PlayState() 
		{
			super();
		}
		
		override public function create():void
		{
			
			Registry.init();
			
			add(Registry.background);
			add(Registry.enemyBullets);
			add(Registry.enemies);
			add(Registry.playerBullets);
			add(Registry.fx);
			add(Registry.player);
			add(Registry.hud);
			
		
			//Flixel 2.5
			// hud and FX should not be followed by camera
			Registry.hud.setAll("scrollFactor",new FlxPoint(0,0));
			Registry.hud.setAll("cameras", [FlxG.camera]);
			Registry.fx.setAll("scrollFactor", new FlxPoint(0, 0));
			Registry.fx.setAll("cameras", [FlxG.camera]);

			super.create();
			
			

		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.overlap(Registry.playerBullets, Registry.enemies, Registry.enemies.bulletHitEnemy);
			FlxG.overlap(Registry.enemyBullets, Registry.player, Registry.player.bulletHitPlayer);
			
			if (Registry.player.lives == 0 || FlxG.keys.justReleased("Q"))
			{
				FlxG.switchState(new GameOverState());
			}
			
			//	Debug Testing - these will come from power-ups at some stage
			if (FlxG.keys.justReleased("F1"))
			{
				Registry.player.fireType = 1;
			}
			
			if (FlxG.keys.justReleased("F2"))
			{
				Registry.player.fireType = 2;
			}
			
			if (FlxG.keys.justReleased("F3"))
			{
				Registry.player.fireType = 3;
			}
		}
		
		override public function destroy():void
		{
			Registry.hud.liveUpdate = false;
			
			Registry.destroy();
			
			super.destroy();
		}
		
	}

}