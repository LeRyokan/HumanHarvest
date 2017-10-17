package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import nape.phys.BodyType;

/**
 * ...
 * @author ElRyoGrande
 */
class Human extends FlxGroup 
{
	public var mainSprite:FlxNapeSprite;
	public var shadowSelect:FlxSprite;
	
	//CHARGER LA SPACESTATION
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super();
		
		mainSprite = new FlxNapeSprite(100, 100, "assets/images/human.png", false);
		mainSprite.createRectangularBody(16, 16, BodyType.DYNAMIC);
		mainSprite.setDrag(1, 0.96);
		mainSprite.setBodyMaterial(1, 0.2, 0.4, 1, 1000);
		add(mainSprite);
		
		
		//shadowSelect = mainSprite.clone();
		//shadowSelect.setPosition(mainSprite.x, mainSprite.y);
		//shadowSelect.color = FlxColor.BLACK;
		//shadowSelect.scale.set(1.4, 1.05);
		//shadowSelect.visible = false;
		
		//Setup mouse event
		FlxMouseEventManager.add(mainSprite, null, null, onMouseOver, onMouseOut); 
	}
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.overlap());
		
	}
	
	private function onMouseOver(_)
	{
		shadowSelect.visible = true;
	}
	
	private function onMouseOut(_)
	{
		shadowSelect.visible = false;
	}
	
	
}