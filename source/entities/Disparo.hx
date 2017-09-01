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
		makeGraphic(2, 2);
		velocity.y = Reg.velDisparo;
	}
	
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);
		if (y>FlxG.height) 
		destroy();
		
	}
	
	override public function destroy():Void
	{
		FlxG.state.remove(this);
		super.destroy();
	}
	
}