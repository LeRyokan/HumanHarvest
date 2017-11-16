package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import flixel.group.FlxGroup;
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
	
	//Info graphique
	public var _headSprite 				: FlxSprite;

	public function new(?X:Float=0, ?Y:Float=0, spaceStation:SpaceStation,id:Int,placeholderPos:FlxPoint)
	{
		super(X, Y, "assets/images/human.png");
		
		//this.body.allowRotation = false;
		//this.body.gravMass = 0.0;
		_id = id;

		//posOnTable = new FlxPoint(X, Y);
		_posOnTable = placeholderPos;

		//Inclusion du HumanProfile
		//LES TEXTES SERONT GENERER COTE HUMANPROFILE
		var humanP = new HumanProfile();

		
		//LOAD L'IMAGE DU VISAGE
		_headSprite = new FlxSprite(0,0);
		_headSprite.loadGraphic(humanP.imgAdress, false, 64, 32, false);
		
		
		//ON INIT LES RESSOURCES EN PREMIER -- NON UTILISER ACTUELLEMENT
		init(humanP._meat, humanP._iq, humanP._milk);

		if (humanP.isSick)
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
		
		_biography = _biographies[FlxG.random.int(0, _biographies.length - 1)];
		_name = _names[FlxG.random.int(0, _names.length - 1)];
		_infosAlreadyDisplayed = false;
	}

	public function init(meat:Float, iq:Int, milk:Float)
	{
		_food = meat;
		_money = 12;
		_iq = iq;
		_blood = milk;

		_basicInfo += "ME TUER VOUS PERMETTRA DE PRODUIRE : " + _food + " KILOS DE VIANDE \r";
		_basicInfo += "UTILISER MON CERVEAU VOUS PERMETTRA DE PRODUIRE : " + _iq + " POINTS DE QI \r";
		_basicInfo += "ME VIDER DE MON EAU VOUS PERMETTRA DE PRODUIRE  : " + _blood + " LITRES D'EAU \r";
		_basicInfo += "STATUT GRAB : " + _isGrabbed ;

	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);

		
		if (!_isGrabbed)
		{
			if (FlxG.overlap(this, _spaceStation.slaughterhouse, getSlaughtered))
			{
				
			}
			else
			{
				//trace("UPDATE POS");
				//is.body.velocity.x = 50; //20
				this.velocity.x = 50;
				if (this.y != 100)
				{
					this.y = _posOnTable.y;
				}
				//this.acceleration.x = 10;
				//this.velocity.x = 10;
				//this.x = posOnTable.x;
				//this.y = posOnTable.y;
			}
		}
		else
		{
			this.x = FlxG.mouse.x - (width / 4);
			this.y = FlxG.mouse.y + 4;
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

	//private function getBurned(human:Human, area:Area):Void
	//{
		//trace("BURNED");
		//_spaceStation.burnhouse.humanCount++;
		//human.kill();
	//}
	
	private function getSlaughtered(human:Human, area:Area):Void
	{
		trace("BOUCHERIE");
		_spaceStation.player._food += human._food;
		area.humanCount++;
		human.kill();
	}

	//private function onMouseOver(_)
	//{
	////_shadowSelect.visible = true;
	//}
	//
	//private function onMouseOut(_)
	//{
	////_shadowSelect.visible = false;
	//}
	//
	//private function onMouseDown(_)
	//{
	//isGrab = true;
	//}
	//
	//private function onMouseUp(_)
	//{
	//isGrab = false;
	//}
	//

}