package states;

import entities.Barril;
import entities.Enemigo;
import entities.Personaje;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
class PlayState extends FlxState
{
	private var pj:Personaje;
	private var enemigos:FlxTypedGroup<Enemigo>;
	private var barril:Barril;
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = 0x00000000;
		pj = new Personaje(FlxG.width / 2, FlxG.height - 25);
		add(pj);
		enemigos = new FlxTypedGroup<Enemigo>();
		for (i in 0...11)
		{
			for (j in 0...5)
			{
				var ene:Enemigo = new Enemigo(0.05 + (11 * (i + 1)), (11 * (j + 4)) - 20);

				enemigos.add(ene);
			}
		add(enemigos);
		}
		for (j in 0...4) 
		{
			
		}
		

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
		
		if (FlxG.overlap(pj.bala, enemigos))
		{
			pj.bala.kill();
		}
		super.update(elapsed);
	}

}