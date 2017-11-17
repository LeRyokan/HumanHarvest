package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.addons.text.FlxTypeText;

class InfoScreen extends FlxSpriteGroup
{
	public static inline var OFFSET 			: Int = 10000;
	public static inline var SPACING 			: Int = 20;
	//COPIE DE LA STATIC INLINE QUI BIZARREMENT PEUT PAS ETRE ATTEINTE PAR LA CLASSE HUMAN
	public var _spacing : Int = 10020;
	
	public var _width 					: Int = Std.int(FlxG.width / 2);
	public var _height					: Int = FlxG.height - 150;


	public var _backgroundSprite 				: FlxSprite;


	private var _humanPortrait			:FlxSpriteGroup;

	// Ressources
	private var _foodRessourceSprite 			: FlxSprite;
	private var _moneyRessoureSprite			: FlxSprite;
	private var _iqRessourceSprite 				: FlxSprite;
	private var _bloodRessourceSprite 			: FlxSprite;


	private var _foodText						: FlxText;
	private var _moneyText						: FlxText;
	private var _iqText 						: FlxText;
	private var _bloodText						: FlxText;
	
	// Humain
	private var _humanHeadSprite				: FlxSprite;
	private var _humanName						: FlxText;
	private var _humanBiography					: FlxTypeText;
	
	private var _humanFoodRessourceSprite 		: FlxSprite;
	private var _humanMoneyRessoureSprite		: FlxSprite;
	private var _humanIqRessourceSprite 		: FlxSprite;
	private var _humanBloodRessourceSprite 		: FlxSprite;
	
	private var _humanFoodText					: FlxText;
	private var _humanMoneyText					: FlxText;
	private var _humanIqText 					: FlxText;
	private var _humanBloodText					: FlxText;

