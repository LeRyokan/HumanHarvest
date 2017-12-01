package ui;

import enums.Levels;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText.FlxTextAlign;
import flixel.util.FlxColor;
import openfl.geom.Rectangle;
import state.PlayState;
/**
 * ...
 * @author ElRyoGrande
 */

class TextButton extends FlxSpriteGroup 
{
	var imgButton : FlxSprite;
	var textField : FlxBitmapText;
	var _idToNextLVL : Int;
	var nextState : PlayState;
	
	 
	public function new(rect:Rectangle, text:String, id:Int) 
	{
		super();
		
		imgButton = new FlxSprite(0, 0);
		imgButton.loadGraphic("assets/images/popup.png",false,Std.int(rect.width),Std.int(rect.height),false);
		add(imgButton);
		
		textField = new FlxBitmapText();
		textField.autoSize = false;
		textField.wordWrap = true;
		textField.multiLine = true;
		textField.alignment = FlxTextAlign.CENTER;
		textField.color = FlxColor.BROWN;
		textField.text = text; 
		textField.fieldWidth = Std.int(rect.width) - 10;
		textField.x = (rect.width - textField.width) / 2 ;
		add(textField);
	
		//Doit etre fait après le add pour pouvoir récuperer la valeure de numLines
		textField.y = (rect.height - ((textField.lineHeight * textField.numLines) + ((textField.numLines - 1) * textField.lineSpacing))) / 2;
	    
		
		x = rect.x;
		y = rect.y;
		
		_idToNextLVL = id;
		
		//switch (_idToNextLVL) 
		//{
			//case 1:
				//nextState = new PlayState(Levels.DAY_1);
			//case 2:
				//nextState = new PlayState(Levels.DAY_2);
			//case 3:
				//nextState = new PlayState(Levels.DAY_3);
			//case 4:
				//nextState = new PlayState(Levels.DAY_4);
			//default:
				//
		//}
		
		
		//Setup mouse event
		FlxMouseEventManager.add(imgButton, onMouseDown, null, onMouseOver, onMouseOut); 
		
		
		
		
	}
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
	
	private function onMouseOver(_)
	{
		textField.color = FlxColor.RED;
	}
	
	private function onMouseOut(_)
	{
		textField.color = FlxColor.BROWN;
	}
	
	private function onMouseDown(_)
	{
		
		trace("Button clicked");
		FlxG.switchState(nextState);
	}
	
}