package;

import flixel.FlxG;
import flixel.addons.nape.FlxNapeSprite;
import flixel.addons.nape.FlxNapeVelocity;
import flixel.addons.nape.FlxNapeSpace;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import nape.geom.Vec2;
import openfl.geom.Rectangle;
import ui.InfoScreen;
import ui.RessourceBar;
import state.DebriefState;

/**
 * ...
 * @author ElRyoGrande
 */
class SpaceStation extends FlxGroup 
{
	////////////////////////////////////////
	//A MIGRER PLUS TARD DANS GAME SESSION//
	//Game timer
	public var gameTimer : FlxTimer;
	public var dayTimer : FlxTimer;
	
	var quarterTime : Bool = false;
	var halfTime: Bool = false;
	var threeQuarterTime : Bool = false;
	var endNearTime:Bool = false;
	
	var dayDuration : Float;
	var gameDuration : Float;
	public var isDayFinish :Bool = false;
	
	var maxHumainKidnap: Int = 5;  //A INIT VIA LE XML DU LEVEL
	var maxWave:Int = 5;
	var waveCount: Int = 0;
	var canSpawnNewWave : Bool = true;
	var peopleCount : Int = 0 ;
	var peoplePlaced : Int = 0;
	///////////////////////////////////////
	
	var placeholderArray : Array<FlxPoint>;
	
	
	//Les entités du jeu
	public var player : Player;
	public var humanGroup : FlxTypedGroup<FlxNapeSprite>;
	
	//public var aliveHumanLeft : Int = 2;
	
	//AREA : A regrouper maybe en FINAL ZONE AREA
	public var slaughterhouse : Area;
	public var iqhouse : Area;
	public var milkhouse : Area;
	public var burnhouse: Area;
	
	
	//LOGIC RESSOURCES ACTUELLEMENT AUSSI DANS PLAYER
	public var dollars 		: Int;
	public var milk 		: Float;
	public var meat	 		: Float;
	public var iq 	 		: Int;
	public var notoriety 	: Float;
	
	
	public var infoScreen:InfoScreen;
	
	
	//LEVEL CONSTRAINT
	public var levelConstraint :LevelConstraint;
	var ressourceArray : Array<Float>;
	
	
	public function new() 
	{
		super();
		
		placeholderArray = new Array<FlxPoint>();
		
		levelConstraint = new LevelConstraint(1);
		ressourceArray = levelConstraint.createHumanRessource();
		
		FlxNapeSpace.init();
		FlxNapeSpace.createWalls(0,0,1280,860);
		FlxNapeSpace.space.gravity.setxy(0, 400);
		
		dayTimer = new FlxTimer(null);
		dayDuration = 100.0;
		gameTimer = new FlxTimer(null);
		gameDuration = 5.0;
		
		//ressource shown init
		dollars = levelConstraint.moneyPossessed;
		meat = 0.0;
		milk = 0.0;
		iq = 0;
		
		var ressourceBar2 = new RessourceBar(new Rectangle(760, 400, 520, 600),this);
		add(ressourceBar2);
		
		infoScreen = new InfoScreen();
		add(infoScreen);
		
		slaughterhouse = new Area(50, 100, FlxColor.CYAN);
		add(slaughterhouse);
		
		iqhouse = new Area(250, 100, FlxColor.MAGENTA);
		add(iqhouse);
		
		milkhouse = new Area(450, 100, FlxColor.LIME);
		add(milkhouse);
		
		burnhouse = new Area(450, 800-24, FlxColor.RED);
		add(burnhouse);
		
		
		player = new Player(this);
		add(player);
		
		//var nbWave = maxHumainKidnap / 5 ;
		//trace(nbWave);
		
		humanGroup  = new FlxTypedGroup<FlxNapeSprite>();
		add(humanGroup);
		
	}
	
	//LE UPDATE SERA BON POUR UN PETIT REFACTO
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		//Déplace les humains sur le tapis
		for (pl in placeholderArray)
		{
			if (player.currentSpriteGrab == null) 
			{	
				pl.x += 0.5;
			} else 
			{
				pl.x += 1.;
			}
			
		}
		
