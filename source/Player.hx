package;

import enums.Levels;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.nape.FlxNapeSpace;
import flixel.input.mouse.FlxMouseEventManager;
import nape.constraint.DistanceJoint;
import nape.geom.Vec2;

using flixel.util.FlxSpriteUtil;

class Player extends FlxBasic
{
	public var 	_currentGrabbedHuman			: Human;
	private var _currentHumanWithInfoDisplay	: Human;

	private var _mouseJoint						: DistanceJoint;
	private var _spaceStation					: SpaceStation;

	public var _food	 			: Float;
	public var _money 				: Float;
	public var _blood 				: Float;
	public var _iq 	 				: Float;
	public var _notoriety 			: Float;

	public var _stockFood			: Float;
	public var _stockMoney			: Float;
	public var _stockBlood			: Float;
	public var _stockIq				: Float;
	public var _stockNotoriety		: Float;
	
	//LES VALEURS MORALES
	public var _monstruosity 		: Float;
	public var _moralHealth			: Float = 50.0;
	//public var _
	
	
	//affiche le nombre jours passé
	//public var _day : Int;
	public var _day : Levels;

	public function new(spaceStation:SpaceStation)
	{
		super();

		initCursor();

		_spaceStation = spaceStation;
		_day = spaceStation.currentLevel;
		
		
		if (_day == Levels.DAY_1)
		{
			_food = 0;
			_money = spaceStation.levelConstraint.moneyPossessed;
			_blood = 0;
			_iq = 0;
			_notoriety = 0;

			_stockFood = 100;
			_stockMoney = Tweaking.playerMoney;
			_stockBlood = 100;
			_stockIq = 100;
			_stockNotoriety = 0;
		}
		else	// INIT LES INFOS PAR RAPPORT AUX RESULTATS DE LA VEILLE
		{
			_food = 0;
			_money = spaceStation.levelConstraint.moneyPossessed;
			_blood = 0;
			_iq = 0;
			_notoriety = 0;

			_stockFood = 100;
			_stockMoney = Tweaking.playerMoney;
			_stockBlood = 100;
			_stockIq = 100;
			_stockNotoriety = 0;

		}
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (_currentHumanWithInfoDisplay!=null && !_currentHumanWithInfoDisplay.alive)
		{
			cleanScreenInfo();
		}
		
		// TODO: idéalement, foutre dans le onMouseUp
		if (FlxG.mouse.justReleased)
		{
			if (_currentGrabbedHuman != null)
			{
				_currentGrabbedHuman._isGrabbed = false;
				
				trace("SPRITE RELACHE");
				
				if (FlxG.overlap(_currentGrabbedHuman, _spaceStation.slaughterhouse, slaughter))
				{
					trace("BUTCHERED");
				}
				else if (FlxG.overlap(_currentGrabbedHuman, _spaceStation.iqhouse, getBrainwashed))
				{
					trace("IQED");
				}
				else if (FlxG.overlap(_currentGrabbedHuman, _spaceStation.milkhouse, getMilked))
				{
					trace("MILKED");
				}
				else if (FlxG.overlap(_currentGrabbedHuman, _spaceStation.burnhouse, tryBurn))
				{
					trace("BURNED");
				}
				else
				{
					_currentGrabbedHuman._posOnTable.x = FlxG.mouse.x; //a déplacer je pense
					_currentGrabbedHuman._posOnTable.y = 100;//constante de la hauteur du tapis roulant
					//condition de si on dépasse la zone
				}
				_currentGrabbedHuman = null;
			}
		}
		//
		
	}

	public function initCursor():Void
	{
		// Create a white circle to use as a cursor graphic
		var sprite = new FlxSprite();
		//sprite.makeGraphic(15, 15, FlxColor.TRANSPARENT);
		//sprite.drawCircle( -1, -1, -1, FlxColor.fromRGB(255, 255, 255, 125));

		sprite.loadGraphic("assets/images/alien_pointer.png", false, 32, 32, true);

		// Load the sprite's graphic to the cursor
		FlxG.mouse.load(sprite.pixels);
	}

	public inline function registerPhysSprite(human:Human)
	{
		// Le false de fin c'est pour pas se baser sur le sprite mais plutôt sur la hitbox
		FlxMouseEventManager.add(human, createMouseJoint, humanReleased, getInfoAboutThis, onMouseOut, false, true, false);
	}

	// onMouseDown
	function createMouseJoint(human:Human)
	{
		_currentGrabbedHuman = human;
		_currentGrabbedHuman._isGrabbed = true;

		//_mouseJoint = new DistanceJoint(	FlxNapeSpace.space.world,
											//human.body,
											//new Vec2(FlxG.mouse.x, FlxG.mouse.y),
											//human.body.worldPointToLocal(new Vec2(FlxG.mouse.x, FlxG.mouse.y)),
											//0,
											//0);
		//_mouseJoint.space = FlxNapeSpace.space;
		

	}

	// onMouseUp
	// TODO: fonctionne pas pour le moment
	function humanReleased(human:Human)
	{
		// NON UTILISE

		// mouseJoint.space = null;
		// human.isGrab = false;
		// human.posOnTable.x = FlxG.mouse.x;
		// human = null;
		// trace("SPRITE RELACHE");
	}

	public function tryBurn(human:Human, area:Area):Void
	{
		trace("POUBELLE");
		area.humanCount++;
		human.kill();
	}

	public function slaughter(human:Human, area:Area):Void
	{
		trace("BOUCHERIE");
		_food += human._food;
		area.humanCount++;
		human.kill();
	}

	public function getBrainwashed(human:Human, area:Area):Void
	{
		trace("BRAINWASH");
		_iq += human._iq;
		area.humanCount++;
		human.kill();
	}

	public function getMilked(human:Human, area:Area):Void
	{
		trace("SAIGNEE");
		_blood += human._blood;
		area.humanCount++;
		human.kill();
	}

	// onMouseOver
	function getInfoAboutThis(human:Human)
	{
		//trace("in");
		_spaceStation.sendTextToInfoScreen(human);
		//_spaceStation.sendPortraitToInfoScreen(
		//_currentHumanWithInfoDisplay = human;
		
	}

	// onMouseOut // A MODIFIER
	function onMouseOut(human:Human)
	{
		//trace("out");
		cleanScreenInfo();
		_currentHumanWithInfoDisplay = null;
	}

	function cleanScreenInfo()
	{
	//	_spaceStation.sendTextToInfoScreen("");
	}
}