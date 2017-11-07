package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import flixel.input.mouse.FlxMouseEventManager;
import nape.constraint.DistanceJoint;
import nape.geom.Vec2;
import nape.space.Space;

import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;


/**
 * ...
 * @author ElRyoGrande
 */
class Player extends FlxBasic
{

	public var dollars 		: Int;
	public var blood 		: Float;
	public var meat	 		: Float;
	public var IQ 	 		: Int;
	public var notoriety 	: Float;
	
	
	var mouseJoint:DistanceJoint;
	public var currentSpriteGrab:Human;
	var currentHumanWithInfoDisplay:Human;
	var _spaceStation:SpaceStation;
	
	public function new(spaceStation:SpaceStation)
	{
		super();
		initCursor();
		
		_spaceStation = spaceStation;
		
		dollars = Tweaking.playerMoney;
		blood = 0;
		meat = 0;
		IQ = 0;
		notoriety = 0;
	}
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if(currentHumanWithInfoDisplay!=null && !currentHumanWithInfoDisplay.alive)
		{
				cleanScreenInfo();
		}
		
		if (mouseJoint != null) 
		{
			mouseJoint.anchor1 = new Vec2(FlxG.mouse.x, FlxG.mouse.y);
			
			// TODO: idéalement, foutre dans le onMouseUp
			if (FlxG.mouse.justReleased)
			{
				mouseJoint.space = null;
				if (currentSpriteGrab != null)
				{
					currentSpriteGrab.isGrab = false;
					currentSpriteGrab.posOnTable.x = FlxG.mouse.x;
					currentSpriteGrab = null;
					trace("SPRITE RELACHE");
				}
			}
			//
		}
	}
	
	public function initCursor():Void
	{
		// Create a white circle to use as a cursor graphic
		var sprite = new FlxSprite();
		sprite.makeGraphic(15, 15, FlxColor.TRANSPARENT);
		sprite.drawCircle(-1, -1, -1, FlxColor.fromRGB(255, 255, 255, 125));

		// Load the sprite's graphic to the cursor
		FlxG.mouse.load(sprite.pixels);
	}
	
	public inline function registerPhysSprite(human:Human)
	{
		// Le false de fin c'est pour pas se baser sur le sprite mais plutôt sur la hitbox
		FlxMouseEventManager.add(human, createMouseJoint, humanReleased, getInfoAboutThis, onMouseOut, false, true, false);
	}
	
	// onMouseDown
	function createMouseJoint(human:Human) 
	{
		currentSpriteGrab = human;
		currentSpriteGrab.isGrab = true;
		
		mouseJoint = new DistanceJoint(	FlxNapeSpace.space.world, 
										human.body, 
										new Vec2(FlxG.mouse.x, FlxG.mouse.y), 
										human.body.worldPointToLocal(new Vec2(FlxG.mouse.x, FlxG.mouse.y)),
										0, 
										0);
		mouseJoint.space = FlxNapeSpace.space;
	}
	
	// onMouseUp
	// TODO: fonctionne pas pour le moment
	function humanReleased(human:Human) 
	{
		// mouseJoint.space = null;
		// human.isGrab = false;
		// human.posOnTable.x = FlxG.mouse.x;
		// human = null;
		// trace("SPRITE RELACHE");
	}
	
	// onMouseOver
	function getInfoAboutThis(human:Human)
	{
		//trace("in");
		_spaceStation.sendTextToInfoScreen(human.basicInfo);
		currentHumanWithInfoDisplay = human;
	}
	
	// onMouseOut
	function onMouseOut(human:Human) 
	{
		//trace("out");
	}
	
	function cleanScreenInfo()
	{
		_spaceStation.sendTextToInfoScreen(" ");
	}

}