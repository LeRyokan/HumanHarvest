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
	
	
	override public function create():Void
	{
		
		super.create();
		
		FlxNapeSpace.init();
		
		FlxNapeSpace.createWalls(0,-300,FlxG.width, FlxG.height - 30);
		FlxNapeSpace.space.gravity.setxy(0, 400);
		
		bgColor = 0xFFE5C992;
		
		//RessourceBar
		var ressourceBar = new ResourceBar(new Rectangle(0, 0, 640, 80));
		add(ressourceBar);
		
		//button
		var goButton = new TextButton(new Rectangle(300,200,48,36),"HELLO WORLD 2 !");
		add(goButton);
		
		
		player = new Player();
		add(player);
		
		var area = new Area(100,300);
		add(area);
		
		human = new Human(100, 100);
		player.registerPhysSprite(human.mainSprite);
		//add(human.shadowSelect);
		add(human);
		
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
