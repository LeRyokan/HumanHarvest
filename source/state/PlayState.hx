package state;

import Human;
import Player;
import SpaceStation;
import flash.geom.Rectangle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;
import lime.ui.KeyCode;
import ui.InfoScreen;


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
	public var infoScreen : ui.InfoScreen;
	
	override public function create():Void
	{
		
		super.create();
		
		bgColor = 0xFFE5C992;
		
		spaceStation = new SpaceStation(); // PASSER LE LEVEL EN PARAMETRE
		add(spaceStation);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		//if (spaceStation.isDayFinish)
		//{
			//FlxG.switchState(new DebriefState());
		//}
		
		//DEBUG
		if (FlxG.keys.pressed.SHIFT)
		{
			if (FlxG.keys.anyJustPressed([R]))
			{
				FlxG.resetState();
			}
		}
	}
}
