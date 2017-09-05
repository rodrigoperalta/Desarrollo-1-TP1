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
	//private var barr:Barril;
	//var distEntreBarriles:Int;
	//var distEntrePartes:Int;
	//var posDeLinea:Int;
	//var lineaActual:Int;
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
		
		var distEntreBarriles:Int = 30;
		var distEntrePartes:Int = 5;
		var posDeLinea:Int = 0;
		var lineaActual:Int = 0;
		for (j in 0...4) 
		{
			for (k in 0...9) 
			{
				var barril:Barril = new Barril(distEntreBarriles * (j + 1) + distEntrePartes * posDeLinea, FlxG.height - 50 + distEntrePartes * lineaActual);
				add(barril);
				if (posDeLinea < 2)
					posDeLinea++;
				else
				{
					posDeLinea = 0;
					lineaActual++;
				}
			}
			posDeLinea = 0;
			lineaActual = 0;
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