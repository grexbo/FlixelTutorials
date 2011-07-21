package  
{
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.*;
	import org.flixel.*;

	public class GameOverState extends FlxState
	{
		private var gameOver:FlxText;
		private var playAgain:FlxButtonPlus;
		private var stars:FlxSprite;
		private var starfield:StarfieldFX;
		
		public function GameOverState() 
		{
			super();
		}
		
		override public function create():void
		{
			
			//stars as flixel 2.5 plugin !
			//starfield
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(0, 0.3);
			stars = starfield.create(0, 0, 320, 240, 256, 1, 10);
			//stars.angle = -80;
			
			super.create();
			
			//stars = new FlxStarField(0, 0, FlxG.width, FlxG.height, 100, 2, 30);
			
			gameOver = new FlxText(0, 48, 320, "GAME OVER");
			gameOver.alignment = "center";
			gameOver.size = 60;
			gameOver.alpha = 0.7;
			gameOver.color = 0xFF0080;
			
			playAgain = new FlxButtonPlus(0, 208, startGame, null, "Start");
			playAgain.screenCenter();
			
			add(stars);
			add(gameOver);
			add(playAgain);
			
			FlxG.mouse.show();
			
			add(Registry.hud);
			
			//in case if we had cameras do not scroll HUD!
			Registry.hud.setAll("scrollFactor",new FlxPoint(0,0));
			Registry.hud.setAll("cameras", [FlxG.camera]);
			
		}
		
		private function startGame():void
		{
			FlxG.mouse.hide();
			
			FlxG.switchState(new PlayState);
		}
		override public function destroy():void
		{
			FlxSpecialFX.clear();
			super.destroy();
			
		}
		
		override public function update():void
		{
			if (FlxG.keys.pressed("X"))
			{
				//startgame when X pressed.
				startGame();
				//flash white
				//FlxG.flash(0xffffff, 0.75);
				//fade out
				//FlxG.fade(0xff000000, 1,startGame);
				
			}
			super.update();	
		}
		
		
	}

}