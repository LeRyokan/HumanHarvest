package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.addons.ui.FlxUIButton;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxAssets.FlxShader;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import shaders.CRT;

class InfoScreen extends FlxSpriteGroup
{
	public static inline var OFFSET 			: Int = 10000;
	public static inline var SPACING 			: Int = 20;
	
	public static inline var NEWS_SPACING_MIN	: Int = 50;
	public static inline var NEWS_SPEED			: Int = 3;
	//COPIE DE LA STATIC INLINE QUI BIZARREMENT PEUT PAS ETRE ATTEINTE PAR LA CLASSE HUMAN
	public var _spacing : Int = 10020;
	
	public var _width 					: Int = Std.int(FlxG.width / 2);
	public var _height					: Int = FlxG.height - 150;


	// SHADER SECTION
	
	#if shaders_supported
	
	public static var useShaders:Bool = false;
	
	//private var _testerShader : ShadedChar;
	
	private var _shaderButton : FlxButton;
	
	private var crt = new CRT();
	
	private var timer : FlxTimer;
	
	#end
	
	
	//END SHADER SECTION
	
	
	public var _backgroundSprite 				: ShadedSprite;
	
	private var _humanShadedSpriteGroup			: FlxSpriteGroup;
	private var _humanShadedPortrait			: FlxTypedSpriteGroup<ShadedSprite>;
	
    private var _humanShadedHeadSprite 			: ShadedSprite;
    private var _humanShadedEyesSprite 			: ShadedSprite;
    private var _humanShadedMouthSprite 		: ShadedSprite;
	
	
	private var _shadedText						: ShadedText;
	
	
	
	
	//WILL DISAPPEAR
	private var _humanPortrait					:FlxTypedSpriteGroup<FlxSprite>;
	

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
	private var _humanSpriteGroup				: FlxSpriteGroup;
	
	private var _humanHeadSprite				: FlxSprite;
	private var _humanEyesSprite				: FlxSprite;
	private var _humanMouthSprite				: FlxSprite;
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
	
	// NEWS
	private var _infosSpriteGroup				: FlxSpriteGroup;
	private var _newsTitleText					: FlxText;
	private var _newsText						: FlxTypeText;
	
	// BUTTONS
	private var _showHumanInfosButton			: FlxUIButton;
	private var _showNewsButton					: FlxUIButton;
	
	// Autres
	private var _showHumans						: Bool = true;
	
	// BARRE DE NEWS BFMTV
	private var _newsBarBackground				: FlxSprite;
	//private var _newsBarTextFirst				: FlxText;
	//private var _newsBarTextSecond				: FlxText;
	private var _newsBarTextGroup				: FlxTypedSpriteGroup<FlxText>;
	
	private var _newsTexts 						: Array<String>;

	//private function set_useShader(Value:Bool):Bool
	//{
		//if (Value)
		//{
			//shader = _shader;
		//}
		//else
		//{
			//shader = null;
		//}
		//
		//return useShader = Value;
	//}	
	//
	//public function init(UseShader:Bool = false, ?Shader:FlxShader)
	//{
		//if (Shader != null)
		//{
			//_shader = Shader;
		//}
		//
		//useShader = UseShader;
	//}
	
