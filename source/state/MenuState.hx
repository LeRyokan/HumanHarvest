package state;

import enums.Levels;
import flixel.FlxG;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;

/**
 * ...
 * @author ElRyoGrande
 */
class MenuState extends FlxState 
{

	
	
	override public function create():Void
	{
		super.create();
		
		bgColor = 0xFF000000;
		
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (FlxG.keys.anyJustPressed([FlxKey.BACKSPACE]))
		{
			
			FlxG.switchState(new PlayState(Levels.DAY_1));
		}
	}
	
	
	
	
	
}