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
	private var barriles:FlxTypedGroup<Barril>;
	private var random:FlxRandom;
	private var test:Int;

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

		barriles = new FlxTypedGroup<Barril>();
		for (j in 0...4)
		{
			for (k in 0...9)
			{
				var barril:Barril = new Barril(Reg.distEntreBarriles * j + Reg.distEntrePartes * Reg.posDeLinea + 20, FlxG.height - 50 + Reg.distEntrePartes * Reg.lineaActual);
				add(barril);
				if (Reg.posDeLinea < 2)
					Reg.posDeLinea++;
				else
				{
					Reg.posDeLinea = 0;
					Reg.lineaActual++;
				}
			}
			add(barriles);
			Reg.posDeLinea = 0;
			Reg.lineaActual = 0;
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
		
		
		if (Reg.cuandoDisparar%70 == 0) 
		{
			enemigos.members[random.int(0, enemigos.members.length)].disparar();
		}
		
		Reg.cuandoDisparar++;
		
		if (Reg.cuandoDisparar == 70)
		{
			Reg.cuandoDisparar = 0;
		}
		

		if (FlxG.keys.justPressed.Q) //Disparo de los enemigos
		{

			enemigos.members[random.int(0, enemigos.members.length)].disparar();
		}

	}
}