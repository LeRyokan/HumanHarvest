package;

import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ElRyoGrande
 */
class Human extends FlxSprite 
{
	public var mainSprite:FlxSprite;
	public var shadowSelect:FlxSprite;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		mainSprite = this.loadGraphic("assets/images/human.png", false, 16, 32, false);
		
		
		shadowSelect = mainSprite.clone();
		shadowSelect.setPosition(mainSprite.x, mainSprite.y);
		shadowSelect.color = FlxColor.BLACK;
		shadowSelect.scale.set(1.4, 1.05);
		shadowSelect.visible = false;
		
		//Setup mouse event
		FlxMouseEventManager.add(mainSprite, null, null, onMouseOver, onMouseOut); 
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