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

	public function new()
	{
		super();
		initCursor();

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