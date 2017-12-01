package state;

import Human;
import Player;
import SpaceStation;
import enums.GameMode;
import enums.Levels;
import flixel.FlxState;
import enums.Levels;
import flixel.util.FlxSave;

class PlayState extends FlxState
{
	public var _currentLevel 		: Levels;
	public var _indexLevel 			: Int;
	public var _gameMode			: GameMode;
	public var _spaceStation		: SpaceStation;
	private var _saveLoaded 		: FlxSave;
	public var _saveName 			: String;

	public function new(gameMode:GameMode)
	{
		super();
		//_currentLevel = level;
		
		//TEST 
		_saveName = "SaveTEST";
		
		_saveLoaded = new FlxSave(); // initialize
		_saveLoaded.bind(_saveName); // bind to the named save slot
		
		switch (gameMode) 
		{
			case GameMode.NEW:
				_indexLevel = 1;
			case GameMode.LOAD:
				trace("CHARGEMENT DU NIVEAU " + _saveLoaded.data.level);
				_indexLevel = _saveLoaded.data.level + 1;
			case GameMode.NEXT_LEVEL:
				_indexLevel = _saveLoaded.data.level + 1;
			default:
				
		}
	}

	override public function create():Void
	{
		super.create();

		bgColor = 0xFFE5C992;

		_spaceStation = new SpaceStation(_indexLevel,_saveName); // PASSER LE LEVEL EN PARAMETRE
		add(_spaceStation);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}