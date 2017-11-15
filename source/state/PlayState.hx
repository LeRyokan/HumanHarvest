package state;

import Human;
import Player;
import SpaceStation;
import enums.Levels;
import flixel.FlxState;
import enums.Levels;

class PlayState extends FlxState
{
	public var _currentLevel 	: Levels;
	public var _spaceStation		: SpaceStation;

	public function new(level:Levels)
	{
		super();
		_currentLevel = level;
	}

	override public function create():Void
	{
		super.create();

		bgColor = 0xFFE5C992;

		_spaceStation = new SpaceStation(_currentLevel); // PASSER LE LEVEL EN PARAMETRE
		add(_spaceStation);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}