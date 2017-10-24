package;

import flixel.FlxG;
import flixel.addons.nape.FlxNapeSpace;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import openfl.geom.Rectangle;

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
	var gameDuration : Float;
	public var isEndFinish :Bool = false;
	
	var maxHumainKidnap: Int = 25;  //NON USED
	var maxWave:Int = 2;
	var waveCount: Int = 0;
	var canSpawnNewWave : Bool = true;
	///////////////////////////////////////
	
	
	//Les entités du jeu
	public var player : Player;
	public var humanGroup : FlxGroup;
	public var aliveHumanLeft : Int = 2;
	
	//AREA : A regrouper maybe en FINAL ZONE AREA
	public var slaughterhouse : Area;
	public var iqhouse : Area;
	public var milkhouse : Area;
	
	
	//LOGIC RESSOURCES ACTUELLEMENT AUSSI DANS PLAYER
	public var dollars 		: Int;
	public var milk 		: Float;
	public var meat	 		: Float;
	public var iq 	 		: Int;
	public var notoriety 	: Float;
	
	
	public var infoScreen:InfoScreen;
	
	
	
	
	public function new() 
	{
		super();
		
		FlxNapeSpace.init();
		FlxNapeSpace.createWalls(0,0,1280,860);
		FlxNapeSpace.space.gravity.setxy(0, 400);
		
		gameTimer = new FlxTimer(null);
		gameDuration = 20.0;
		
		//ressource init
		meat = 0.0;
		milk = 0.0;
		iq = 0;
		
		//var ressourceBar = new RessourceBar(new Rectangle(0, 0, 1280, 300),this);
		var ressourceBar2 = new RessourceBar(new Rectangle(760, 400, 520, 600),this);
		//add(ressourceBar);
		add(ressourceBar2);
		
		infoScreen = new InfoScreen();
		add(infoScreen);
		
		slaughterhouse = new Area(50, 100, FlxColor.CYAN);
		add(slaughterhouse);
		
		iqhouse = new Area(250, 100, FlxColor.MAGENTA);
		add(iqhouse);
		
		milkhouse = new Area(450, 100, FlxColor.LIME);
		add(milkhouse);
		
		
		player = new Player(this);
		add(player);
		
		var nbWave = maxHumainKidnap / 5 ;
		trace(nbWave);
		
		humanGroup  = new FlxGroup();
		
		
		
		
		
	}
	
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (humanGroup.countLiving() == aliveHumanLeft) //VALEUR MODIFIABLE
		{
			humanGroup.clear();
		}
		
		
		if (FlxG.keys.anyJustPressed([FlxKey.BACKSPACE]))
		{
			if (waveCount == 0)
			{
				gameTimer.start(gameDuration, endGame, 1);
				trace("START GAME!");
			}
			
			
			//trace("GROUPE NUMBER : " + humanGroup.length);
			if (humanGroup.length == 0)
			{
				canSpawnNewWave = true;
			}
			
			if (canSpawnNewWave)
			{
				if (!spawnWave(waveCount))
				{
					trace("SPAWN DE LA WAVE : " + waveCount);
					waveCount++;
					canSpawnNewWave = false;
				}
				else
				{
					trace("FIN DU NOMBRE D'HUMAIN ! DONC FIN DU JOUR");
					isEndFinish = true;
				}
			}
		}
	}
	
	
	private function endGame(timer:FlxTimer):Void
	{
		trace("END GAME!");
		
	}
	
	public function sendTextToInfoScreen(text:String)
	{
		infoScreen.updateText(text);
	}
	
	public function spawnWave(idWave:Int):Bool
	{
		if (idWave != maxWave)
		{
			for (i in 1...6)
			{
				var human = new Human(i * 50, 800, this, i);
				
				//ICI INCLURE LE PSEUDO PROCEDURAL
				human.init(5.5, 10, 45.0);
				player.registerPhysSprite(human);
				humanGroup.add(human);
			}
			add(humanGroup);
			return false;
		}
		else
		{
			return true;
		}
		
	}
	
}