package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxAccelerometer;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import nape.phys.BodyType;

/**
 * ...
 * @author ElRyoGrande
 */
class Human extends FlxSprite
{
	// TODO: essayer de l'en sortir, plutôt mettre la gestion de collision du côté de la spacestation
	private var _spaceStation			: SpaceStation;
	private var _shadowSelect			: FlxSprite;

	public var _isGrabbed				: Bool;

	//Caracteristique
	public var _id						: Int;
	
	public var _food 					: Float;
	public var _money 					: Float;
	public var _blood					: Float;
	public var _iq						: Float;

	public var _basicInfo 				: String;
	public var _sicknessInfo			: String;

	//Info lié à la position dans le tapis roulant
	public var _posOnTable				: FlxPoint;
	
	// Indique si on a déjà affiché les infos du bonhomme
	// Si oui, on réaffiche le texte directement
	public var _infosAlreadyDisplayed	: Bool;
	
	// "Biographie" du bonhomme
	// Peut contenir des infos cachées sur des ressources cachées
	public var _biography 				: String;
	
	// Nom du bonhomme
	// Pour le lolz
	public var _name					: String;
	
	// TODO: importer d'un fichier
	private var _biographies:Array<String> = ["Lorem  lorem sit amet risus hendrerit elementum. Mauris laoreet urna at dui sagittis aliquet. Donec ac neque nisi. Nullam quis lacinia velit. Phasellus tincidunt, dui eget gravida lobortis, lacus ligula dignissim sem, vel volutpat.\n\nDonec sed nisl eget elit bibendum iaculis. Fusce eu mollis augue, ut tempor est. Curabitur tempus libero eget nisl faucibus, vel fringilla quam pretium. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis sed lectus sit amet lacus ultrices ullamcorper. Morbi risus felis, pharetra elementum elit nec, lacinia finibus sem. Donec finibus lorem ac blandit gravida. Nunc at feugiat nisi, sed varius magna. Pellentesque interdum in erat non tempus.", "Pear", "Banana", "Orange", "Mangue", "CACA", "LEL"];
	private var _names:Array<String> = ["Lorem", "Pear", "Banana", "Orange", "Mangue", "CACA", "LEL"];
	
	////Info graphique
	//public var _humanProf : HumanProfile;
	////public var portrait : FlxSprite;
	//public var portrait : FlxSpriteGroup;
	//public var imgportrait : FlxSprite;
	//public var imgAdress : String;
	
	
	// Pour la creation du portrait
	public var _generatedFace	: FlxTypedSpriteGroup<FlxSprite>;
	public var _faceGeometry 	: FlxSprite;
	
	public var _faceImg : String;
	public var _eyesImg : String;
	public var _mouthImg : String;
	
	var _imgPath : String = "assets/images/faces/";
	var _eyes : FlxSprite;
	var _mouth : FlxSprite;
	var _skinColor : String;
	
	
	
	//GAMEPLAY TEST
	
	
	public var isSick : Bool;
	public var isReadyToDie : Bool = false;

	
	

	public function new(?X:Float=0, ?Y:Float=0, spaceStation:SpaceStation,id:Int,pos:FlxPoint)
	{
		super(X, Y, "assets/images/human.png");
		
		_id = id;
		_posOnTable = pos;
		
		//GENERATION DU VISAGE
		createFace();
		
		//DETERMINATION DE LA MALADIE
		SicknessDetermination();
		
		if (isSick)
		{
			_sicknessInfo = "JE SUIS MALADE";
		}
		else
		{
			_sicknessInfo = "JE SUIS SAIN";
		}

		_basicInfo = new String("JE SUIS L'HUMAIN NUMERO " +_id + "\r");
		_basicInfo += _sicknessInfo + "\r\r";

		_isGrabbed = false;
		_spaceStation = spaceStation;

		setSize(32, 32);
		offset.set(-16, 0);
		//trace("width : " + width + " - height : " + height);
		//FlxG.watch.add(this, "isGrab", "Grab : " );
		
		//_biography = _biographies[FlxG.random.int(0, _biographies.length - 1)];
		_biography = _basicInfo;
		_name = _names[FlxG.random.int(0, _names.length - 1)];
		_infosAlreadyDisplayed = false;
	}

