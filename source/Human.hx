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
	public var _spaceStation:SpaceStation;
	public var mainSprite:FlxNapeSprite;
	public var shadowSelect:FlxSprite;

	public var isGrab:Bool;

	//Caracteristique
	var _id				: Int;
	public var _meat 	: Float;
	public var _blood			: Float;
	public var _iq				: Int ;

	public var basicInfo : String;
	public var sicknessInfo : String;

	//Info lié à la position dans le tapis roulant
	public var posOnTable:FlxPoint;

	public function new(?X:Float=0, ?Y:Float=0, spaceStation:SpaceStation,id:Int,placeholderPos:FlxPoint)
	{
		super(X,Y,"assets/images/human.png");
		//this.body.allowRotation = false;
		//this.body.gravMass = 0.0;
		_id = id;

		//posOnTable = new FlxPoint(X, Y);
		posOnTable = placeholderPos;

		//Inclusion du HumanProfile
		//LES TEXTES SERONT GENERER COTE HUMANPROFILE
		var humanP = new HumanProfile();

		//ON INIT LES RESSOURCES EN PREMIER -- NON UTILISER ACTUELLEMENT
		init(humanP._meat, humanP._iq, humanP._milk);

		if (humanP.isSick)
		{
			sicknessInfo = "JE SUIS MALADE";
		}
		else
		{
			sicknessInfo = "JE SUIS SAIN";
		}

		basicInfo = new String("JE SUIS L'HUMAIN NUMERO " +_id + "\r");
		basicInfo += sicknessInfo + "\r\r";

		isGrab = false;
		_spaceStation = spaceStation;

		//Setup mouse event
		//FlxMouseEventManager.add(mainSprite, onMouseDown, onMouseUp, onMouseOver, onMouseOut);
		
		setSize(32, 32);
		offset.set(-16, 0);
		//trace("width : " + width + " - height : " + height);
		//FlxG.watch.add(this, "isGrab", "Grab : " );
	}

	public function init(meat:Float, iq:Int, milk:Float)
	{
		_meat = meat;
		_iq = iq;
		_blood = milk;

		basicInfo += "ME TUER VOUS PERMETTRA DE PRODUIRE : " + _meat + " KILOS DE VIANDE \r";
		basicInfo += "UTILISER MON CERVEAU VOUS PERMETTRA DE PRODUIRE : " + _iq + " POINTS DE QI \r";
		basicInfo += "ME VIDER DE MON EAU VOUS PERMETTRA DE PRODUIRE  : " + _blood + " LITRES D'EAU \r";
		basicInfo += "STATUT GRAB : " + isGrab ;

	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);

		
		if (!isGrab)
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
					this.y = posOnTable.y;
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
		if (isGrab)
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
		_spaceStation.player._meat += human._meat;
		area.humanCount++;
		human.kill();
	}

	//private function onMouseOver(_)
	//{
	////shadowSelect.visible = true;
	//}
	//
	//private function onMouseOut(_)
	//{
	////shadowSelect.visible = false;
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