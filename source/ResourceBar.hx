package;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxBitmapText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.geom.Rectangle;

/**
 * ...
 * @author ElRyoGrande
 */
class ResourceBar extends FlxSpriteGroup 
{
	public var backgroundSprite 	: FlxSprite;
	
	public var foodRessourceSprite 	: FlxSprite;
	public var waterRessourceSprite : FlxSprite;
	public var intelRessourceSprite : FlxSprite;
	
	public var foodText		:  FlxBitmapText;
	public var waterText	:  FlxBitmapText;
	public var intelText 	:  FlxBitmapText;
	
	public var foodCount : Int;
	
	
	
	var timer: FlxTimer;
	
	
	public function new(rect:Rectangle) 
	{
		super();
		
		//logic section
		foodCount = 0;
		
		
		//Sprite section
		backgroundSprite = new FlxSprite(0, 0);
		backgroundSprite.makeGraphic(640, 40, FlxColor.GRAY, false);
		
		foodRessourceSprite = new FlxSprite(20, 4);
		foodRessourceSprite.makeGraphic(32, 32, FlxColor.CYAN, false);	
		
		waterRessourceSprite = new FlxSprite(102, 4);
		waterRessourceSprite.makeGraphic(32, 32, FlxColor.MAGENTA, false);
		
		intelRessourceSprite = new FlxSprite(184, 4);
		intelRessourceSprite.makeGraphic(32, 32, FlxColor.LIME, false);
		
		add(backgroundSprite);
		add(foodRessourceSprite);
		add(waterRessourceSprite);
		add(intelRessourceSprite);
		
		
		//Text section
		foodText = new FlxBitmapText();
		foodText.text = Std.string(foodCount);
		foodText.x = foodRessourceSprite.x + foodRessourceSprite.width + 4;
		foodText.y = 20;
		
		waterText = new FlxBitmapText();
		waterText.text = "0";
		waterText.x = waterRessourceSprite.x + waterRessourceSprite.width + 4;
		waterText.y = 20;
		
		intelText = new FlxBitmapText();
		intelText.text = "0";
		intelText.x = intelRessourceSprite.x + intelRessourceSprite.width + 4;
		intelText.y = 20;
		
		add(foodText);
		add(waterText);
		add(intelText);
		
		timer = new FlxTimer();
		timer.start(2, AddRessources, 0);
		
	}
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		
		
	}
	
	private function AddRessources(timer:FlxTimer)
	{
		foodCount += 10;
		foodText.text =  Std.string(foodCount);
	}
	
}