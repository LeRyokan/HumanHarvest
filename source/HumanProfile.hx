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

	//TEST POUR LE FACE GENERATOR
	public var _faceGroup 		:FlxSpriteGroup; // NON UTILISE
	public var _generatedFace	: FlxTypedSpriteGroup<FlxSprite>;
	public var _faceGeometry 	: FlxSprite;
	
	public var _faceImg : String;
	public var _eyesImg : String;
	public var _mouthImg : String;
	
	var _imgPath : String = "assets/images/faces/";
	var _eyes : FlxSprite;
	var _mouth : FlxSprite;
	var _skinColor : String;
	
	
	
	public function new() 
	{
		//Création de l'apparence
		
		createFace();
		
		
		
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
		_generatedFace = new FlxTypedSpriteGroup<FlxSprite>();
		_generatedFace.x = 430;
		_generatedFace.y = 400;
		
		if (FlxG.random.int(0, 1) == 0)
		{
			_skinColor = "blanc_";
		}
		else
		{
			_skinColor = "noir_";
		}
		
		_imgPath = "assets/images/faces/";
		
		var randFace = FlxG.random.int(1, 2);
		var randNose = FlxG.random.int(1, 2);
		var randEyes = FlxG.random.int(1, 2);
		
		
		
		//TAILLE DES IMAGES
		//93,116
		
		
		_faceGeometry = new FlxSprite(0,0);
		_faceImg = _imgPath +"visage_" + _skinColor + randFace +".png";
		_faceGeometry.loadGraphic(_faceImg, false, 205, 256, true);
		
		_mouth = new FlxSprite(0, 0);
		_mouthImg = _imgPath +"bouche_" + _skinColor + randNose +".png";
		_mouth.loadGraphic(_mouthImg, false, 205, 256, true);
		
		
		_eyes = new FlxSprite(0, 0);
		_eyesImg = _imgPath +"yeux_" + _skinColor + randEyes +".png";
		_eyes.loadGraphic(_eyesImg, false, 205, 256, true);
		
		//FACULTATIF
		//var eyebrow = new FlxSprite(0,0);

		
		
		_generatedFace.add(_faceGeometry);
		_generatedFace.add(_eyes);
		_generatedFace.add(_mouth);

		_generatedFace.scale.set(3, 3);
		
		
	}
	
}