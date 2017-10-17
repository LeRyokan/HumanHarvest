package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ElRyoGrande
 */
class Area extends FlxSprite 
{
	
	//var humanCount:Int;

	public function new(?X:Float=0, ?Y:Float=0, color:FlxColor) 
	{
		super(X, Y);
		makeGraphic(64, 48, color, false);
		
		
	}
	
}