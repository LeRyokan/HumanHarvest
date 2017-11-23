package state;

import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxPoint;
import state.TestGuillaumeState.User;
import sys.db.Types;
import flixel.util.FlxSave;
import haxe.crypto.Base64;

class TestGuillaumeState extends FlxState
{
	private var _cnx						: sys.db.Connection;
	private var _gameSave					: FlxSave;

	override public function create():Void
	{
		super.create();

		// Open a connection
		_cnx = sys.db.Sqlite.open("test.db");

		// Set as the connection for our SPOD manager
		sys.db.Manager.cnx = _cnx;
		sys.db.Manager.initialize();

		//cnx.close();
	}

	public function createTables():Void
	{
		if (!sys.db.TableCreate.exists(User.manager))
		{
			sys.db.TableCreate.create(User.manager);
		}
	}

	public function insertNewUser():Void
	{
		var user1 = new User();
		user1.name = "lol";
		user1.value = 2;
		user1.otherValue = 1.4;
		user1.dateTime = Date.now();

		user1.insert();

		//trace(user1.name);

		user1.name = "ah non";
		user1.update();

		//trace(user1.name);
	}

	public function searchAll():Void
	{
		for (user in User.manager.search($id > 0))
		{
			trace(user.toString());
		}
	}

	public function clearAll():Void
	{
		User.manager.delete($id > 0);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		//if (FlxG.keys.justPressed.C)
		//{
			//createTables();
		//}
		//if (FlxG.keys.justPressed.I)
		//{
			//insertNewUser();
		//}
		//if (FlxG.keys.justPressed.S)
		//{
			//searchAll();
		//}
		//if (FlxG.keys.justPressed.D)
		//{
			//clearAll();
		//}
		//if (FlxG.keys.justPressed.BACKSPACE)
		//{
			//// Close the connection
			//_cnx.close();
		//}
		
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

class User extends sys.db.Object
{
	public static var manager = new sys.db.Manager<User>(User);

	public var id : SId;
	public var name : SString<32>;
	public var value : SNull<SInt>;
	public var otherValue : SNull<SFloat>;
	public var dateTime : SDateTime;

	override public function toString():String
	{
		return 'User [$id] : name = [$name], value = [$value], otherValue = [$otherValue], dateTime = [$dateTime]';
	}
}