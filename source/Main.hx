package;

import flixel.FlxGame;
import openfl.display.Sprite;
import state.PlayState;

class Main extends Sprite
{
	public function new()
	{
		super();
		//addChild(new FlxGame(0, 0, PlayState, 1, 60, 60, true, false));
		//addChild(new FlxGame(0, 0, PlayState));
		
		addChild(new GameSession());
	}
}
