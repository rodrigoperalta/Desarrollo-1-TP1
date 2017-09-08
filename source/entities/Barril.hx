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
		scale.set(1.25, 1.25);
		updateHitbox();
	}
	
	private function fabricarBarril() 
	{

		switch (Reg.imagenAColocar) 
		{
			case 0:
				loadGraphic(AssetPaths.barrilArribaIzquierda__png, true, 4, 4);
			case 1:
				loadGraphic(AssetPaths.barrilArribaMedio__png, true, 4, 4);
			case 2:
				loadGraphic(AssetPaths.barrilArribaDerecha__png, true, 4, 4);
			case 3:
				loadGraphic(AssetPaths.barrilMedioIzquierda__png, true, 4, 4);
			case 4:
				loadGraphic(AssetPaths.barrilMedioMedio__png, true, 4, 4);
			case 5:
				loadGraphic(AssetPaths.barrilMedioDerecha__png, true, 4, 4);
			case 6:
				loadGraphic(AssetPaths.barrilAbajoIzquierda__png, true, 4, 4);
			case 7:
				loadGraphic(AssetPaths.barrilAbajoMedio__png, true, 4, 4);
			case 8:
				loadGraphic(AssetPaths.barrilAbajoDerecha__png, true, 4, 4);
		}
		animation.add("s0", [0]);
		animation.add("s1", [1]);
		animation.add("s2", [2]);
		animation.play("s0");
		
		Reg.imagenAColocar++;
		if (Reg.imagenAColocar == 9)
		Reg.imagenAColocar = 0;
	}
	public function barrilColision()
	{
		if (animation.name == "s2") 
			kill();
		if (animation.name == "s1") 
			animation.play("s2");
		if (animation.name == "s0") 
			animation.play("s1");
	}
	
}