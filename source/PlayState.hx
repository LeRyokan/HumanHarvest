package;

import flash.geom.Rectangle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import lime.ui.KeyCode;


import flixel.addons.nape.FlxNapeSprite;
import flixel.addons.nape.FlxNapeSpace;
import nape.callbacks.CbType;
import nape.callbacks.InteractionType;
import nape.callbacks.PreCallback;
import nape.callbacks.PreFlag;
import nape.callbacks.PreListener;
import nape.constraint.PivotJoint;
import nape.geom.Vec2;

class PlayState extends FlxState
{
	
	public var player:Player;
	public var human:Human;
	
	public var spaceStation:SpaceStation;
	
	override public function create():Void
	{
		
		super.create();
		
		FlxNapeSpace.init();
		
		FlxNapeSpace.createWalls(0,-300,FlxG.width, FlxG.height - 30);
		FlxNapeSpace.space.gravity.setxy(0, 400);
		
		bgColor = 0xFFE5C992;
		
		spaceStation = new SpaceStation();
		add(spaceStation);
		
		//RessourceBar
		var ressourceBar = new ResourceBar(new Rectangle(0, 0, 640, 80),spaceStation);
		add(ressourceBar);
		
		//button
		//var goButton = new TextButton(new Rectangle(300,200,48,36),"HELLO WORLD 2 !");
		//add(goButton);
		
		player = new Player();
		add(player);
		
		
		
		for (i in 1...6)
		{
			human = new Human(i * 50, 100, spaceStation);
			//ICI INCLURE LE PSEUDO PROCEDURAL
			human.init(5.5, 10, 45.0);
			player.registerPhysSprite(human);
			add(human);
			
		}
		
		
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		
		//DEBUG
		if (FlxG.keys.anyJustPressed([R]))
		{
			FlxG.resetState();
		}
	}
	
	
	
}
