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
	public var bala(get, null):Disparo;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		bala = new Disparo();
		makeGraphic(4, 4);
		FlxG.state.add(bala);

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
			velocity.x = 100;
		}

		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x = -100;
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
			if (!bala.alive)
			{
				bala.reset(this.x + 1, this.y);
			}

		}
	}
	
	function get_bala():Disparo 
	{
		return bala;
	}
	
	

}