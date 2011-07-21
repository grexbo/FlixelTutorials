package  
{
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.*;

	public class MenuState extends FlxState
	{
		private var playGame:FlxButtonPlus;
		
		public function MenuState() 
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			playGame = new FlxButtonPlus(0, 180, startGame, null, "Play Game");
			playGame.screenCenter();
			
			add(playGame);
			
			FlxG.mouse.show();
		}
		
		private function startGame():void
		{
			FlxG.mouse.hide();
			
			FlxG.switchState(new PlayState);
		}
		
		override public function update():void
		{
			if (FlxG.keys.pressed("X"))
			{
				//flash white
				FlxG.flash(0xffffff, 0.75);
				//fade out
				FlxG.fade(0xff000000, 1,startGame);
				
			}
			super.update();	
		}
		
		
	}

}