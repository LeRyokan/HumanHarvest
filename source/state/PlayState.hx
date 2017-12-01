package state;

import Human;
import Player;
import SpaceStation;
import enums.Gamemode;
import enums.Levels;
import flixel.FlxState;
import enums.Levels;
import flixel.util.FlxSave;

class PlayState extends FlxState
{
	public var _currentLevel 		: Levels;
	public var _gameMode			: GameMode;
	public var _spaceStation		: SpaceStation;
	private var _saveLoaded 		: FlxSave;

	public function new(gameMode:GameMode)
	{
		super();
		//_currentLevel = level;
		switch (gameMode) 
		{
			case GameMode.NEW:
				_currentLevel = Levels.DAY_1;
			case GameMode.LOAD:
				_saveLoaded = new FlxSave(); // initialize
				_saveLoaded.bind("SaveTEST"); // bind to the named save slot
				_currentLevel = _saveLoaded.data.level;
			default:
				
		}
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