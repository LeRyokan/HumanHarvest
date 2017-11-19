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
	
	//TEST POUR LE FACE GENERATOR
	public var generatedFace2 : FlxSpriteGroup;
	public var generatedFace: FlxTypedSpriteGroup<FlxSprite>;
	var imgPath : String = "assets/images/faces/";
	public var faceGeometry : FlxSprite;
	public var faceImg : String;
	var eyes : FlxSprite;
	public var eyesImg : String;
	var mouth : FlxSprite;
	public var mouthImg : String;
	var skinColor : String;
	
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
		generatedFace = new FlxTypedSpriteGroup<FlxSprite>();
		generatedFace.x = 430;
		generatedFace.y = 400;
		
		if (FlxG.random.int(0, 1) == 0)
		{
			skinColor = "blanc_";
		}
		else
		{
			skinColor = "noir_";
		}
		
		imgPath = "assets/images/faces/";
		
		var randFace = FlxG.random.int(1, 2);
		var randNose = FlxG.random.int(1, 2);
		var randEyes = FlxG.random.int(1, 2);
		//TAILLE DES IMAGES
		//93,116
		
		
		faceGeometry = new FlxSprite(0,0);
		faceImg = imgPath +"visage_" + skinColor + randFace +".png";
		faceGeometry.loadGraphic(faceImg, false, 205, 256, true);
		
		mouth = new FlxSprite(0, 0);
		mouthImg = imgPath +"bouche_" + skinColor + randNose +".png";
		mouth.loadGraphic(mouthImg, false, 205, 256, true);
		
		
		eyes = new FlxSprite(0, 0);
		eyesImg = imgPath +"yeux_" + skinColor + randEyes +".png";
		eyes.loadGraphic(eyesImg, false, 205, 256, true);
		
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
		
		
		generatedFace.add(faceGeometry);
		generatedFace.add(eyes);
		generatedFace.add(mouth);
		//faceGroup.add(mouth);
		generatedFace.scale.set(3, 3);
		
		
	}
	
}