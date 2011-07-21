/**
 * Return Fire - Shoot-em-up Tutorial Part 3
 * @author Richard Davey
 */

package  
{
	import org.flixel.FlxGame;
	[SWF(width="640", height="480", backgroundColor="#000000")]

	[Frame(factoryClass = "Preloader")]
	
	
	public class ReturnFire extends FlxGame
	{
		
		public function ReturnFire() 
		{
			super(320, 240, MenuState, 2,60,60);
			forceDebugger = true;
		}
		
	}

}