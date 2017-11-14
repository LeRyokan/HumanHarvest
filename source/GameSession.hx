package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import openfl.Lib;
import openfl.events.Event;

import state.MenuState;
import state.PlayState;

/**
 * ...
 * @author ElRyoGrande
 */
class GameSession extends FlxGame
{
	
	private var _ratio:Float;
	
	inline static private var GAME_WIDTH:Int = 1280;
	inline static private var GAME_HEIGHT:Int = 860;

	

	public function new() 
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		
		var ratioX:Float = stageWidth / GAME_WIDTH;
		var ratioY:Float = stageHeight / GAME_HEIGHT;
		
		_ratio = Math.min(ratioX, ratioY);
		
		var fps:Int = 60;
		
		super(Math.ceil(stageWidth / _ratio), Math.ceil(stageHeight / _ratio), MenuState, _ratio, fps, fps);
		
		
		x = 0.5 * ( stageWidth - GAME_WIDTH * _ratio);
		y = 0.5 * ( stageHeight - GAME_HEIGHT * _ratio);
		//_initialState = PlayState;
	}

	
	
	/**
	 * Override the base onResize function to center and stretch the game to fit the screen.
	 */
	//override public function onResize():Void
	//{
		//// Set the FlxCamera's default zoom to one that will fill the screen but maintain the proper ratio.
		//
		//FlxCamera.defaultZoom = Math.min( Lib.current.stage.stageWidth / FlxG.width, Lib.current.stage.stageHeight / FlxG.height );
		//
		//// Set the main camera to the above default zoom, which is achieved by setting to zero.
		//// Note that this would not work if we used our own camera, or multiple cameras!
		//
		//FlxG.camera.zoom = 0;
		//
		//// Lastly, center the game on the screen.
		//
		//x = ( Lib.current.stage.stageWidth - ( FlxG.width * FlxG.camera.zoom ) ) / 2;
		//y = ( Lib.current.stage.stageHeight - ( FlxG.height * FlxG.camera.zoom ) ) / 2;
		//
		//super.onResize();
//}
	
	
	
	
}