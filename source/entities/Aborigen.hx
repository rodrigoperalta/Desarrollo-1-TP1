package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxRandom;

/**
 * ...
 * @author ...
 */
class Aborigen extends FlxSprite 
{
	public var movIzqADer:Bool = true;
	private var randomTime:FlxRandom;
	private var randomNum:Int;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.aborigen__png, true, 28, 28);
		animation.add("move", [0, 1], 6, true);
		animation.play("move");
		scale.set(0.5, 0.5);
		updateHitbox();
		
		randomTime = new FlxRandom();
		randomNum = randomTime.int(3, 5);
		
		kill();
	}
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);
		

		revivir();
		movement();
		checkBorders();
	}
	
	public function revivir() 
	{
		if (movIzqADer && !alive && Reg.timer > 3+randomNum)
		{
			this.reset( -28, 0);
		}
		if (!movIzqADer && !alive && Reg.timer > 3+randomNum)
		{
			this.reset( 154, 0);
		}
	}
	
	private function checkBorders() 
	{
		if (this.x > 155)
			kill();
		if (this.x < -29) 
			kill();
	}
	
	private function movement()
	{
		if (movIzqADer) 
		{
			velocity.x = Reg.velAborigen;
			if (this.x >= 155) 
			{
				flipX = true;
				movIzqADer = false;
			}
		}
		else if (!movIzqADer) 
		{
			velocity.x = -(Reg.velAborigen);
			if (this.x <= -29)
			{
				flipX = false;
				movIzqADer = true;
			}
		}
	}
}