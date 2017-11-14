package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import ui.RessourceBar;
import flixel.text.FlxBitmapText;

/**
 * ...
 * @author ElRyoGrande
 */
class InfoScreen extends FlxSpriteGroup
{
	public static inline var OFFSET 	: Int = 10000;
	public static inline var SPACING 	: Int = 20;

	private var _spaceStation		: SpaceStation;

	public var _width 					: Int = Std.int(FlxG.width / 2);
	public var _height					: Int = FlxG.height - 150;

	public var backgroundSprite 		: FlxSprite;

	//private var ressourceBar 			: RessourceBar;
	private var title 					: FlxText;

	private var humanHeadSprite			: FlxSprite;
	private var humanBiography			: FlxText;

	private var foodRessourceSprite 	: FlxSprite;
	private var moneyRessoureSprite		: FlxSprite;
	private var intelRessourceSprite 	: FlxSprite;
	private var milkRessourceSprite 	: FlxSprite;

	private var foodCount 		: Float;
	private var moneyCount 		: Float;
	private var iqCount 		: Float;
	private var milkCount 		: Float;

	// TODO: pourquoi pas juste FlxText ?
	private var foodText		: FlxText;
	private var moneyText		: FlxText;
	private var intelText 		: FlxText;
	private var milkText		: FlxText;

	public function new(spaceStation:SpaceStation)
	{
		super();

		_spaceStation = spaceStation;

		// TODO: ça va bouger dans le new et update du spaceStation
		foodCount = _spaceStation.player._meat;
		moneyCount = _spaceStation.player._dollars;
		iqCount = _spaceStation.player._iq;
		milkCount = _spaceStation.player._blood;

		this.x = OFFSET;

		backgroundSprite = new FlxSprite(0, 0);
		backgroundSprite.makeGraphic(_width, _height, FlxColor.CYAN, false);

		//title = new FlxText(0 + _width / 2, SPACING, 0, "SCREEN INFO", 8, true);

		// RESSOURCES
		foodRessourceSprite = new FlxSprite(SPACING + SPACING, SPACING);
		foodRessourceSprite.makeGraphic(32, 32, FlxColor.RED, false);

		foodText = new FlxText(foodRessourceSprite.x + foodRessourceSprite.width + SPACING / 2, SPACING + 2);
		foodText.alignment = FlxTextAlign.LEFT;
		foodText.size = 20;
		foodText.fieldWidth = 96;
		foodText.text = Std.string(foodCount);
		//foodText.text = "300";
		//foodText.text = Std.string(fixedFloat(413.7657, 2));

		moneyRessoureSprite = new FlxSprite(foodText.x + foodText.width + SPACING, SPACING);
		moneyRessoureSprite.makeGraphic(32, 32, FlxColor.YELLOW, false);

		moneyText = new FlxText(moneyRessoureSprite.x + moneyRessoureSprite.width + SPACING / 2, SPACING + 2);
		moneyText.alignment = FlxTextAlign.LEFT;
		moneyText.size = 20;
		moneyText.fieldWidth = 96;
		moneyText.text = Std.string(moneyCount);
		//moneyText.text = "300";
		//moneyText.text = Std.string(fixedFloat(413.7657, 2));

		intelRessourceSprite = new FlxSprite(moneyText.x + moneyText.width + SPACING, SPACING);
		intelRessourceSprite.makeGraphic(32, 32, FlxColor.MAGENTA, false);

		intelText = new FlxText(intelRessourceSprite.x + intelRessourceSprite.width + SPACING / 2, SPACING + 2);
		intelText.alignment = FlxTextAlign.LEFT;
		intelText.size = 20;
		intelText.fieldWidth = 96;
		intelText.text = Std.string(iqCount);
		//intelText.text = "300";
		//intelText.text = Std.string(fixedFloat(413.7657, 2));

		milkRessourceSprite = new FlxSprite(intelText.x + intelText.width + SPACING, SPACING);
		milkRessourceSprite.makeGraphic(32, 32, FlxColor.LIME, false);

		milkText = new FlxText(milkRessourceSprite.x + milkRessourceSprite.width + SPACING / 2, SPACING + 2);
		milkText.alignment = FlxTextAlign.LEFT;
		milkText.size = 20;
		milkText.fieldWidth = 96;
		milkText.text = Std.string(milkCount);
		//milkText.text = "300";
		//milkText.text = Std.string(fixedFloat(413.7657, 2));

		// HUMAIN
		humanHeadSprite = new FlxSprite(SPACING, 70);
		humanHeadSprite.makeGraphic(205, 256, FlxColor.RED, false);

		var text:String = "Un jour, Lucas a décidé de faire des Jeux Vidéo.";
		text += "\n\nDepuis, il galère.";
		text += "\n\nEt il a décidé d'emmener Guillaume dans sa galère.";
		text += "\n\nDeux Galériens, c'est toujours mieux qu'un Galérien tout seul.";
		text += "\n\n\nCette chaîne de caractère raconte leurs aventures dans le monde cruel du Jeu Vidéo !";

		humanBiography = new FlxText(humanHeadSprite.x + humanHeadSprite.width + SPACING, humanHeadSprite.y + SPACING);
		humanBiography.size = 12;
		humanBiography.fieldWidth = _width - humanBiography.x - SPACING;
		humanBiography.alignment = FlxTextAlign.LEFT;
		humanBiography.wordWrap = true;
		humanBiography.text = text;

		add(backgroundSprite);

		add(foodRessourceSprite);
		add(foodText);

		add(moneyRessoureSprite);
		add(moneyText);

		add(intelRessourceSprite);
		add(intelText);

		add(milkRessourceSprite);
		add(milkText);

		add(humanHeadSprite);
		add(humanBiography);

		trace(humanHeadSprite.x);
		trace(humanBiography.x);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function updateText(text:String)
	{
		humanBiography.text = text;
	}
	
	public static function fixedFloat(v:Float, ?precision:Int = 2):Float
	{
		return Math.round( v * Math.pow(10, precision) ) / Math.pow(10, precision);
	}
}