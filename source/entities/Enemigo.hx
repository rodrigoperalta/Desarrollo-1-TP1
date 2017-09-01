package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author Rodrigo
 */
class Enemigo extends FlxSprite
{
	public var moveR:Bool = true;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(20, 20);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		movement();

	}

	private function movement():Void
	{
		
		if (x==FlxG.width-width) 
		{
			moveR = false;
		}
		
		if (x==0+width) 
		{
			moveR = true;
		}
		
		
		if (moveR == true) 
		{
			x++;
		}
		
		if (moveR == false) 
		{
			x--;
		}
		
		
		
		
	
	
		

	}
	
	/*private function checkBoundaries():Void
	{
		
		
	}*/
}