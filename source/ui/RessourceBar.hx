package ui;
import SpaceStation;
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
class RessourceBar extends FlxSpriteGroup 
{
	private var _spaceStation		: SpaceStation;
	
	private var backgroundSprite 	: FlxSprite;
	
	private var _timer				: FlxTimer;
	
	private var moneyRessoureSprite		: FlxSprite;
	private var foodRessourceSprite 	: FlxSprite;
	private var milkRessourceSprite 	: FlxSprite;
	private var intelRessourceSprite 	: FlxSprite;
	
	private var moneyText		: FlxBitmapText;
	private var foodText		: FlxBitmapText;
	private var milkText		: FlxBitmapText;
	private var intelText 		: FlxBitmapText;
	
	private var moneyCount 		: Float;
	private var foodCount 		: Float;
	private var iqCount 		: Float;
	private var milkCount 		: Float;
	
	public function new(rect:Rectangle, spaceStation:SpaceStation) 
	{
		super();
		
		_spaceStation = spaceStation;
		
		//logic section
		moneyCount = _spaceStation.player._dollars;
		foodCount = _spaceStation.player._meat;
		iqCount = _spaceStation.player._iq;
		milkCount = _spaceStation.player._blood;
		
		//Sprite section
		backgroundSprite = new FlxSprite(rect.x, rect.y);
		backgroundSprite.makeGraphic(Std.int(rect.width), Std.int(rect.height), FlxColor.GRAY, false);
		
		foodRessourceSprite = new FlxSprite(rect.x +10, rect.y);
		foodRessourceSprite.makeGraphic(32, 32, FlxColor.CYAN, false);	
		
		intelRessourceSprite = new FlxSprite(rect.x + 55 , rect.y);
		intelRessourceSprite.makeGraphic(32, 32, FlxColor.MAGENTA, false);
		
		milkRessourceSprite = new FlxSprite(rect.x+ 100, rect.y);
		milkRessourceSprite.makeGraphic(32, 32, FlxColor.LIME, false);
		
		moneyRessoureSprite = new FlxSprite(rect.x+ 200, rect.y);
		moneyRessoureSprite.makeGraphic(32, 32, FlxColor.YELLOW, false);

		
		add(backgroundSprite);
		add(foodRessourceSprite);
		add(milkRessourceSprite);
		add(intelRessourceSprite);
		add(moneyRessoureSprite);
		
		

		
		//Text section
		foodText = new FlxBitmapText();
		foodText.text = Std.string(foodCount);
		foodText.x = foodRessourceSprite.x + foodRessourceSprite.width + 4;
		foodText.y = foodRessourceSprite.y + 10;
		
		milkText = new FlxBitmapText();
		milkText.text = Std.string(milkCount);
		milkText.x = milkRessourceSprite.x + milkRessourceSprite.width + 4;
		milkText.y = foodRessourceSprite.y + 10 ;
		
		intelText = new FlxBitmapText();
		intelText.text = Std.string(iqCount);
		intelText.x = intelRessourceSprite.x + intelRessourceSprite.width + 4;
		intelText.y = foodRessourceSprite.y + 10 ;
		
		moneyText = new FlxBitmapText();
		moneyText.text = Std.string(moneyCount);
		moneyText.x = moneyRessoureSprite.x + moneyRessoureSprite.width + 4;
		moneyText.y = moneyRessoureSprite.y + 10 ;
		
		add(foodText);
		add(milkText);
		add(intelText);
		add(moneyText);
		//timer = new FlxTimer();
		//timer.start(2, AddRessources, 0);
		
	}
	
	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (foodCount != _spaceStation.player._meat)
		{
			foodCount = _spaceStation.player._meat;
			foodText.text = Std.string(foodCount);
		}
	
		if (iqCount != _spaceStation.player._iq)
		{
			iqCount = _spaceStation.player._iq;
			intelText.text = Std.string(iqCount);
		}
		
		if (milkCount != _spaceStation.player._blood)
		{
			milkCount = _spaceStation.player._blood;
			milkText.text = Std.string(milkCount);
		}
		
	}
	
	private function AddRessources(timer:FlxTimer)
	{
		foodCount += 10;
		foodText.text =  Std.string(foodCount);
	}
	
}