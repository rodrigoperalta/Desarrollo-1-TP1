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
		pj = new Personaje(FlxG.width / 2, FlxG.height - 10);
		add(pj);
		enemigos = new FlxTypedGroup<Enemigo>();
		for (i in 0...4)
		{
			var ene:Enemigo = new Enemigo(10*(i+1),19);
			enemigos.add(ene);
		}
		add(enemigos);

	}

	override public function update(elapsed:Float):Void
	{
		var moverRPrevio:Bool = Reg.moveR;
		for (i in 0...enemigos.length)
		{
			enemigos.members[i].checkWall();

		}
		if (moverRPrevio != Reg.moveR)
		{
			for (i in 0...enemigos.length)
			{
				enemigos.members[i].goDown();
			}			
			Reg.moveD = false;
		}

		super.update(elapsed);

	}

}