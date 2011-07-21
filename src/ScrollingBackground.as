package  
{
	
	import flash.geom.Rectangle;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FX.*;
	import org.flixel.plugin.photonstorm.*;


	public class ScrollingBackground extends FlxGroup
	{
		[Embed(source = '../assets/mapCSV_Group1_Map1.csv', mimeType = 'application/octet-stream')] private var map1CSV:Class;
		[Embed(source = '../assets/tiles.png')] private var tilesPNG:Class;
		
		private var map:FlxTilemap;
		private var dolly:FlxSprite;
		private var stars:FlxSprite;
		private var starfield:StarfieldFX;
		//private var camera:FlxCamera;
		
		public function ScrollingBackground() 
		{
			
			//stars as flixel 2.5 plugin !
			//starfield
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			starfield = FlxSpecialFX.starfield();
			starfield.setStarSpeed(0, 0.5);

			stars = starfield.create(0, 0, FlxG.width, FlxG.height, 256, 1, 10);
			stars.scrollFactor.x = 0;
			stars.scrollFactor.y = 0;
			//stars.angle = -90; //no need to rotate using speed above
		
			super();
			

			
			//	Our scrolling background map, created using DAME
			map = new FlxTilemap();
			map.loadMap(new map1CSV, tilesPNG, 16, 16);
			//this.cameras = [camera];
			
			map.scrollFactor.x = 0.5;
			map.scrollFactor.y = 1;
			
			//	This is an invisible sprite that our scrolling background tracks
			dolly = new FlxSprite(180,map.height);
			
			dolly.visible = false;
			
			
			
			//	Tell Flixels camera system to follow this sprite
			//	Call this AFTER setting the dolly coordinates to avoid the "camera panning to sprite" effect
			
			//FlxG.follow(dolly, 1);
			//flixel 2.5 change
			//FlxG.camera.setBounds(0, 0,480, 640,false);
			FlxG.camera.follow(dolly, FlxCamera.STYLE_TOPDOWN);
			//FlxScrollZone.add(dolly, new Rectangle(0, 0, dolly.width, dolly.height),0,10,true,false);
			
			add(stars);
			add(map);
			add(dolly);
						
		}
		
		override public function update():void
		{
			super.update();
			
			dolly.velocity.y = -100;
			
			//	Have we scrolled off the top of our map?
			if (dolly.y < -480)
			{
				//	Yes, so let's reset back to the start again (we unfollow first to stop camera jittering)

				//FlxG.unfollow();
				//flixel 2.5 change
				FlxG.camera.follow(null);
				dolly.y = map.height;
				//FlxG.follow(dolly, 1);
				//flixel 2.5 change
				FlxG.camera.follow(dolly, FlxCamera.STYLE_TOPDOWN);
				
			}
		}
		
		override public function kill():void
		{	
			FlxSpecialFX.clear();
			//need to stop camera else will trap when changing state!
			FlxG.camera.stopFX();
			}
		
		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			FlxSpecialFX.clear();
			FlxG.camera.follow(null);
			//FlxG.camera.scroll.x = 0;
			//FlxG.camera.scroll.y = 0;
			
			super.destroy();
		}
	}

}