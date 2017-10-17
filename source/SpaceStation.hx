package;

import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

/**
 * ...
 * @author ElRyoGrande
 */
class SpaceStation extends FlxSpriteGroup 
{
	//AREA
	public var slaughterhouse : Area;
	public var iqhouse : Area;
	public var milkhouse : Area;
	
	
	//LOGIC RESSOURCES ACTUELLEMENT AUSSI DANS PLAYER
	public var dollars 		: Int;
	public var milk 		: Float;
	public var meat	 		: Float;
	public var iq 	 		: Int;
	public var notoriety 	: Float;
	
	
	public function new() 
	{
		super();
		
		//ressource init
		meat = 0.0;
		milk = 0.0;
		iq = 0;
		
		
		slaughterhouse = new Area(50, 400, FlxColor.CYAN);
		add(slaughterhouse);
		
		iqhouse = new Area(250, 400, FlxColor.MAGENTA);
		add(iqhouse);
		
		milkhouse = new Area(450, 400, FlxColor.LIME);
		add(milkhouse);
	}
	
}