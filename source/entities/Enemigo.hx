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
		velocity.x = 100;
		if (x>FlxG.width-width)
		{
			velocity.x = -100;
		}
		
		if (x < FlxG.width - FlxG.width)
		{
		velocity.x = 100;
		
		}
		
		if (x == FlxG.width - width)
		{
		y++;
		
		}
					
	
		

	}
	
	/*private function checkBoundaries():Void
	{
		
		
	}*/
}