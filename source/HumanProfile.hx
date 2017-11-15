package;
import flixel.FlxG;
import flixel.FlxSprite;
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
	
	
	
	public var _meat : Float;
	public var _iq : Int;
	public var _milk : Float;
	
	//APPARENCE 
	public var face : FlxSprite;
	public var imgAdress : String;
	
	
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
	
	
	function setRessources()
	{
		//MEAT ALGORITHM
		//_meat = 
	}
	
	
}