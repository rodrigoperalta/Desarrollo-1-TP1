package states;

import entities.Enemigo;
import entities.Personaje;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
class PlayState extends FlxState
{
	private var pj:Personaje;
	private var enemigos:FlxTypedGroup<Enemigo>;
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = 0x00000000;
		pj = new Personaje(FlxG.width / 2, FlxG.height - 50);
		add(pj);
		enemigos = new FlxTypedGroup<Enemigo>();
		for (i in 0...4)
		{
			var ene:Enemigo = new Enemigo(100*(i+1),190);
			enemigos.add(ene);
		}
		add(enemigos);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

	}

	

}