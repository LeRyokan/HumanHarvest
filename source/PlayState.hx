package;

import flash.geom.Rectangle;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	
	public var player:Player;
	public var human:Human;
	
	
	override public function create():Void
	{
		
		super.create();
		bgColor = 0xFFE5C992;
		
		
		//button
		var goButton = new TextButton(new Rectangle(300,200,48,36),"HELLO WORLD 2 !");
		add(goButton);
		
		
		player = new Player();
		
		
		
		//human = new Human(100, 100);
		//add(human.shadowSelect);
		//add(human);
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
