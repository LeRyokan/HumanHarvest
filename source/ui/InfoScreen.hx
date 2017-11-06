package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author ElRyoGrande
 */
class InfoScreen extends FlxSpriteGroup 
{
	var ressourceBar : ui.RessourceBar;
	var screenSprite : FlxSprite;
	var textOnScreen : FlxText;
	
	public function new() 
	{
		super();
		screenSprite = new FlxSprite(860, 500);
		screenSprite.makeGraphic(360, 240, FlxColor.CYAN, false);
		add(screenSprite);
		
		textOnScreen = new FlxText(screenSprite.x + 5, screenSprite.y + 10,0, "SCREEN INFO", 8, true);
		add(textOnScreen);
		
		
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		
	}
	
	public function updateText(text:String)
	{
		textOnScreen.text = text;
	}
}