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
class Human extends FlxNapeSprite
{
	public var _spaceStation:SpaceStation;
	public var mainSprite:FlxNapeSprite;
	public var shadowSelect:FlxSprite;

	public var isGrab:Bool;

	//Caracteristique
	var _id				: Int;
	var _meatProduce 	: Float;
	var _milk			: Float;
	var _iq				: Int ;

	public var basicInfo : String;
	public var sicknessInfo : String;
	
	
	//Info lié à la position dans le tapis roulant
	public var posOnTable:FlxPoint;
	

	public function new(?X:Float=0, ?Y:Float=0, spaceStation:SpaceStation,id:Int,placeholderPos:FlxPoint)
	{
		super(X,Y,"assets/images/human.png",true,true);
		this.body.allowRotation = false;
		this.body.gravMass = 0.0;
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
	}

	public function init(meat:Float, iq:Int, milk:Float)
	{
		_meatProduce = meat;
		_iq = iq;
		_milk = milk;

		basicInfo += "ME TUER VOUS PERMETTRA DE PRODUIRE : " + _meatProduce + " KILOS DE VIANDE \r";
		basicInfo += "UTILISER MON CERVEAU VOUS PERMETTRA DE PRODUIRE : " + _iq + " POINTS DE QI \r";
		basicInfo += "ME VIDER DE MON EAU VOUS PERMETTRA DE PRODUIRE  : " + _milk + " LITRES D'EAU \r";
		
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);

		//FOR EACH AREA UN OVERLAPS
		if (FlxG.overlap(this, _spaceStation.burnhouse, getBurned, isActuallyGrab))
		{
			
		}
		else if (FlxG.overlap(this, _spaceStation.slaughterhouse, getSlaughtered, isActuallyGrab))
		{
			
		}
		else if (FlxG.overlap(this, _spaceStation.iqhouse, getBrainwashed, isActuallyGrab))
		{
			
		}
		else if (FlxG.overlap(this, _spaceStation.milkhouse, getMilked, isActuallyGrab))
		{
			
		}
		else
		{
			if (!isGrab)
			{
				this.x = posOnTable.x;
				this.y = posOnTable.y;
			}
			else
			{
				this.x = FlxG.mouse.x;
				this.y = FlxG.mouse.y;
			}
		}
		//this.x += 1;
		//if (this.alive)
		//{
			
		//}
	}

	private function isActuallyGrab(obj1:FlxObject, obj2:FlxObject):Bool
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

	private function getSlaughtered(obj1:FlxObject, obj2:FlxObject):Void
	{
		trace("BOUCHERIE");
		_spaceStation.meat += _meatProduce;
		_spaceStation.slaughterhouse.humanCount++;
		this.kill();
	}

	private function getBrainwashed(obj1:FlxObject, obj2:FlxObject):Void
	{
		trace("BRAINWASH");
		_spaceStation.iq += _iq;
		_spaceStation.iqhouse.humanCount++;
		this.kill();
	}

	private function getMilked(obj1:FlxObject, obj2:FlxObject):Void
	{
		trace("MILKED");
		_spaceStation.milk += _milk;
		_spaceStation.milkhouse.humanCount++;
		this.kill();
	}
	
	private function getBurned(obj1:FlxObject, obj2:FlxObject):Void
	{
		trace("BURNED");
		_spaceStation.burnhouse.humanCount++;
		this.kill();
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