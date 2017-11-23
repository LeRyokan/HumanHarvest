package state;

import enums.Levels;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;

/**
 * ...
 * @author ElRyoGrande
 */
class TestState extends FlxState 
{

	//TEST POUR LE FACE GENERATOR
	var generatedFace : FlxSpriteGroup;
	var imgPath : String = "assets/images/faces/";
	var faceGeometry : FlxSprite;
	var eyes : FlxSprite;
	var nose : FlxSprite;
	var skinColor : String;
	
	override public function create():Void
	{
		super.create();
		
		bgColor = 0xFF000000;
		
		generatedFace = new FlxSpriteGroup();
		
		add(generatedFace);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		//FACE GENERATOR
		if(FlxG.keys.anyJustPressed([FlxKey.G]))
		{
				createFace();
		}
		
		if(FlxG.keys.anyJustPressed([FlxKey.H]))
		{
			
				rollHead();
		}
		
		if(FlxG.keys.anyJustPressed([FlxKey.E]))
		{
				
				rollEyes();
		}
		
		if(FlxG.keys.anyJustPressed([FlxKey.N]))
		{	
				rollNose();
		}
		
	}
	
	
	public function createFace()
	{
		//generatedFace = new FlxSpriteGroup();
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
		var randEyes = FlxG.random.int(1, 2);
		var randNose = FlxG.random.int(1, 2);
		
		//TAILLE DES IMAGES
		//93,116
		
		
		 faceGeometry = new FlxSprite(0,0);
		var faceImg : String;
		faceGeometry.loadGraphic(imgPath +"visage_"+skinColor+randFace +".png", false, 205, 256, true);
		
		 nose = new FlxSprite(0, 0);
		var noseImg : String;
		nose.loadGraphic(imgPath +"bouche_"+skinColor+randFace +".png", false, 205, 256, true);
		//var mouth = new FlxSprite(0, 0);
		//var mouthImg : String;
		
		 eyes = new FlxSprite(0, 0);
		var eyesImg : String;
		eyes.loadGraphic(imgPath +"yeux_"+skinColor+randFace +".png", false, 205, 256, true);
		
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
		generatedFace.add(nose);
		//faceGroup.add(mouth);
		generatedFace.scale.set(3, 3);
		
		
	}
	
	public function rollHead()
	{
		var randNose = FlxG.random.int(1, 2);
		faceGeometry.loadGraphic(imgPath +"visage_"+skinColor+randNose +".png", false, 205, 256, true);
	}
	public function rollEyes()
	{
		var randNose = FlxG.random.int(1, 2);
		eyes.loadGraphic(imgPath +"yeux_"+skinColor+randNose +".png", false, 205, 256, true);
	}
	public function rollNose()
	{
		var randNose = FlxG.random.int(1, 2);
		nose.loadGraphic(imgPath +"bouche_"+skinColor+randNose +".png", false, 205, 256, true);
	}
	
	
}