package;

import flixel.addons.text.FlxTypeText;
import flixel.system.FlxAssets.FlxShader;

/**
 * ...
 * @author ElRyoGrande
 */
class ShadedText extends FlxTypeText 
{
	
	public var useShader(default, set):Bool = false;
	private var _shader:FlxShader;

	public function new(X:Float, Y:Float, Width:Int, Text:String, Size:Int=8, EmbeddedFont:Bool=true) 
	{
		super(X, Y, Width, Text, Size, EmbeddedFont);
		
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