	public function new()
	{
		super();

		this.x = OFFSET;

		_backgroundSprite = new FlxSprite(0, 0);
		_backgroundSprite.makeGraphic(_width, _height, FlxColor.BLACK, false);

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
		
		
		

		_humanName = new FlxText(_humanHeadSprite.x + _humanHeadSprite.width + SPACING, _humanHeadSprite.y);
		_humanName.alignment = FlxTextAlign.CENTER;
		_humanName.size = 20;
		_humanName.fieldWidth = _width - _humanHeadSprite.width - 3 * SPACING;
		_humanName.text = "Lucas, 1er du nom";


		var text:String = "Un jour, Lucas a décidé de faire des Jeux Vidéo.";
		text += "\n\nDepuis, il galère.";
		text += "\n\nEt il a décidé d'emmener Guillaume dans sa galère.";
		text += "\n\nDeux Galériens, c'est toujours mieux qu'un Galérien tout seul.";
		text += "\n\nCette chaîne de caractère raconte leurs aventures dans le monde cruel du Jeu Vidéo !";

		_humanBiography = new FlxTypeText(_humanHeadSprite.x + _humanHeadSprite.width + SPACING, _humanHeadSprite.y + 2 * SPACING, 0, text, 12);
		_humanBiography.fieldWidth = _width - _humanBiography.x - SPACING;
		_humanBiography.start(0.006);
		
		_humanFoodRessourceSprite = new FlxSprite(2 * SPACING, _humanHeadSprite.y + _humanHeadSprite.height + SPACING);
		_humanFoodRessourceSprite.makeGraphic(32, 32, FlxColor.RED, false);

		_humanFoodText = new FlxText(_humanFoodRessourceSprite.x + _humanFoodRessourceSprite.width + SPACING / 2, _humanFoodRessourceSprite.y + 8);
		_humanFoodText.alignment = FlxTextAlign.LEFT;
		_humanFoodText.size = 14;
		_humanFoodText.fieldWidth = 64;
		_humanFoodText.text = "3.45";

		_humanMoneyRessoureSprite = new FlxSprite(2 * SPACING, _humanFoodRessourceSprite.y + _humanFoodRessourceSprite.height + SPACING);
		_humanMoneyRessoureSprite.makeGraphic(32, 32, FlxColor.YELLOW, false);

		_humanMoneyText = new FlxText(_humanMoneyRessoureSprite.x + _humanMoneyRessoureSprite.width + SPACING / 2, _humanMoneyRessoureSprite.y + 8);
		_humanMoneyText.alignment = FlxTextAlign.LEFT;
		_humanMoneyText.size = 14;
		_humanMoneyText.fieldWidth = 64;
		_humanMoneyText.text = "3.45";

		_humanIqRessourceSprite = new FlxSprite(2 * SPACING, _humanMoneyRessoureSprite.y + _humanMoneyRessoureSprite.height + SPACING);
		_humanIqRessourceSprite.makeGraphic(32, 32, FlxColor.MAGENTA, false);

		_humanIqText = new FlxText(_humanIqRessourceSprite.x + _humanIqRessourceSprite.width + SPACING / 2, _humanIqRessourceSprite.y + 8);
		_humanIqText.alignment = FlxTextAlign.LEFT;
		_humanIqText.size = 14;
		_humanIqText.fieldWidth = 64;
		_humanIqText.text = "3.45";

		_humanBloodRessourceSprite = new FlxSprite(2 * SPACING, _humanIqRessourceSprite.y + _humanIqRessourceSprite.height + SPACING);
		_humanBloodRessourceSprite.makeGraphic(32, 32, FlxColor.LIME, false);

		_humanBloodText = new FlxText(_humanBloodRessourceSprite.x + _humanBloodRessourceSprite.width + SPACING / 2, _humanBloodRessourceSprite.y + 8);
		_humanBloodText.alignment = FlxTextAlign.LEFT;
		_humanBloodText.size = 14;
		_humanBloodText.fieldWidth = 64;
		_humanBloodText.text = "3.45";

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
		add(_humanName);
		
		add(_humanFoodRessourceSprite);
		add(_humanFoodText);

		add(_humanMoneyRessoureSprite);
		add(_humanMoneyText);

		add(_humanIqRessourceSprite);
		add(_humanIqText);

		add(_humanBloodRessourceSprite);
		add(_humanBloodText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function updateHuman(human:Human)
	{
		_humanBiography.resetText(human._biography);
		_humanBiography.start(0.006);
		
		// TODO: autorisé ce skip ?
		if (human._infosAlreadyDisplayed) {
			_humanBiography.skip();
		}
		
		human._infosAlreadyDisplayed = true;
		
		_humanName.text = human._name;
		
		var foodCount			: Float = human._food;
		var moneyCount			: Float = human._money;
		var iqCount				: Float = human._iq;
		var bloodCount			: Float = human._blood;
		
		_humanFoodText.text 	= Std.string(fixedFloat(foodCount, 2));
		_humanMoneyText.text 	= Std.string(fixedFloat(moneyCount, 2));
		_humanIqText.text 		= Std.string(fixedFloat(iqCount, 2));
		_humanBloodText.text 	= Std.string(fixedFloat(bloodCount, 2));
	}
	
	public function updatePortrait(portrait:FlxSprite)
	{
		_humanPortrait.clear();
		_humanPortrait.add(portrait);
	}
	
	
	public function updateResources(player:Player)
	{
		var foodCount		: Float = player._food;
		var moneyCount		: Float = player._money;
		var iqCount			: Float = player._iq;
		var bloodCount		: Float = player._blood;
		
		_foodText.text 		= Std.string(fixedFloat(foodCount, 2));
		_moneyText.text 	= Std.string(fixedFloat(moneyCount, 2));
		_iqText.text 		= Std.string(fixedFloat(iqCount, 2));
		_bloodText.text 	= Std.string(fixedFloat(bloodCount, 2));
	}
	
	// Fonction pompée sur internet pour pouvoir arrondir un chiffre avec le nombre de chiffres après la virgule qu'on veut
	public static function fixedFloat(v:Float, ?precision:Int = 2):Float
	{
		return Math.round( v * Math.pow(10, precision) ) / Math.pow(10, precision);
	}
}