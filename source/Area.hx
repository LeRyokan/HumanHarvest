package;

import enums.AreaType;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Area extends FlxSprite
{
	// Compte d'humain arrivé dans la zone
	public var humanCount	: Int = 0;
	
	// Type de la zone (boucherie, benne à ordures, etc)
	public var _areaType 	: enums.AreaType;
	private var imgAdress : String;
	
	public function new(?X:Float=0, ?Y:Float=0, areaType:enums.AreaType/*, color:FlxColor*/)
	{
		super(X, Y);
		_areaType = areaType;

		var color:FlxColor;
		imgAdress = "assets/images/";
		switch (_areaType)
		{
			case BURNHOUSE:
				color = FlxColor.RED;
				
				//reduction de la hitbox de la burnhouse
				width = width / 2;
				offset.x = width / 2;
				imgAdress += "bucher.png";
			case IQ :
				imgAdress += "brainwash.png";
				color = FlxColor.MAGENTA;
			case SLAUGHTERHOUSE:
				imgAdress += "abattoir.png";
				color = FlxColor.CYAN;
			case MILK:
				imgAdress += "bucher.png";
				color = FlxColor.LIME;
			default:
		}
		loadGraphic(imgAdress, false, 160, 100, false);
		//makeGraphic(64, 48, color, false);
	}
}