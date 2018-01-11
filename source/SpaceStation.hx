package;

import enums.Levels;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.nape.FlxNapeSprite;
import flixel.addons.nape.FlxNapeVelocity;
import flixel.addons.nape.FlxNapeSpace;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import nape.geom.Vec2;
import openfl.geom.Rectangle;
import shaders.CRT;
import ui.InfoScreen;
import state.DebriefState;
import enums.AreaType;
import flixel.FlxCamera;
import ui.TextButton;

/**
 * ...
 * @author ElRyoGrande
 */
class SpaceStation extends FlxGroup 
{
	////////////////////////////////////////
	//A MIGRER PLUS TARD DANS GAME SESSION//
	public var currentLevel : Levels; //VA DISPARAITRE
	public var _indexCurrentLevel : Int;
	
	//VARIABLE POUR LA GESTION DE LA SAVE
	public var _saveName: String;
	public var _save : FlxSave;
	
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
	
	var maxHumainKidnap: Int = 100;  //A INIT VIA LE XML DU LEVEL
	var maxWave:Int = 50;
	var waveCount: Int = 0;
	var canSpawnNewWave : Bool = true;
	var peopleCount : Int = 0 ;
	var peoplePlaced : Int = 0;
	///////////////////////////////////////
	
	var placeholderArray : Array<FlxPoint>;
	
	
	//Les entités du jeu
	public var player : Player;
	public var humanGroup : FlxTypedGroup<FlxSprite>;
	
	//public var aliveHumanLeft : Int = 2;
	
	//AREA : A regrouper maybe en FINAL ZONE AREA
	public var slaughterhouse : Area;
	public var iqhouse : Area;
	public var milkhouse : Area;
	public var burnhouse: Area;
	
	public var infoScreen:InfoScreen;
	
	//LEVEL CONSTRAINT
	public var levelConstraint :LevelConstraint;
	var ressourceArray : Array<Float>;
	
	
	//TEST DE GAMEPLAY
	//Compte d'humain perdu car non préparé
	public var lostHuman : Int = 0;
	
	public var hookMode : Bool = true;
	public var stampMode : Bool = false;
	
	
	//#if shaders_supported
	//
	//public static var useShaders:Bool = false;
	//
	//
	//private var _shaderButton : FlxButton;
	//
	//private var crt = new CRT();
	//
	//private var timer : FlxTimer;
	//
	//#end
	
	
	
	public function new(indexCurrentLevel:Int,saveName:String) 
	{
		super();
		//currentLevel = level;
		_save = new FlxSave();
		_save.bind(saveName);
		_indexCurrentLevel = indexCurrentLevel;
		trace("NIVEAU RETENU DANS LA SAVE : " + _save.data.level);
		trace("NIVEAU ACTUEL : " + _indexCurrentLevel);
		placeholderArray = new Array<FlxPoint>();
		
		//A REVOIR
		levelConstraint = new LevelConstraint(1);
		ressourceArray = levelConstraint.createHumanRessource();
		
		//FlxNapeSpace.init();
		//FlxNapeSpace.createWalls(0,0,1280,860);
		//FlxNapeSpace.space.gravity.setxy(0, 400);
		
		player = new Player(this);
		add(player);
		
		dayTimer = new FlxTimer(null);
		dayDuration = 10.0;
		gameTimer = new FlxTimer(null);
		gameDuration = 4.0;
		
		///////////////////////////////////
		infoScreen = new InfoScreen();
		//infoScreen.init(useShaders,crt);
		add(infoScreen);
		
		
		
		
		
		// Caméra pour le HUD (on sait pas trop comment, mais ça marche)
		var infoScreenCam = new FlxCamera(FlxG.width - infoScreen._width, FlxG.height - infoScreen._height, infoScreen._width, infoScreen._height, 1);
		infoScreenCam.zoom = 1;
		infoScreenCam.bgColor = FlxColor.PINK;
		infoScreenCam.follow(infoScreen._backgroundSprite, NO_DEAD_ZONE);
		FlxG.cameras.add(infoScreenCam);
		///////////////////////////////////
		
		//#if shaders_supported
		//
		//timer = new FlxTimer();
		//timer.start(0);
		//
		//
		//_shaderButton = new FlxButton(300, 10, "Shaders: Off", onShaderToggle);
		//add(_shaderButton);
		//
		////_testerShader = new ShadedChar(200, 60);
		////_testerShader.init(useShaders, crt);
		////add(_testerShader);
		//
		//#end

		//var ressourceBar2 = new RessourceBar(new Rectangle(760, 400, 520, 600), this);
		//add(ressourceBar2);
		
		slaughterhouse = new Area(1120, 50, enums.AreaType.SLAUGHTERHOUSE);

		add(slaughterhouse);
		
		iqhouse = new Area(250, 700, enums.AreaType.IQ);
		add(iqhouse);
		
		milkhouse = new Area(450, 700, enums.AreaType.MILK);
		add(milkhouse);
		
		burnhouse = new Area(450, 700, enums.AreaType.BURNHOUSE);
		add(burnhouse);
		
		//decor
		var tunnelSprite = new FlxSprite(0, 80);
		tunnelSprite.loadGraphic("assets/images/tun.png", true, 1120, 80, true);
		add(tunnelSprite);
		
		humanGroup  = new FlxTypedGroup<FlxSprite>();
		add(humanGroup);
		
		FlxG.camera.fade(FlxColor.BLACK, .1, true);
		infoScreenCam.fade(FlxColor.BLACK, .1, true);
	}
	
