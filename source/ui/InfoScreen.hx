package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxBitmapText;

class InfoScreen extends FlxSpriteGroup
{
	public static inline var OFFSET 	: Int = 10000;
	public static inline var SPACING 	: Int = 20;

	//COPIE DE LA STATIC INLINE QUI BIZARREMENT PEUT PAS ETRE ATTEINTE PAR LA CLASSE HUMAN
	public var _spacing : Int = 10020;
	
	public var _width 					: Int = Std.int(FlxG.width / 2);
	public var _height					: Int = FlxG.height - 150;

	public var _backgroundSprite 		: FlxSprite;

	private var _humanHeadSprite		: FlxSprite;
	private var _humanPortrait			:FlxSpriteGroup;
	private var _humanBiography			: FlxText;

	private var _foodRessourceSprite 	: FlxSprite;
	private var _moneyRessoureSprite	: FlxSprite;
	private var _iqRessourceSprite 		: FlxSprite;
	private var _bloodRessourceSprite 	: FlxSprite;

	private var _foodCount 				: Float;
	private var _moneyCount 			: Float;
	private var _iqCount 				: Float;
	private var _bloodCount 			: Float;

	private var _foodText				: FlxText;
	private var _moneyText				: FlxText;
	private var _iqText 				: FlxText;
	private var _bloodText				: FlxText;

	public function new()
	{
		super();

		this.x = OFFSET;

		_backgroundSprite = new FlxSprite(0, 0);
		_backgroundSprite.makeGraphic(_width, _height, FlxColor.CYAN, false);

		// RESSOURCES
		_foodRessourceSprite = new FlxSprite(SPACING + SPACING, SPACING);
		_foodRessourceSprite.makeGraphic(32, 32, FlxColor.RED, false);

		_foodText = new FlxText(_foodRessourceSprite.x + _foodRessourceSprite.width + SPACING / 2, SPACING + 2);
		_foodText.alignment = FlxTextAlign.LEFT;
		_foodText.size = 20;
		_foodText.fieldWidth = 96;

		_moneyRessoureSprite = new FlxSprite(_foodText.x + _foodText.width + SPACING, SPACING);
		_moneyRessoureSprite.makeGraphic(32, 32, FlxColor.YELLOW, false);

		_moneyText = new FlxText(_moneyRessoureSprite.x + _moneyRessoureSprite.width + SPACING / 2, SPACING + 2);
		_moneyText.alignment = FlxTextAlign.LEFT;
		_moneyText.size = 20;
		_moneyText.fieldWidth = 96;

		_iqRessourceSprite = new FlxSprite(_moneyText.x + _moneyText.width + SPACING, SPACING);
		_iqRessourceSprite.makeGraphic(32, 32, FlxColor.MAGENTA, false);

		_iqText = new FlxText(_iqRessourceSprite.x + _iqRessourceSprite.width + SPACING / 2, SPACING + 2);
		_iqText.alignment = FlxTextAlign.LEFT;
		_iqText.size = 20;
		_iqText.fieldWidth = 96;

		_bloodRessourceSprite = new FlxSprite(_iqText.x + _iqText.width + SPACING, SPACING);
		_bloodRessourceSprite.makeGraphic(32, 32, FlxColor.LIME, false);

		_bloodText = new FlxText(_bloodRessourceSprite.x + _bloodRessourceSprite.width + SPACING / 2, SPACING + 2);
		_bloodText.alignment = FlxTextAlign.LEFT;
		_bloodText.size = 20;
		_bloodText.fieldWidth = 96;

		// HUMAIN
		_humanHeadSprite = new FlxSprite(SPACING, 70);
		_humanHeadSprite.makeGraphic(205, 256, FlxColor.RED, false);
		
		_humanPortrait = new FlxSpriteGroup();
		_humanPortrait.add(_humanHeadSprite);
		//_humanPortrait.x = 700;
		//_humanPortrait.y = 200;
		
		
		

		var text:String = "Un jour, Lucas a décidé de faire des Jeux Vidéo.";
		text += "\n\nDepuis, il galère.";
		text += "\n\nEt il a décidé d'emmener Guillaume dans sa galère.";
		text += "\n\nDeux Galériens, c'est toujours mieux qu'un Galérien tout seul.";
		text += "\n\n\nCette chaîne de caractère raconte leurs aventures dans le monde cruel du Jeu Vidéo !";

		_humanBiography = new FlxText(_humanHeadSprite.x + _humanHeadSprite.width + SPACING, _humanHeadSprite.y + SPACING);
		_humanBiography.size = 12;
		_humanBiography.fieldWidth = _width - _humanBiography.x - SPACING;
		_humanBiography.alignment = FlxTextAlign.LEFT;
		_humanBiography.wordWrap = true;
		_humanBiography.text = text;

		// Ajout de tout à la fin sinon avec le x = 10000, ça merde le placement
		add(_backgroundSprite);

		add(_foodRessourceSprite);
		add(_foodText);

		add(_moneyRessoureSprite);
		add(_moneyText);

		add(_iqRessourceSprite);
		add(_iqText);

		add(_bloodRessourceSprite);
		add(_bloodText);

		//add(_humanHeadSprite);
		add(_humanPortrait);
		add(_humanBiography);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function updateText(text:String)
	{
		_humanBiography.text = text;
	}
	
	public function updatePortrait(portrait:FlxSprite)
	{
		_humanPortrait.clear();
		_humanPortrait.add(portrait);
	}
	
	
	public function updateResources(player:Player)
	{
		var foodCount:Float = player._food;
		var moneyCount:Float = player._money;
		var iqCount:Float = player._iq;
		var bloodCount:Float = player._blood;
		
		_foodText.text = Std.string(fixedFloat(foodCount, 2));
		_moneyText.text = Std.string(fixedFloat(moneyCount, 2));
		_iqText.text = Std.string(fixedFloat(iqCount, 2));
		_bloodText.text = Std.string(fixedFloat(bloodCount, 2));
	}
	
	// Fonction pompée sur internet pour pouvoir arrondir un chiffre avec le nombre de chiffres après la virgule qu'on veut
	public static function fixedFloat(v:Float, ?precision:Int = 2):Float
	{
		return Math.round( v * Math.pow(10, precision) ) / Math.pow(10, precision);
	}
}