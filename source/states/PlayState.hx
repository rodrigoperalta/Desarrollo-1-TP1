package states;

import entities.Aborigen;
import entities.Barril;
import entities.Enemigo;
import entities.Personaje;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRandom;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	private var pj:Personaje;
	private var enemigos:FlxTypedGroup<Enemigo>;
	private var barriles:FlxTypedGroup<Barril>;
	private var random:FlxRandom;
	private var test:Int;
	private var puntaje:FlxText;
	private var abo:Aborigen;

	override public function create():Void
	{
		super.create();
		puntaje = new FlxText(FlxG.width * 3 / 4, FlxG.height - 12, 0, "Score " + Reg.puntaje, 8,true);
		puntaje.font = AssetPaths.kenpixel_mini__ttf;
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
				var barril:Barril = new Barril(Reg.distEntreBarriles * j + Reg.distEntrePartes * Reg.posDeLinea + 20, //X
											   FlxG.height - 50 + Reg.distEntrePartes * Reg.lineaActual);			  //Y
				barriles.add(barril);
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
		abo = new Aborigen();
		add(abo);
		add(puntaje);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);


puntaje.text = "Score " + Reg.puntaje;
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
				Reg.puntaje +=  10;

			}
		}
		trace(Reg.puntaje);
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
				enemigos.members[i].balaEne.kill();
				pj.kill();
				pj.perderVidas();
				if (pj.get_vidas() > 0)
				{
					pj.reset(FlxG.width / 2, FlxG.height - 25);
				}

			}
		}

		trace(pj.get_vidas());

		//Disparo de los enemigo
		Reg.cuandoDisparo++;
		if (Reg.cuandoDisparo%70 == 0)
		{
			enemigos.members[random.int(0, enemigos.members.length - 1)].disparar();
		}

		if (Reg.cuandoDisparo == 70)
		{
			Reg.cuandoDisparo = 0;
		}

		if (FlxG.keys.justPressed.Q)
		{
			enemigos.members[random.int(0, enemigos.members.length)].disparar();
		}
		//Colision Balas-Barriles
		for (i in 0...barriles.members.length)
		{
			if (FlxG.overlap(pj.bala, barriles.members[i]))
			{
				pj.bala.kill();
				barriles.members[i].barrilColision();
			}
		}
		//Colision Balas-Barriles
		for (j in 0...enemigos.members.length)
		{
			for (i in 0...barriles.members.length)
			{
				if (FlxG.overlap(enemigos.members[j].balaEne, barriles.members[i]))
				{
					enemigos.members[j].balaEne.kill();
					barriles.members[i].barrilColision();
				}
			}
		}
//Colision Balas-Aborigen
		if (FlxG.overlap(pj.bala, abo))
		{
			pj.bala.kill();
			abo.kill();
			var r = new FlxRandom();
			var num:Int = r.int(0, 5);
			Reg.puntaje += (num + 1) * 50;
		}
		abo.revivir();
		Reg.timer += elapsed;
		if (Reg.timer > 10)
		{
			Reg.timer = 0;
		}
	}

}