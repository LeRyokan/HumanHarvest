package;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxBitmapText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import nape.space.Space;
import openfl.geom.Rectangle;

/**
 * ...
 * @author ElRyoGrande
 */
class ResourceBar extends FlxSpriteGroup 
{
	public var backgroundSprite 	: FlxSprite;
	
	public var foodRessourceSprite 	: FlxSprite;
	public var milkRessourceSprite : FlxSprite;
	public var intelRessourceSprite : FlxSprite;
	
	public var foodText		:  FlxBitmapText;
	public var milkText		:  FlxBitmapText;
	public var intelText 	:  FlxBitmapText;
	
	public var foodCount : Float;
	public var iqCount : Int;
	public var milkCount : Float;
	
	
	var _spaceStation:SpaceStation;
	var timer: FlxTimer;
	
	
	public function new(rect:Rectangle, spaceStation:SpaceStation) 
	{
		super();
		
		_spaceStation = spaceStation;
		
		//logic section
		foodCount = _spaceStation.meat;
		iqCount = _spaceStation.iq;
		milkCount = _spaceStation.milk;
		
		//Sprite section
		backgroundSprite = new FlxSprite(0, 0);
		backgroundSprite.makeGraphic(640, 40, FlxColor.GRAY, false);
		
		foodRessourceSprite = new FlxSprite(20, 4);
		foodRessourceSprite.makeGraphic(32, 32, FlxColor.CYAN, false);	
		
		intelRessourceSprite = new FlxSprite(102, 4);
		intelRessourceSprite.makeGraphic(32, 32, FlxColor.MAGENTA, false);
		
		milkRessourceSprite = new FlxSprite(184, 4);
		milkRessourceSprite.makeGraphic(32, 32, FlxColor.LIME, false);
		
		add(backgroundSprite);
		add(foodRessourceSprite);
		add(milkRessourceSprite);
		add(intelRessourceSprite);

		
		//Text section
		foodText = new FlxBitmapText();
		foodText.text = Std.string(foodCount);
		foodText.x = foodRessourceSprite.x + foodRessourceSprite.width + 4;
		foodText.y = 20;
		
		milkText = new FlxBitmapText();
		milkText.text = Std.string(milkCount);
		milkText.x = milkRessourceSprite.x + milkRessourceSprite.width + 4;
		milkText.y = 20;
		
		intelText = new FlxBitmapText();
		intelText.text = Std.string(iqCount);
		intelText.x = intelRessourceSprite.x + intelRessourceSprite.width + 4;
		intelText.y = 20;
		
		add(foodText);
		add(milkText);
		add(intelText);
		
		//timer = new FlxTimer();
		//timer.start(2, AddRessources, 0);
		
	}
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (foodCount != _spaceStation.meat)
		{
			foodCount = _spaceStation.meat;
			foodText.text = Std.string(foodCount);
		}
	
		if (iqCount != _spaceStation.iq)
		{
			iqCount = _spaceStation.iq;
			intelText.text = Std.string(iqCount);
		}
		
		if (milkCount != _spaceStation.milk)
		{
			milkCount = _spaceStation.milk;
			milkText.text = Std.string(milkCount);
		}
		
	}
	
	private function AddRessources(timer:FlxTimer)
	{
		foodCount += 10;
		foodText.text =  Std.string(foodCount);
	}
	
}