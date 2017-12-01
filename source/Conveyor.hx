package;
import flixel.FlxSprite;

/**
 * ...
 * @author ElRyoGrande
 */
class Conveyor extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		this.loadGraphic("assets/images/Tunnel1.png", true, 320, 80, true);
		this.animation.add("idle", [0], 30, true, false, false);
		this.animation.play("idle");
	}
	
}