		//1er solution pour la fin de partie
		/*if (humanGroup.countDead() == maxHumainKidnap  && !isDayFinish)
		{
			isDayFinish = true;
			gameTimer.start(3.0, endGame, 1);
			trace("END DAY");
		}*/
		
		//2eme solution pour la fin de partie
		if (dayTimer.active)
		{
			
			if (gameTimer.finished==true )
			{
				trace("RUSH HOUR ENDS ! GOING BACK TO NORMAL");
				gameTimer.start(gameDuration, spawnHum, 0);
			}
			
			
			
			if (dayTimer.progress > 0.25 && !quarterTime)
			{
				trace("QUARTER TIME");
				quarterTime = true;
				
				//TEST DU RUSH HOUR
				gameTimer.cancel();
				gameTimer.start(1.5, spawnHum, 10);
			}
			
			if (dayTimer.progress > 0.5 && !halfTime)
			{
				trace("HALF TIME");
				halfTime = true;
				
				
				
			}
			
			if (dayTimer.progress > 0.75 && !threeQuarterTime)
			{
				trace("THREE QUARTER TIME");
				threeQuarterTime = true;
			}
			
			if (dayTimer.progress > 0.90 && !endNearTime)
			{
				trace("END NEAR TIME");
				endNearTime = true;
				
				//SECOND RUSH HOUR
				gameTimer.cancel();
				gameTimer.start(1.5, spawnHum, 10);
				
				
			}
			
		}
		
		//LANCE LE JEU
		if (FlxG.keys.anyJustPressed([FlxKey.BACKSPACE]))
		{
			//METHODE DE SPAWN UNITAIRE
			if (waveCount == 0)
			{

				//gameTimer.start(gameDuration, spawnHum, maxHumainKidnap);//VERSION SPAWN NOMBRE LIMITE
				gameTimer.start(gameDuration, spawnHum, 0);//VERSION SPAWN ILIMITE

				waveCount++; // a remplacer
				trace("START GAME!");
				
				//Timer du jour
				dayTimer.start(dayDuration, endGame, 1);
				
			}
		}
		
		//FIN  DE JEU
		if (humanGroup.countDead() == peopleCount && isDayFinish)
		{
			trace("END DAY! ");
			trace("RECAP OF THE DAY !  \r BUTCHERED : " + slaughterhouse.humanCount +"\r IQED : " + iqhouse.humanCount+"\r MILKED : " + milkhouse.humanCount+"\r BURNED : " + burnhouse.humanCount+"\r"); 
			// UN LEGER WAIT AVANT DE SWITCH STATE SERAIT COOL
			FlxG.switchState(new DebriefState());
		}

	}
	
	
	private function endGame(timer:FlxTimer):Void
	{
		gameTimer.cancel();
		isDayFinish = true;
	} 
	
	private function spawnHum(timer:FlxTimer):Void
	{
		trace("SPAWN");
		spawnUnitary();
	} 
	
	public function sendTextToInfoScreen(text:String)
	{
		infoScreen.updateText(text);
	}
	
	public function spawnUnitary():Void
	{
		placeholderArray.push(new FlxPoint(50, 800));
		//var testMovingPlaceholder = new FlxPoint(50, 800);
		
		var human = new Human(50, 800, this, peopleCount,placeholderArray[peopleCount]);
		human.init(ressourceArray[peopleCount], 10, 45.0); // A SETUP
		player.registerPhysSprite(human);
		//human.body.velocity.set(new Vec2(20.0, 0.0));
		humanGroup.add(human);	
		
		peopleCount++;	
	}
	
	
	//public function spawnWave(idWave:Int):Bool
	//{
		//if (idWave != maxWave)
		//{
			//for (i in 1...6)
			//{
				//var human = new Human(i * 50, 800, this, i);
				//
				////ICI INCLURE LE PSEUDO PROCEDURAL
				//
				////human.init(5.5, 10, 45.0);
				//human.init(ressourceArray[peopleCount], 10, 45.0);
				//player.registerPhysSprite(human);
				//humanGroup.add(human);
				//
				//peopleCount++;	
				//
			//}
			//add(humanGroup);
			//return false;
		//}
		//else
		//{
			//return true;
		//}
		//
	//}
	
	
	public function rushHour()
	{
		
	}
	
}