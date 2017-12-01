package;

import flixel.FlxG;
import haxe.xml.Fast;
import lime.project.Haxelib;
import openfl.Assets;
/**
 * ...
 * @author ElRyoGrande
 */
class LevelConstraint 
{

	public var moneyPossessed : Int;
	public var peopleCatch : Int;
	public var meatToProduce : Float;
	public var iqToProduce : Int;
	public var milkToProduce : Float;
	
	//C'EST LUI QUI DEVRAIT GENERER TOUS LES HUMANS PROFILES

	var _actualLevel : Int;
	
	public function new(actualLevel:Int) 
	{
		//READ INFO FOR THE LEVEL
		_actualLevel = actualLevel;
		var xml = Xml.parse(Assets.getText("assets/data/level1.xml"));
	
		//var fast = new Fast(xml.firstElement());
		var fast = new Fast(xml);
		var n = fast.node.levels;
	
		//trace ("ACTUAL LEVEL " + _actualLevel);
		for (level in n.nodes.level)
		{
			if (Std.parseInt(level.att.id) == _actualLevel)
			{
				var money = level.node.money;
				var meatValue = level.node.meat;
				var iqValue = level.node.iq;
				var milkValue = level.node.milk;
				var peopleMax = level.node.people;
			
				moneyPossessed = Std.parseInt(money.innerData);
				
				//trace("PEOPLE MAX: "  + peopleMax.innerData);
				peopleCatch = Std.parseInt(peopleMax.innerData);
				//trace("ELEMENTS  MEAT: "  + meatValue.innerData);
				meatToProduce = Std.parseFloat(meatValue.innerData);
				//trace("ELEMENTS  IQ: "  + iqValue.innerData);
				iqToProduce =  Std.parseInt(iqValue.innerData);
				//trace("ELEMENTS  MILK: "  + milkValue.innerData);
				milkToProduce =  Std.parseFloat(milkValue.innerData);
			}
		}
		
		
		
	
		
		
	}
	
	public function createHumanRessource():Array<Float>
	{
		
		var ressourceArray = new Array<Float>();
		
		
		//RESSOURCE REPARTITION
		var percentage = meatToProduce / 100 ;
		var totalMeat = (percentage * 45) + meatToProduce;
		var moyenne = totalMeat / peopleCatch;
		
		var percentageOfMoy = moyenne / 100;
		
		var totalMeatProducable  = 0.0;
		
		for (i in 0...peopleCatch)
		{
			var randomizer = FlxG.random.int( -50, 50);
			var result = (percentageOfMoy * randomizer) + moyenne;
			//trace("PERSO " + i + ": " + result);
			totalMeatProducable += result;
			ressourceArray.push(result);
		}
		
		//trace("TOTAL MEAT PRODUCABLE : " + totalMeatProducable);
		return ressourceArray;
	}
	
	
}