	public function new()
	{
		super();

		this.x = OFFSET;
		
		//_backgroundSprite = new FlxSprite(0, 0);
		
		
		
		#if shaders_supported
		
		//Utilisé par le Shader
		timer = new FlxTimer();
		timer.start(0);
		
		_backgroundSprite = new ShadedSprite(0, 0,"assets/images/monitorBckground.png");
		_backgroundSprite.init(useShaders, crt);
		
		// HUMAIN FACE SHADED TEST
		
		_humanShadedSpriteGroup = new FlxSpriteGroup();
		
		_humanShadedHeadSprite = new ShadedSprite(20, 120);
		_humanShadedEyesSprite = new ShadedSprite(20, 120);
		_humanShadedMouthSprite = new ShadedSprite(20, 120);
		
		_humanShadedHeadSprite.init(useShaders, crt);
		_humanShadedEyesSprite.init(useShaders, crt);
		_humanShadedMouthSprite.init(useShaders, crt);
		
		_humanShadedHeadSprite.scale.set(2, 2);
		_humanShadedEyesSprite.scale.set(2, 2); 
		_humanShadedMouthSprite.scale.set(2, 2);
		
		_humanShadedPortrait = new FlxTypedSpriteGroup<ShadedSprite>();
		
		_humanShadedPortrait.add(_humanShadedHeadSprite);
		_humanShadedPortrait.add(_humanShadedEyesSprite);
		_humanShadedPortrait.add(_humanShadedMouthSprite);
		
		
		// SHADED TEXT TEST
		
		var trytext:String = "Un jour, Lucas a décidé de faire des Jeux Vidéo.";
		trytext += "\n\nDepuis, il galère.";
		trytext += "\n\nEt il a décidé d'emmener Guillaume dans sa galère.";
		trytext += "\n\nDeux Galériens, c'est toujours mieux qu'un Galérien tout seul.";
		trytext += "\n\nCette chaîne de caractère raconte leurs aventures dans le monde cruel du Jeu Vidéo !";
		
		
		_shadedText = new ShadedText(20 + 100 + SPACING, 120 + 2 * SPACING, 0, trytext, 12);
		_shadedText.init(useShaders, crt);
		_shadedText.fieldWidth = _width - _shadedText.x - SPACING;
		_shadedText.start(0.006);
		
		#end
		
		
		//_backgroundSprite.makeGraphic(_width, _height, FlxColor.BLACK, false);
		//_backgroundSprite.makeGraphic(_width, _height, FlxColor.fromRGB(16, 140, 119), false);
		
		// RESSOURCES
		_foodRessourceSprite = new FlxSprite(SPACING + SPACING, SPACING);
		_foodRessourceSprite.makeGraphic(32, 32, FlxColor.RED, false);

		_foodText = new FlxText(_foodRessourceSprite.x + _foodRessourceSprite.width + SPACING / 2, SPACING + 2);
		_foodText.alignment = FlxTextAlign.LEFT;
		_foodText.size = 20;
		_foodText.fieldWidth = 96;

		//_moneyRessoureSprite = new FlxSprite(_foodText.x + _foodText.width + SPACING, SPACING);
		//_moneyRessoureSprite.makeGraphic(32, 32, FlxColor.YELLOW, false);
//
		//_moneyText = new FlxText(_moneyRessoureSprite.x + _moneyRessoureSprite.width + SPACING / 2, SPACING + 2);
		//_moneyText.alignment = FlxTextAlign.LEFT;
		//_moneyText.size = 20;
		//_moneyText.fieldWidth = 96;
//
		//_iqRessourceSprite = new FlxSprite(_moneyText.x + _moneyText.width + SPACING, SPACING);
		//_iqRessourceSprite.makeGraphic(32, 32, FlxColor.MAGENTA, false);
//
		//_iqText = new FlxText(_iqRessourceSprite.x + _iqRessourceSprite.width + SPACING / 2, SPACING + 2);
		//_iqText.alignment = FlxTextAlign.LEFT;
		//_iqText.size = 20;
		//_iqText.fieldWidth = 96;
//
		//_bloodRessourceSprite = new FlxSprite(_iqText.x + _iqText.width + SPACING, SPACING);
		//_bloodRessourceSprite.makeGraphic(32, 32, FlxColor.LIME, false);
//
		//_bloodText = new FlxText(_bloodRessourceSprite.x + _bloodRessourceSprite.width + SPACING / 2, SPACING + 2);
		//_bloodText.alignment = FlxTextAlign.LEFT;
		//_bloodText.size = 20;
		//_bloodText.fieldWidth = 96;

	
		
		
		// VISAGE HUMAIN
		_humanSpriteGroup = new FlxSpriteGroup();
		
		// GESTION DE L'AFFICHAGE DU VISAGE //->
		_humanHeadSprite = new FlxSprite(20, 120);
		_humanEyesSprite = new FlxSprite(20, 120);
		_humanMouthSprite = new FlxSprite(20, 120);
		//_humanHeadSprite.makeGraphic(93, 116, FlxColor.BLACK, false);
		_humanHeadSprite.makeGraphic(93, 116, 0x00108C77, false);
		
		_humanHeadSprite.scale.set(2, 2);
		_humanEyesSprite.scale.set(2, 2);
		_humanMouthSprite.scale.set(2, 2);
	
		_humanPortrait = new FlxTypedSpriteGroup<FlxSprite>();
		_humanPortrait.add(_humanHeadSprite);
		_humanPortrait.add(_humanEyesSprite);
		_humanPortrait.add(_humanMouthSprite);
		
		//////////////////////////////////////->
		
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

		//_humanMoneyRessoureSprite = new FlxSprite(2 * SPACING, _humanFoodRessourceSprite.y + _humanFoodRessourceSprite.height + SPACING);
		//_humanMoneyRessoureSprite.makeGraphic(32, 32, FlxColor.YELLOW, false);
//
		//_humanMoneyText = new FlxText(_humanMoneyRessoureSprite.x + _humanMoneyRessoureSprite.width + SPACING / 2, _humanMoneyRessoureSprite.y + 8);
		//_humanMoneyText.alignment = FlxTextAlign.LEFT;
		//_humanMoneyText.size = 14;
		//_humanMoneyText.fieldWidth = 64;
		//_humanMoneyText.text = "3.45";
//
		//_humanIqRessourceSprite = new FlxSprite(2 * SPACING, _humanMoneyRessoureSprite.y + _humanMoneyRessoureSprite.height + SPACING);
		//_humanIqRessourceSprite.makeGraphic(32, 32, FlxColor.MAGENTA, false);
//
		//_humanIqText = new FlxText(_humanIqRessourceSprite.x + _humanIqRessourceSprite.width + SPACING / 2, _humanIqRessourceSprite.y + 8);
		//_humanIqText.alignment = FlxTextAlign.LEFT;
		//_humanIqText.size = 14;
		//_humanIqText.fieldWidth = 64;
		//_humanIqText.text = "3.45";
//
		//_humanBloodRessourceSprite = new FlxSprite(2 * SPACING, _humanIqRessourceSprite.y + _humanIqRessourceSprite.height + SPACING);
		//_humanBloodRessourceSprite.makeGraphic(32, 32, FlxColor.LIME, false);
//
		//_humanBloodText = new FlxText(_humanBloodRessourceSprite.x + _humanBloodRessourceSprite.width + SPACING / 2, _humanBloodRessourceSprite.y + 8);
		//_humanBloodText.alignment = FlxTextAlign.LEFT;
		//_humanBloodText.size = 14;
		//_humanBloodText.fieldWidth = 64;
		//_humanBloodText.text = "3.45";
		
		// NEWS
		_infosSpriteGroup = new FlxSpriteGroup();
		
		_newsTitleText = new FlxText((_width / 2) - 100, 80, 0, "ZoggytroNews", 32);
		// TODO: mieux centrer
		//_newsTitleText.alignment = FlxTextAlign.CENTER;
		//_newsTitleText.screenCenter(FlxAxes.X);
		
		var text:String = "\n\nPour le moment c'est du vu et revu mais imagine avec des petits blocs, peut être des images et tout.";
		text += "\n\nTiens je vais essayer de faire un exemple d'article en dessous, on va voir ce que ça donne.";
		text += "\n\nDans la nuit du Zurbi au Dyrpo, dans le quartier mal famé du centre ville de la banlieue de l'ouest de la capitale Zogytronnienne, c'est à dire, à 3.1254 degrés de latitude et 57.3254 degrés de longitude, peu après 2547h21, un jeune humain à l'allure obèse, tout de jaune vêtu, a été aperçu courant et criant sans arrêt d'une voix que les humains emprisonnés à côté ont plus tard qualifiés de \"chèvrique, à la limite de l'humain\". Depuis, des rumeurs ont émergés chez les humains, certains parlent de leur sauveur, un certain Mr. Belly, sorte de Jésus 8.0, malgré sa ressemblance à Donal Trump. Si vous apercevez cet énergumène, NE L'APPROCHEZ SURTOUT PAS et appellez tout de suite votre maman, avant de vous mettre en DBA (Disposition en Biais d'Assurance). Merci et désolé.";
		text += "\n\nBon, donc faudra monter la taille du texte et/ou mettre un écart de ligne plus grand, là c'est illisible ptain !";

		_newsText = new FlxTypeText(SPACING, 150, 0, text, 12);
		_newsText.fieldWidth = _width - 2*SPACING;
		_newsText.start(0.01);
		
		// BUTTONS
		_showHumanInfosButton = new FlxUIButton(SPACING, _height - 100 - SPACING, "Human", OnClickShowHumanInfosButton);
		_showHumanInfosButton.resize((_width / 2) - 1.5*SPACING, 50);
		_showHumanInfosButton.label.size = 14;
		
		_showNewsButton = new FlxUIButton(_showHumanInfosButton.x + _showHumanInfosButton.width + SPACING, _showHumanInfosButton.y, "News", OnClickShowNewsButton);
		_showNewsButton.resize((_width / 2) - 1.5*SPACING, 50);
		_showNewsButton.label.size = 18;
		
		// NEWS BAR temp
		_newsBarBackground = new FlxSprite(0, _height - 50);
		_newsBarBackground.makeGraphic(_width, 50, FlxColor.BLUE);
		
		_newsTexts = new Array<String>();
		_newsTexts.push("Aujourd'hui, Guillaume a eu la chiasse et c'était pas beau à voir :/");
		_newsTexts.push("Ceci est un message déroulant lolilol, et comme je te l'ai dit, j'ai un nouveau clavier, j'aime taper avec, donc je vais écrire plein de caca pour voir ce que ça donne sur un long message.");
		_newsTexts.push("Gros texte. Petit texte. Petit texte. Petit texte. Petit texte.");
		_newsTexts.push("Petit pénis. Petit pénis. Petit pénis. Petit pénis.");
		_newsTexts.push("Grosse bite qui sent le fromage. Petit texte. Petit texte. Petit texte.");
		
		//_newsBarTextFirst = new FlxText(0, _height - 37, 0, _newsTexts[0], 20);
		//_newsBarTextFirst.wordWrap = false;
		//_newsBarTextFirst.autoSize = true;
		
		// 50 = espace entre 2 news pour le moment
		//_newsBarTextSecond = new FlxText(_newsBarTextFirst.fieldWidth + 50, _height - 37, 0, _newsTexts[Std.random(_newsTexts.length)], 20);
		//_newsBarTextSecond.wordWrap = false;
		//_newsBarTextSecond.autoSize = true;
		
		_newsBarTextGroup = new FlxTypedSpriteGroup<FlxText>();
		_newsBarTextGroup.x = 0;
		_newsBarTextGroup.y = _height - 37;
		
		// Ajout de tout à la fin sinon avec le x = 10000, ça merde le placement
		add(_backgroundSprite);

		#if shaders_supported
		
		_shaderButton = new FlxButton(100, 0, "Shaders: Off", onShaderToggle);
		add(_shaderButton);
		
		_humanShadedSpriteGroup.add(_humanShadedPortrait);
		_humanShadedSpriteGroup.add(_shadedText);
		
		
		#end
		
		add(_foodRessourceSprite);
		add(_foodText);

		//add(_moneyRessoureSprite);
		//add(_moneyText);
//
		//add(_iqRessourceSprite);
		//add(_iqText);
//
		//add(_bloodRessourceSprite);
		//add(_bloodText);

		// HUMAIN
		_humanSpriteGroup.add(_humanPortrait);
		_humanSpriteGroup.add(_humanBiography);
		_humanSpriteGroup.add(_humanName);
		
		_humanSpriteGroup.add(_humanFoodRessourceSprite);
		_humanSpriteGroup.add(_humanFoodText);

		//_humanSpriteGroup.add(_humanMoneyRessoureSprite);
		//_humanSpriteGroup.add(_humanMoneyText);
//
		//_humanSpriteGroup.add(_humanIqRessourceSprite);
		//_humanSpriteGroup.add(_humanIqText);
//
		//_humanSpriteGroup.add(_humanBloodRessourceSprite);
		//_humanSpriteGroup.add(_humanBloodText);
		//
		
		// NEWS
		_infosSpriteGroup.add(_newsTitleText);
		_infosSpriteGroup.add(_newsText);
		
		_infosSpriteGroup.visible = false;
		//
		#if shaders_supported
		add(_humanShadedSpriteGroup);
		//add(_humanShadedPortrait);
		#end
		//add(_humanSpriteGroup);
		add(_infosSpriteGroup);
		
		// BUTTONS
		add(_showHumanInfosButton);
		add(_showNewsButton);
		
		add(_newsBarBackground);
		//add(_newsBarTextFirst);
		//add(_newsBarTextSecond);
		add(_newsBarTextGroup);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		#if shaders_supported
		crt.time += timer.elapsedTime;

		#end
		
		
		// On fait avancer toutes les news, et si jamais elles sortent du cadre (donc vues), on les supprime
		for (newsBarText in _newsBarTextGroup) 
		{
			newsBarText.x -= NEWS_SPEED;
			if (newsBarText.x < OFFSET - newsBarText.fieldWidth)
			{
				_newsBarTextGroup.remove(newsBarText, true);
			}
		}
		
		// méthode de débug pour ajouter une news
		if (FlxG.keys.justPressed.N) 
		{
			var newsBarText:FlxText = new FlxText(0, 0, 0, _newsTexts[Std.random(_newsTexts.length)], 20);
			newsBarText.wordWrap = false;
			newsBarText.autoSize = true;
			
			if (_newsBarTextGroup.length == 0)
			{
				newsBarText.x = _width;
			} else 
			{
				var last:FlxText = _newsBarTextGroup.members[_newsBarTextGroup.members.length - 1];
				newsBarText.x = last.x + last.fieldWidth + NEWS_SPACING_MIN - OFFSET;
			}

			_newsBarTextGroup.add(newsBarText);
		}
		
		if (_showHumans) {
			_showHumanInfosButton.color = FlxColor.WHITE;
			_showNewsButton.color = FlxColor.GRAY;
			
			//_humanSpriteGroup.visible = true;
			_humanShadedSpriteGroup.visible = true;
			_infosSpriteGroup.visible = false;
		} else {
			_showHumanInfosButton.color = FlxColor.GRAY;
			_showNewsButton.color = FlxColor.WHITE;
			
			//_humanSpriteGroup.visible = false;
			_humanShadedSpriteGroup.visible = false;
			_infosSpriteGroup.visible = true;
		}
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
		
		_humanFoodText.text 	= Std.string(fixedFloat(foodCount, 2));
		
		
		//MISE A JOUR DU PORTRAIT
		_humanHeadSprite.loadGraphic(human._faceImg, false, 205, 256, true);
		_humanEyesSprite.loadGraphic(human._eyesImg, false, 205, 256, true);
		_humanMouthSprite.loadGraphic(human._mouthImg, false, 205, 256, true);
		//_humanPortrait = human._generatedFace;
		
		
		#if shaders_supported
		_humanShadedHeadSprite.loadGraphic(human._faceImg, false, 205, 256, true);
		_humanShadedEyesSprite.loadGraphic(human._eyesImg, false, 205, 256, true);
		_humanShadedMouthSprite.loadGraphic(human._mouthImg, false, 205, 256, true);
	
			
		#end
		
		
	}
	
	
	public function updateResources(player:Player)
	{
		var foodCount		: Float = player._food;
		//var moneyCount		: Float = player._money;
		//var iqCount			: Float = player._iq;
		//var bloodCount		: Float = player._blood;
		
		_foodText.text 		= Std.string(fixedFloat(foodCount, 2));
		//_moneyText.text 	= Std.string(fixedFloat(moneyCount, 2));
		//_iqText.text 		= Std.string(fixedFloat(iqCount, 2));
		//_bloodText.text 	= Std.string(fixedFloat(bloodCount, 2));
	}
	
