package;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import flixel.input.mouse.FlxMouseEventManager;
import nape.constraint.DistanceJoint;
import nape.geom.Vec2;

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
	
	public function new()
	{
		super();
		initCursor();
		
		dollars = Tweaking.playerMoney;
		blood = 0;
		meat = 0;
		IQ = 0;
		notoriety = 0;
			

	}
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (mouseJoint != null) 
		{
			mouseJoint.anchor1 = new Vec2(FlxG.mouse.x, FlxG.mouse.y);
			
			if (FlxG.mouse.justReleased)
			{
				mouseJoint.space = null;
				trace("SOURIS RELACHE");
			}
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
	
	public inline function registerPhysSprite(spr:FlxNapeSprite)
	{
		FlxMouseEventManager.add(spr, createMouseJoint);
	}
	
	function createMouseJoint(spr:FlxNapeSprite) 
	{
		mouseJoint = new DistanceJoint(FlxNapeSpace.space.world, spr.body, new Vec2(FlxG.mouse.x, FlxG.mouse.y),
			spr.body.worldPointToLocal(new Vec2(FlxG.mouse.x, FlxG.mouse.y)), 0, 0);
		
		mouseJoint.space = FlxNapeSpace.space;
	}	
	

}