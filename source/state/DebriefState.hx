package state;

import flash.geom.Rectangle;
import flixel.FlxState;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import neko.vm.Ui;
import ui.TextButton;

/**
 * ...
 * @author ElRyoGrande
 */
class DebriefState extends FlxState 
{
	var playerInfo : Player;
	var gameDayText : FlxText;
	var gameResText : FlxText;
	var addRessourceText : FlxText;
	var DailyText : FlxBitmapText;
	
	//Objectifs ressources :
	var _meatForDay : Int = 75;
	var _iqForDay : Int = 20;
	var _bloodForDay : Int = 40;
	
	public var buttonNextDay : ui.TextButton;	
	
	override public function create():Void
	{
		super.create();
		
		bgColor = 0xFF000000;
		buttonNextDay = new TextButton(new Rectangle(1280 / 2, 750, 48, 36), "NEXT DAY !",1);
		add(buttonNextDay);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	//PETIT TEXTE DE FIN DE JOURNEE
	public function initState(play:Player)
	{
		playerInfo = play;
		
		DailyText = new FlxBitmapText();
		DailyText.multiLine = true;
		DailyText.autoSize = false;
		DailyText.wordWrap = false;
		DailyText.alignment = FlxTextAlign.CENTER;
		DailyText.color = FlxColor.GREEN;
		//textField.text = text; 
		//DailyText.fieldWidth = Std.int(rect.width) - 10;
		//DailyText.x = (rect.width - textField.width) / 2 ;
		//add(textField);
		
		
		DailyText.fieldWidth = 10;
		DailyText.x = 600;
		DailyText.y = 100;
		
		DailyText.text += "NOURRITURE PRODUITE: " + playerInfo._food + "\n"; 
		DailyText.text += "QI PRODUIT : " + playerInfo._iq + "\n";
		DailyText.text += "SANG PRODUIT: " + playerInfo._blood + "\n";
		//DailyText.
		
		
		
		
		
		gameDayText = new FlxText(1280 / 2, 860 / 2, 0, "", 8, true);
		gameResText = new FlxText(1280 / 2, 860/2+100, 0, "", 8, true);
		
		
		addRessourceText = new FlxText(640 + 100 , 410, 0, "", 8, true);
		
		addRessourceText.color = FlxColor.GREEN;
		gameDayText.color = FlxColor.WHITE;
		gameResText.color = FlxColor.GREEN;
		
		gameDayText.text += "STATS DU JOUR N° " + playerInfo._day + "\r"; 
		gameDayText.text += "NOURRITURE PRODUITE: " + playerInfo._food + "\r"; 
		addRessourceText.text += "+ " + playerInfo._food +"\r";  
		gameDayText.text += "QI PRODUIT : " + playerInfo._iq + "\r";
		addRessourceText.text += "+ " + playerInfo._iq +"\r";  
		gameDayText.text += "SANG PRODUIT: " + playerInfo._blood + "\r";
		addRessourceText.text += "+ " + playerInfo._blood +"\r";  
		gameDayText.text += "-----------------------------------------------\r";
		
		
		
		gameDayText.text += "STOCK DE NOURRITURE : " + playerInfo._stockFood + "\r"; 
		gameDayText.text += "STOCK DE QI : " + playerInfo._stockIq + "\r";
		gameDayText.text += "STOCK DE SANG : " + playerInfo._stockBlood + "\r";
		gameDayText.text += "STOCK DE ZOLLARS : " + playerInfo._stockMoney + "\r";
	
		
		gameDayText.text += "-----------------------------------------------\r";
		//Calcul des stocks après usage des ressources :
		playerInfo._stockFood += playerInfo._food;
		playerInfo._stockFood -=  _meatForDay;
		
		playerInfo._stockIq += playerInfo._iq;
		playerInfo._stockIq -=  _iqForDay;
		
		playerInfo._stockBlood += playerInfo._blood;
		playerInfo._stockBlood -=  _bloodForDay;
		
		gameResText.text += "STOCK DE NOURRITURE : " + playerInfo._stockFood + "\r"; 
		gameResText.text += "STOCK DE QI : " + playerInfo._stockIq + "\r";
		gameResText.text += "STOCK DE SANG : " + playerInfo._stockBlood + "\r";
		gameResText.text += "STOCK DE ZOLLARS : " + playerInfo._stockMoney + "\r";
		
		
		
		
		add(gameDayText);
		add(addRessourceText);
		add(DailyText);
		add(gameResText);
	
		
		trace("Nombre de lignes : " + DailyText.numLines);
		trace("LIGNES : " + DailyText.getLineWidth(1));
		
	}
	
}