	//LE UPDATE SERA BON POUR UN PETIT REFACTO
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
		infoScreen.updateResources(player);
		
		//#if shaders_supported
		//crt.time += timer.elapsedTime;
//
		//#end
		
		//INPUT SECTION
		if (FlxG.keys.justPressed.A)
		{
			trace("HOOK MODE");
			hookMode = true;
			stampMode = false;
		}
		
		if (FlxG.keys.justPressed.Z)
		{
			trace("STAMP MODE");
			hookMode = false;
			stampMode = true;
		}
		
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
				spawnUnitary();
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
			
			//POUR LE GAMEPLAY COMPARATEUR DU SCORE
			CheckObjectiv();
			
			
			
			// UN LEGER WAIT AVANT DE SWITCH STATE SERAIT COOL
			
			// ON FAIS LA SAUVEGARDE ICI
			trace("LEVEL SAVE : " + _indexCurrentLevel);
			_save.data.level = _indexCurrentLevel;
			_save.data.food = player._food;
			_save.flush();
			
			var nextState = new DebriefState(_indexCurrentLevel);
			nextState.initState(this.player);
			FlxG.switchState(nextState);
		}

		
		//Changement de la résolution
			if (FlxG.keys.anyJustPressed([F]))
			{
				
				//trace("X : " + Capabilities.screenResolutionX);
				//trace("Y : " + Capabilities.screenResolutionY);
				trace("fullscreen");
				FlxG.fullscreen == !FlxG.fullscreen;
				
				
				//DU BORDEL QUI SERT PAS
				//FlxG.resizeGame(Std.int(Capabilities.screenResolutionX), Std.int(Capabilities.screenResolutionY));
				//FlxG.resizeWindow(Std.int(Capabilities.screenResolutionX), Std.int(Capabilities.screenResolutionY));
				//FlxG.
				//flixel.FlxCamera.defaultZoom = 1;
				//FlxG.cameras.reset();
				//FlxG.camera.setSize(Std.int(Capabilities.screenResolutionX), Std.int(Capabilities.screenResolutionY));
			}
			
		//DEBUG
		if (FlxG.keys.pressed.SHIFT)
		{
			// Reset du niveau
			if (FlxG.keys.justPressed.R)
			{
				FlxG.resetState();
			}
			
			// Ajout de bouffe
			if (FlxG.keys.pressed.Q) 
			{
				player._food += FlxG.mouse.wheel * 5;
			}
			
			// Ajout d'argent
			if (FlxG.keys.pressed.S) 
			{
				player._money += FlxG.mouse.wheel * 5;
			}
			
			// Ajout d'iq
			if (FlxG.keys.pressed.D) 
			{
				player._iq += FlxG.mouse.wheel * 5;
			}
			
			// Ajout de sang
			if (FlxG.keys.pressed.F) 
			{
				player._blood += FlxG.mouse.wheel * 5;
			}
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
	
	public function spawnUnitary():Void
	{
		var pos = new FlxPoint(50, 100);
		var human = new Human(50, 100, this, peopleCount,pos);
		human.init(ressourceArray[peopleCount], 10, 45.0); // A SETUP
		player.registerPhysSprite(human);
		
		humanGroup.add(human);	
		peopleCount++;	
	}
	
	public function sendTextToInfoScreen(human:Human)
	{
		infoScreen.updateHuman(human);
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
	
	
	public function CheckObjectiv()
	{
		
	}
	
	//#if shaders_supported
	//private function onShaderToggle():Void
	//{
		//useShaders = !useShaders;
		//toggleHelper(_shaderButton, "Shaders: Off", "Shaders: On");
		//
		//infoScreen._backgroundSprite.useShader = useShaders;
		//
		//// Update the bunnies
		////for (bunny in _bunnies)
		////{
			////if (bunny != null)
			////{
				////bunny.useShader = useShaders;
			////}
		////}
	//}
	//#end
	//
	//private function toggleHelper(Button:FlxButton, Text1:String, Text2:String):Void
	//{
		//if (Button.label.text == Text1)
		//{
			//Button.label.text = Text2;
		//}
		//else 
		//{
			//Button.label.text = Text1;
		//}
//}
	
	
}