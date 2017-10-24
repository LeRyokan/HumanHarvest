package;
import flixel.FlxG;
import flixel.group.FlxGroup;

/**
 * ...
 * @author ElRyoGrande
 */
class HumanProfile 
{

	public var isSick : Bool;
	
	//On transformera en enum je pense
	var existingBacterias : Array<String>;
	var bacterias : Array<String>;
	
	
	
	public function new() 
	{
		//Determine from a percentage if the human is sick
		var sickChance = 70.0; //Value evolue en fonction du LVL
		var luckyNumber = FlxG.random.float(0, 100.0);
		
		if (luckyNumber <= sickChance)
		{
			//trace("MALADE");
			isSick = true;
		}
		else
		{
			//trace("SAIN");
			isSick = false;
		}
		
		
		
		
	}
	
}