package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Barril extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		fabricarBarril();
	}
	
	function fabricarBarril() 
	{
		loadGraphic(AssetPaths.barrilArribaIzquierda__png);
	}
	
}