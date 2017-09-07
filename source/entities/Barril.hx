package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Barril extends FlxSprite 
{
	var creadorDelBarril:Array<FlxSprite>;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		fabricarBarril();
		scale.set(0.6, 0.6);
		updateHitbox();
	}
	
	private function fabricarBarril() 
	{

		switch (Reg.imagenAColocar) 
		{
			case 0:
				loadGraphic(AssetPaths.barrilArribaIzquierda__png);
			case 1:
				loadGraphic(AssetPaths.barrilArribaMedio__png);
			case 2:
				loadGraphic(AssetPaths.barrilArribaDerecha__png);
			case 3:
				loadGraphic(AssetPaths.barrilMedioIzquierda__png);
			case 4:
				loadGraphic(AssetPaths.barrilMedioMedio__png);
			case 5:
				loadGraphic(AssetPaths.barrilMedioDerecha__png);
			case 6:
				loadGraphic(AssetPaths.barrilAbajoIzquierda__png);
			case 7:
				loadGraphic(AssetPaths.barrilAbajoMedio__png);
			case 8:
				loadGraphic(AssetPaths.barrilAbajoDerecha__png);
			default:
				
		}
		Reg.imagenAColocar++;
		if (Reg.imagenAColocar == 9)
		Reg.imagenAColocar = 0;
	}
	
}