package entities;

import flixel.math.FlxRandom;
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
		loadGraphic(AssetPaths.bandido1__png);
		scale.set(0.5, 0.5);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		movement();
	}
	public function checkWall():Void
	{
		if (x>FlxG.width-width)
		{
			Reg.moveR = false;
			Reg.moveD = true;
		}

		if (x<0+width/2)
		{
			Reg.moveR = true;
			Reg.moveD = true;
		}

	}

	public function goDown():Void
	{
		if (Reg.moveD == true)
		{
			y++;
		}
	}

	private function movement():Void
	{

		if (Reg.moveR == true)
		{
			velocity.x = 40;
			
		}

		if (Reg.moveR == false)
		{
			velocity.x = -40;
			
		}

	}

}