package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;

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
	public var faceGroup :FlxSpriteGroup;
	public var face : FlxSprite;
	public var imgAdress : String;
	
	
	public function new() 
	{
		//Création de l'apparence
		
		//createFace();
		
		
		
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
	
	public function createFace()
	{
		faceGroup = new FlxSpriteGroup();
		
		
		var faceGeometry = new FlxSprite(0,0);
		var faceImg : String;
		
		var nose = new FlxSprite(0, 0);
		var noseImg : String;
		
		var mouth = new FlxSprite(0, 0);
		var mouthImg : String;
		
		var eyes = new FlxSprite(0, 0);
		var eyesImg : String;
		
		//FACULTATIF
		var eyebrow = new FlxSprite(0,0);
		
		
		
		//faceGeometry.loadGraphic(faceImg, false, 64, 48, true);
		//
		//nose.loadGraphic(noseImg, false, 64, 48, true);
		//
		//mouth.loadGraphic(mouthImg, false, 64, 48, true);
		//
		//eyes.loadGraphic(eyesImg, false, 64, 48, true);
		
		//eyebrow.loadGraphic(faceImg, false, 64, 48, true);
		
		
		faceGroup.add(faceGeometry);
		faceGroup.add(eyes);
		faceGroup.add(nose);
		faceGroup.add(mouth);
		
		
		
	}
	
}