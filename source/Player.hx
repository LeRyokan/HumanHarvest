package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;

import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author ElRyoGrande
 */
class Player extends FlxBasic
{

	public var dollars 		: Int;
	public var blood 		: Float;
	public var meat	 		: Float;
	public var IQ 	 		: Int;
	public var notoriety 	: Float;
	
	
	public function new()
	{
		super();
		initCursor();
		
		dollars = Tweaking.playerMoney;
		blood = 0;
		meat = 0;
		IQ = 0;
		notoriety = 0;
		

	}

	public function initCursor():Void
	{
		// Create a white circle to use as a cursor graphic
		var sprite = new FlxSprite();
		sprite.makeGraphic(15, 15, FlxColor.TRANSPARENT);
		sprite.drawCircle();

		// Load the sprite's graphic to the cursor
		FlxG.mouse.load(sprite.pixels);

	}

}