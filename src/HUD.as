package  
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	

	public class HUD extends FlxGroup
	{
		[Embed(source = '../assets/digits_font_ilkke.png')] private var digitsPNG:Class;
		[Embed(source = '../assets/hud.png')] private var panelPNG:Class;

		private var panel:FlxSprite;
		private var healthBar:FlxBar;
		private var score:FlxBitmapFont;
		private var lives:FlxBitmapFont;
		
		public var liveUpdate:Boolean;

		public function HUD() 
		{
			super();
			
			//flixel 2.5 change
			//scrollfactor is set using setAll in Playstate
			//scrollFactor.x = 0;
			//scrollFactor.y = 0;
						
			panel = new FlxSprite(0, 0, panelPNG);
			
			FlxDisplay.screenCenter(panel, true);
			
			score = new FlxBitmapFont(digitsPNG, 7, 6, "0123456789", 10, 1);
			score.setText("", false, 1, 0, FlxBitmapFont.ALIGN_CENTER);
			score.x = panel.x + 11;
			score.y = 12;
			
			lives = new FlxBitmapFont(digitsPNG, 7, 6, "0123456789", 10, 1);
			lives.setText(Registry.player.lives.toString(), false);
			lives.x = panel.x + 119;
			lives.y = 12;
			
			//	We create a Health Bar - if you look carefully at the colours, what we make is a totally black bar that acts as a "mask" over the hud image
			healthBar = new FlxBar(59, 6,1, 100, 10, Registry.player, "health", 0,Registry.player.health,false);
			healthBar.createFilledBar(0xff000000, 0x00000000);
			healthBar.x = panel.x + 158;
			healthBar.y = 12;
			
			setAll("scrollFactor.x", 0, true);
			setAll("scrollFactor.y",0,true)
			
			liveUpdate = true;
			add(panel);
			add(score);
			add(lives);
			add(healthBar);
			
		}
		
		override public function update():void
		{
			super.update();
			
			//	We set liveUpdate to "false" when we switch to the Game Over state, so it no longer polls objects that have been nulled
			if (liveUpdate)
			{
				score.text = FlxG.score.toString();
				lives.text = Registry.player.lives.toString();
				
			}
		}
		
		override public function destroy():void
		{
			trace("HUD nuked");
		}
		
	}

}