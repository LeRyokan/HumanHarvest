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
					currentSpriteGrab.posOnTable.x = FlxG.mouse.x; //a déplacer je pense
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
		sprite.drawCircle();

		// Load the sprite's graphic to the cursor
		FlxG.mouse.load(sprite.pixels);

	}
	
	public inline function registerPhysSprite(human:Human)
	{
		FlxMouseEventManager.add(human, createMouseJoint, humanReleased, getInfoAboutThis, onMouseOut);
	}
	
	// onMouseDown
	function createMouseJoint(spr:Human) 
	{
		currentSpriteGrab = spr;
		currentSpriteGrab.isGrab = true;
		
		mouseJoint = new DistanceJoint(FlxNapeSpace.space.world, spr.body, new Vec2(FlxG.mouse.x, FlxG.mouse.y),
		spr.body.worldPointToLocal(new Vec2(FlxG.mouse.x, FlxG.mouse.y)), 0, 0);
		
		mouseJoint.space = FlxNapeSpace.space;
	}
	
	// onMouseUp
	// TODO: fonctionne pas pour le moment
	function humanReleased(spr:Human) 
	{
		// mouseJoint.space = null;
		// spr.isGrab = false;
		// spr.posOnTable.x = FlxG.mouse.x;
		// spr = null;
		// trace("SPRITE RELACHE");
	}
	
	// onMouseOver
	function getInfoAboutThis(human:Human)
	{
		_spaceStation.sendTextToInfoScreen(human.basicInfo);
		currentHumanWithInfoDisplay = human;
	}
	
	// onMouseOut
	function onMouseOut(human:Human) 
	{
		// trace(human);
	}
	
	function cleanScreenInfo()
	{
		_spaceStation.sendTextToInfoScreen(" ");
	}

}