	public function init(meat:Float, iq:Int, milk:Float)
	{
		_food = meat;
		_money = 12;
		_iq = iq;
		_blood = milk;

		//_basicInfo += "ME TUER VOUS PERMETTRA DE PRODUIRE : " + _food + " KILOS DE VIANDE \r";
		//_basicInfo += "UTILISER MON CERVEAU VOUS PERMETTRA DE PRODUIRE : " + _iq + " POINTS DE QI \r";
		//_basicInfo += "ME VIDER DE MON EAU VOUS PERMETTRA DE PRODUIRE  : " + _blood + " LITRES D'EAU \r";
		//_basicInfo += "STATUT GRAB : " + _isGrabbed ;

	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.overlap(this, _spaceStation.slaughterhouse, getSlaughtered);
			
		this.velocity.x = 50;
		if (this.y != 100)
		{
			this.y = _posOnTable.y;
		}
		
			
		if (_isGrabbed && !_spaceStation.stampMode)
		{
			this.x = FlxG.mouse.x - FlxG.mouse.cursorContainer.width;
			this.y = FlxG.mouse.y - FlxG.mouse.cursorContainer.height;
		}
		
		if(_isGrabbed && _spaceStation.stampMode)
		{
			if (!isReadyToDie)
			{
				isReadyToDie = true;
				_basicInfo += " PRET POUR EN FAIRE DES STEAKS ! ";
				_biography = _basicInfo;
				_spaceStation.infoScreen.updateHuman(this);
			}
			
		}
	}

	private function isActuallyGrab(human:Human, area:Area):Bool
	{
		if (_isGrabbed)
		{
			return false;
		}
		else
		{
			return true;
		}
	}

	// VA BOUGER JE PENSE
	private function getSlaughtered(human:Human, area:Area):Void
	{
		if(!human.isSick)
		{
			if (human.isReadyToDie)
			{
				trace("BOUCHERIE");
				_spaceStation.player._food += human._food;
				area.humanCount++;
				
			}
			else
			{
				//MALUS : COUTE PLUS CHER   ++
				//MALUS : PRODUIT MOINS DE VIANDE ++++
				
				//OU SIMPLEMENT NULLITE DE LA MORT  ---
				trace("TU L'AVAIS PAS MARQUER TU GAGNE MOINS DE BOUFFE"); // PAS LOGIQUE
				_spaceStation.player._food += human._food/2;
				_spaceStation.lostHuman++;
			}
		}
		else
		{
			if (_spaceStation.player._food -20 <= 0)
			{
				_spaceStation.player._food = 0;
			}
			else
			{
				_spaceStation.player._food -= 20;
			}
		}
		human.kill();
		
	}

	
	//IDEE de centraliser les tests de l'humain 
	public function checkHuman(human:Human, area:Area)
	{
		
		var value = 0.0;
		
		switch (area._areaType) 
		{
			case SLAUGHTERHOUSE:
				
				if (!human.isSick)
				{
					if (human.isReadyToDie)
					{
						//value = 
					}
					else
					{
						
					}
				}
				else
				{
					value = -50.0;
				}
				
				
				
			default:
				
		}
	}
	
	
	public function createFace()
	{
		_generatedFace = new FlxTypedSpriteGroup<FlxSprite>();
		_generatedFace.x = 430;
		_generatedFace.y = 400;
		
		if (FlxG.random.int(0, 1) == 0)
		{
			_skinColor = "blanc_";
		}
		else
		{
			_skinColor = "noir_";
		}
		
		_imgPath = "assets/images/faces/";
		
		var randFace = FlxG.random.int(1, 2);
		var randNose = FlxG.random.int(1, 2);
		var randEyes = FlxG.random.int(1, 2);
		
		
		
		//TAILLE DES IMAGES
		//93,116
		
		
		//_faceGeometry = new FlxSprite(0,0);
		_faceImg = _imgPath +"visage_" + _skinColor + randFace +".png";
		//_faceGeometry.loadGraphic(_faceImg, false, 205, 256, true);
		
		//_mouth = new FlxSprite(0, 0);
		_mouthImg = _imgPath +"bouche_" + _skinColor + randNose +".png";
		//_mouth.loadGraphic(_mouthImg, false, 205, 256, true);
		
		
		//_eyes = new FlxSprite(0, 0);
		_eyesImg = _imgPath +"yeux_" + _skinColor + randEyes +".png";
		//_eyes.loadGraphic(_eyesImg, false, 205, 256, true);
		
		//FACULTATIF
		//var eyebrow = new FlxSprite(0,0);

		
		
		//_generatedFace.add(_faceGeometry);
		//_generatedFace.add(_eyes);
		//_generatedFace.add(_mouth);
//
		//_generatedFace.scale.set(3, 3);
		//
		//
	}
	
	public function SicknessDetermination()
	{
		var sickChance = 70.0; //Value evolue en fonction du LVL
		var luckyNumber = FlxG.random.float(0, 100.0);
		
		if (luckyNumber <= sickChance)
		{
			//trace("MALADE");
			isSick = true;
		}
		else
		{
			//trace("SAIN");
			isSick = false;
		}
	}

}