package entities;


import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;


/**
 * ...
 * @author Rodrigo
 */
class Disparo extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.bala__png, true, 2 ,4);
		animation.add("shoot", [0, 1], 6, true);
		animation.play("shoot");
		
		
		
		kill();
	}
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (y<0 || y>FlxG.height) 
			kill();
	}
}