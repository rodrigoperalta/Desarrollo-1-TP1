package states;

import entities.Barril;
import entities.Enemigo;
import entities.Personaje;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRandom;

class PlayState extends FlxState
{
	private var pj:Personaje;
	private var enemigos:FlxTypedGroup<Enemigo>;
	private var random:FlxRandom;
	private var test:Int;

	//private var barr:Barril;
	//var distEntreBarriles:Int;
	//var distEntrePartes:Int;
	//var posDeLinea:Int;
	//var lineaActual:Int;
	override public function create():Void
	{
		super.create();
		FlxG.camera.bgColor = 0x00000000;
		random = new FlxRandom();
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
		super.update(elapsed);

		var moverRPrevio:Bool = Reg.moveR; //Guarda la posicion anterior
		for (i in 0...enemigos.members.length) //Checkea si el enemigo toca las paredes
		{
			enemigos.members[i].checkWall();

		}
		if (moverRPrevio != Reg.moveR) //Si se toca una pared, bajan los enemigos
		{
			for (i in 0...enemigos.members.length)
			{
				enemigos.members[i].goDown();
			}
			Reg.moveD = false;
		}

		for (i in 0...enemigos.members.length) //Colision Balas-Enemigos
		{

			if (FlxG.overlap(pj.bala, enemigos.members[i]))
			{
				pj.bala.kill();
				enemigos.remove(enemigos.members[i], true);

			}
		}

		for (i in 0...enemigos.members.length) //Colision Pj-Enemigos
		{

			if (FlxG.overlap(pj, enemigos.members[i]))
			{
				pj.kill();

			}
		}

		for (i in 0...enemigos.members.length) //Colision Pj-Balas Enemigos
		{

			if (FlxG.overlap(pj,enemigos.members[i].balaEne ))
			{
				pj.kill();

			}
		}

		if (FlxG.keys.justPressed.Q) //Disparo de los enemigos
		{

			enemigos.members[random.int(0, enemigos.members.length)].disparar();
		}

	}
}