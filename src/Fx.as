package  
{
	import org.flixel.*;

	public class Fx extends FlxGroup
	{
		private var pixels:FlxGroup;
		private var jet:FlxEmitter;
		
		public function Fx() 
		{
			super();
			
			this.cameras 
			pixels = new FlxGroup(20);
			
			//	Here we create an FlxGroup containing 40 FlxEmitters, all the same, used when the aliens are shot/explode
			for (var i:int = 0; i < 20; i++)
			{
				
				var tempPixel:FlxEmitter = new FlxEmitter();
				tempPixel.setSize(8, 8);
				tempPixel.gravity = 200;
				tempPixel.setXSpeed(-50, 50);
				tempPixel.setYSpeed( -30, -60);
				tempPixel.setRotation(0, 0);	// VITAL!!!);
				//tempPixel.exists = false;
				//tempPixel.setMotion(0, 5, 0.2, 360, 200, 1.8);
				tempPixel.makeParticles(Pixel, 10, 10, true, 1);
				//tempPixel.exists = false;
				tempPixel.maxSize = 10;
				//tempPixel.alive = false;
				//tempPixel.lifespan = 0;
				//tempPixel.maxSize = 10;

			/*	
				var tempPixel = new FlxParticle();
					//particle.makeGraphic(1, 1, 0xFF597137);
					tempPixel.makeGraphic(8, 8, 0xFFf2440e); //(Pixel);
					tempPixel.setXSpeed( -50, 50);
					tempPixel.setYSpeed( -30, -60);
					tempPixel.setRotation(0, 0);
					tempPixel.gravity = 200;
				*/	
				
				pixels.add(tempPixel);
				//emitter = new FlxEmitter(0, 0, 0, 0, null, -1.5, -100, 100, -100, 100, 0, 0, 200, 100, ParticleImage, 100, true, particleLayer);
			

			}
			
			//	Jet thrusters for trailing behind the ship
			jet = new FlxEmitter();
			jet.setSize(8, 8);
			//jet.angularVelocity = 0;
			jet.gravity = 300;
			jet.setXSpeed(-30, 30);
			jet.setYSpeed(80, 120);
			jet.setRotation(0, 0);	// VITAL!!!
			jet.makeParticles(Jets, 80, 0, true, 0);
			//jet.delay = 0.01;
			jet.start(false);
			add(pixels);
			add(jet);
		}
		
		override public function update():void
		{
			super.update();
			
			//	We can't use jet.at(Registry.player) because we need to offset the x/y a little to make
			//	it look like the jets are coming from the bottom middle of the ship
			jet.x = Registry.player.x + 4;
			jet.y = Registry.player.y + 12;
			
		}
		
		public function explodeBlock(ax:int, ay:int):void
		{
			//var pixel:FlxEmitter = FlxEmitter(pixels.getFirstAvailable());
			//using recycle to get first available flxemitter members are never tagged
			//exists= false so getFirstAvailable seems useless
			var pixel:FlxEmitter=  pixels.recycle(FlxEmitter) as FlxEmitter;  
			
			/* //if wanna use getFirstAvailable, should tag exists false in first null
			 * //object return, null object will return if maxsize reached.
			 * var pixel:FlxEmitter = FlxEmitter(pixels.getFirstAvailable());
			if (pixel == null)
			{	pixels.setAll("exists", false, false);
				pixels.setAll("alive", false, false);
				pixel  = FlxEmitter(pixels.getFirstAvailable());
				
			}
			*/
			if (pixel)
			{
				pixel.x = ax;
				pixel.y = ay;
				//pixel.start(true);
				//using 2 secs for particle lifespan 
				//frequency has no effect for explosion
				pixel.start(true, 2, 0, 0); 
			}
					
			
			
		}
		
	}

}