	private function OnClickShowHumanInfosButton():Void
	{
		trace("human");
		_showHumans = true;
	}
	
	private function OnClickShowNewsButton():Void
	{
		trace("news");
		_showHumans = false;
	}
	
	// Fonction pompée sur internet pour pouvoir arrondir un chiffre avec le nombre de chiffres après la virgule qu'on veut
	public static function fixedFloat(v:Float, ?precision:Int = 2):Float
	{
		return Math.round( v * Math.pow(10, precision) ) / Math.pow(10, precision);
	}
	
	#if shaders_supported
	//FAIRE DE CETTE FONCTION UNE OPTION DANS LES MENU DE PAUSE POUR ACTIVER/DESACTIVER LES SHADERS
	private function onShaderToggle():Void
	{
		useShaders = !useShaders;
		toggleHelper(_shaderButton, "Shaders: Off", "Shaders: On");
		
		_backgroundSprite.useShader = useShaders;
		_shadedText.useShader = useShaders;
		
		for (part in _humanShadedPortrait)
		{
			if (part != null)
			{
				part.useShader = useShaders;
			}
		}
		
		//_testerShader.useShader = useShaders;
		
		// Update the bunnies
		//for (bunny in _bunnies)
		//{
			//if (bunny != null)
			//{
				//bunny.useShader = useShaders;
			//}
		//}
	}
	#end
	
	private function toggleHelper(Button:FlxButton, Text1:String, Text2:String):Void
	{
		if (Button.label.text == Text1)
		{
			Button.label.text = Text2;
		}
		else 
		{
			Button.label.text = Text1;
		}
	}
	
}