package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author Rodrigo
 */
class Personaje extends FlxSprite
{
	public var bala:Disparo;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(20, 20);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		movement();
		checkBoundaries();
		disparar();
	}

	private function movement():Void
	{
		velocity.x = 0;

		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x = 200;
		}

		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x = -200;
		}
	}

	private function checkBoundaries():Void
	{
		if (x>FlxG.width-width)
		{
			x = FlxG.width - width;
		}
		if (x<FlxG.width - FlxG.width)
		{
			x = FlxG.width - FlxG.width;
		}
	}
	
	private function disparar():Void
	{
		if (FlxG.keys.justPressed.SPACE) 
		{
			bala = new Disparo();
			FlxG.state.add(bala);
			bala.x = this.x + 9;
			bala.y = this.y;	
			
		}
	}
	
	
	
	
}