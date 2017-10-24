package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSpace;
import flixel.addons.nape.FlxNapeSprite;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
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

	public function new(?X:Float=0, ?Y:Float=0, spaceStation:SpaceStation,id:Int)
	{
		super(X,Y,"assets/images/human.png",true,true);
		this.body.allowRotation = false;
		this.body.gravMass = 0.0;
		_id = id;

		//Inclusion du HumanProfile
		//LES TEXTES SERONT GENERER COTE HUMANPROFILE
		var humanP = new HumanProfile();
		if (humanP.isSick)
		{
			sicknessInfo = "JE SUIS MALADE";

		}
		else
		{
			sicknessInfo = "JE SUIS SAIN";
		}

		basicInfo = new String("JE SUIS L'HUMAIN NUMERO " +_id + "\r");
		basicInfo += sicknessInfo;

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

	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);

		//FOR EACH AREA UN OVERLAPS
		FlxG.overlap(this, _spaceStation.slaughterhouse, getSlaughtered, isActuallyGrab);
		FlxG.overlap(this, _spaceStation.iqhouse, getBrainwashed, isActuallyGrab);
		FlxG.overlap(this, _spaceStation.milkhouse, getMilked, isActuallyGrab);
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
		this.kill();

	}

	private function getBrainwashed(obj1:FlxObject, obj2:FlxObject):Void
	{
		trace("BRAINWASH");
		_spaceStation.iq += _iq;
		this.kill();

	}

	private function getMilked(obj1:FlxObject, obj2:FlxObject):Void
	{
		trace("MILKED");
		_spaceStation.milk += _milk;
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