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
	private var disparoConArmaDerecha:Bool = true;
	private var vidas(get, null) = 5;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		bala = new Disparo();
		loadGraphic(AssetPaths.personaje__png);
		scale.set(0.6, 0.6);
		updateHitbox();
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
		if (FlxG.keys.justPressed.SPACE && !bala.alive)
		{
			if (disparoConArmaDerecha)
			{
				bala.reset(this.x + 10, this.y + 5);
				disparoConArmaDerecha = false;
			}
			else if (!disparoConArmaDerecha)
			{
				bala.reset(this.x, this.y + 5);
				disparoConArmaDerecha = true;
			}

			bala.velocity.y = Reg.velDisparo;
		}

	}

	function get_bala():Disparo
	{
		return bala;
	}

	public function perderVidas()
	{
		vidas--;
	}

	public function get_vidas()
	{
		return vidas;
	}

}