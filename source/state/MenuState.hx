package state;

import enums.GameMode;
import enums.Levels;
import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxAxes;
import flixel.util.FlxTimer;
import shaders.CRT;

class MenuState extends FlxState 
{
	private var _title					: FlxText;
	private var _alphaModifier 			: Float;
	private var _startDisplay 			: FlxText;
	private var _credit 				: FlxText;
	private var _moreCredit 			: FlxText;
	
	
	
	//Shader testing 
	
	
	//#if shaders_supported
	//
	//public static var useShaders:Bool = false;
	//
	//private var _testerShader : ShadedChar;
	//
	//private var _shaderButton : FlxButton;
	//
	//private var crt = new CRT();
	//
	//private var timer : FlxTimer;
	//
	//#end
	
	
	override public function create():Void
	{
		bgColor = 0xFF000000;
		
		_title = new FlxText(0, 0, 0, "Human Harvest", 64, true);
		_title.screenCenter();
		_title.y -= 100;
		add(_title);
		
		_startDisplay = new FlxText(0, 0, 0, "Click or press SPACE to start", 18, true);
		_startDisplay.screenCenter();
		add(_startDisplay);

		_credit = new FlxText(0, 0, 0, "A stupid game by Lucas Tixier, Guillaume Ambrois & Thomas Fantino", 12, true);
		_credit.screenCenter(FlxAxes.X);
		_credit.y = FlxG.height - 150;
		add(_credit);

		_moreCredit = new FlxText(0, 0, 0, "                           Twitter : \n@LucasTixier - @Eponopono - @fanti_fantino", 12, true);
		_moreCredit.screenCenter(FlxAxes.X);
		_moreCredit.y = _credit.y + 50;
		add(_moreCredit);

		
		//#if shaders_supported
		//
		//timer = new FlxTimer();
		//timer.start(0);
		//
		//
		//_shaderButton = new FlxButton(100, 60, "Shaders: Off", onShaderToggle);
		//add(_shaderButton);
		//
		//_testerShader = new ShadedChar(200, 60);
		//_testerShader.init(useShaders, crt);
		//add(_testerShader);
		//
		//#end
		
		FlxG.mouse.visible = true;
		
		_alphaModifier = 0;
		
		FlxG.camera.fade(FlxColor.BLACK, .2, true);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		blink();
		
		//#if shaders_supported
		//crt.time += timer.elapsedTime;
		//
		//#end
		//
		
		//NEW GAME
		//FlxG.mouse.justPressed
		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.camera.fade(FlxColor.BLACK, .1, false, function() {
				FlxG.switchState(new PlayState(GameMode.NEW));
			});
		}
		
		// LOADED GAME
		if (FlxG.keys.justPressed.L)
		{
			FlxG.camera.fade(FlxColor.BLACK, .1, false, function() {
				FlxG.switchState(new PlayState(GameMode.LOAD));
			});
			
			
			//FlxG.switchState(new TestState());
		}
		// Test de Guigui
		if (FlxG.keys.justPressed.G)
		{
			FlxG.switchState(new TestGuillaumeState());
		}
	}
	
	//#if shaders_supported
	//private function onShaderToggle():Void
	//{
		//useShaders = !useShaders;
		//toggleHelper(_shaderButton, "Shaders: Off", "Shaders: On");
		//
		//_testerShader.useShader = useShaders;
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
	
	/**
	 * Fonction faisant blinker le titre en modifiant son alpha
	 */
	public function blink()
	{
		var currentAlpha : Float;

		if (_startDisplay.alpha == 1)
		{
			_alphaModifier = -0.02;
		}

		if (_startDisplay.alpha == 0)
		{
			_alphaModifier = 0.02;
		}

		currentAlpha = _startDisplay.alpha;
		_startDisplay.alpha = currentAlpha + _alphaModifier;
	}
}