package state;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxSave;

class TestGuillaumeState extends FlxState
{
	private var _gameSave					: FlxSave;

	override public function create():Void
	{
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.A)
		{
			loadSave();
		}
		if (FlxG.keys.justPressed.Z)
		{
			modifySave();
		}
		if (FlxG.keys.justPressed.E)
		{
			saveSave();
		}
		if (FlxG.keys.justPressed.Q)
		{
			trace(_gameSave);
		}
	}
	
	public function loadSave():Void
	{
		_gameSave = new FlxSave(); // initialize
		_gameSave.bind("SaveDemo"); // bind to the named save slot
	}
	
	public function modifySave():Void
	{
		_gameSave.data.time = Date.now();
	}
	
	public function saveSave():Void
	{
		_gameSave.flush();
	}
	
}