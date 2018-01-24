package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxAssets.FlxShader;

/**
 * ...
 * @author ElRyoGrande
 */
class ShadedSprite extends FlxSprite 
{

	public var useShader(default, set):Bool = false;
	private var _shader:FlxShader;

	public function new(?X:Float = 0, ?Y:Float = 0, ?img:String) 
	{
		super(X, Y);
		if (img != null)
		{
			loadGraphic(img);
		}
		
		
		
		//loadGraphic("assets/images/monitorBckground.png");
		
	}
	
	public function init(UseShader:Bool = false, ?Shader:FlxShader)
	{
		if (Shader != null)
		{
			_shader = Shader;
		}
		
		useShader = UseShader;
	}
	
	private function set_useShader(Value:Bool):Bool
	{
		if (Value)
		{
			shader = _shader;
		}
		else
		{
			shader = null;
		}
		
		return useShader = Value;
}
	
}