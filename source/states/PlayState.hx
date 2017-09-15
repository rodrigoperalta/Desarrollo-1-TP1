package states;

import entities.Barril;
import entities.Enemigo;
import entities.Disparo;
import entities.Personaje;
import entities.Aborigen;
import entities.Vidas;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRandom;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	private var pj:Personaje;
	private var abo:Aborigen;
	private var enemigos:FlxTypedGroup<Enemigo>;
	private var barriles:FlxTypedGroup<Barril>;
	private var random:FlxRandom;
	private var test:Int;
	private var puntaje:FlxText;
	private var highscore:FlxText;
	private var vidas:FlxTypedGroup<Vidas>;
	private var r:FlxRandom;
	private var num:Int;


	override public function create():Void
	{
		super.create();

		
		r = new FlxRandom();
		random = new FlxRandom();
		pj = new Personaje(FlxG.width / 2, FlxG.height - 25);
		enemigos = new FlxTypedGroup<Enemigo>();
		barriles = new FlxTypedGroup<Barril>();
		vidas = new FlxTypedGroup<Vidas>();
		abo = new Aborigen();
		puntaje = new FlxText(FlxG.width * (3 / 4) - 5, FlxG.height -12, 0, "Score " + Reg.puntaje, 8,  true);
		highscore = new FlxText(FlxG.width / 2 - 30, FlxG.height - 12, 0, "Highscore " + Reg.highscore, 8, true);
		num = r.int(0, 5);
		puntaje.font = AssetPaths.kenpixel_mini__ttf;
		highscore.font = AssetPaths.kenpixel_mini__ttf;
		FlxG.sound.play(AssetPaths.musica__ogg, 1, true);
		FlxG.camera.bgColor = 0x00000000;

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

		for (i in 0...5)
		{
			var vida:Vidas = new Vidas(0.1 + (5 * (i + 1)), FlxG.height - 20);
			vidas.add(vida);
		}

		add(puntaje);
		add(highscore);
		add(abo);
		add(pj);
		add(vidas);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		
			movEne();
			colBalasEne();
			colPjEne();
			colPjBalasene();
			disparoEne();
			colBalasBarriles();
			colBalasAbo(num);
			respawnAbo(elapsed);
			ifBalaseneAliveCheckCol();
			showPuntaje();
			trace(Reg.timer);
		

	}

	public function movEne():Void
	{
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
				if (enemigos.members[i].y >= 130)
				FlxG.resetState();
			}
			
			Reg.moveD = false;
		}
	}

	public function colBalasEne():Void
	{
		for (i in 0...enemigos.members.length) //Colision Balas-Enemigos
		{

			if (FlxG.overlap(pj.bala, enemigos.members[i]))
			{
				FlxG.sound.play(AssetPaths.muerteEnemigos__ogg,1, false);
				pj.bala.kill();
				enemigos.remove(enemigos.members[i], true);
				Reg.puntaje +=  10;

			}
		}
	}

	public function colBalaseneBarriles(balaEne:Disparo) //Colision Balas-Barriles
	{

		for (i in 0...barriles.members.length-1)
		{

			if (FlxG.overlap(balaEne,barriles.members[i]))
			{
				balaEne.kill();
				barriles.members[i].barrilColision();
			}
		}

	}

	public function colPjEne():Void
	{
		for (i in 0...enemigos.members.length) //Colision Pj-Enemigos
		{

			if (FlxG.overlap(pj, enemigos.members[i]))
			{
				FlxG.sound.play(AssetPaths.muertePj__ogg,1, false);
				pj.kill();
				pj.perderVidas();
				vidas.remove(vidas.members[vidas.members.length - 1], true);
				if (pj.get_vidas()>0)
				{
					pj.reset(FlxG.width / 2, FlxG.height - 25);
				}
				if (pj.get_vidas() == 0)
				{
					if (Reg.puntaje>Reg.highscore)
					{
						Reg.highscore = Reg.puntaje;
					}
					Reg.puntaje = 0;
					FlxG.resetState();
				}

			}

		}
	}

	public function colPjBalasene():Void
	{
		for (i in 0...enemigos.members.length) //Colision Pj-Balas Enemigos
		{

			if (FlxG.overlap(pj,enemigos.members[i].balaEne ))
			{
				FlxG.sound.play(AssetPaths.muertePj__ogg,1, false);
				enemigos.members[i].balaEne.kill();
				pj.kill();
				pj.perderVidas();
				vidas.remove(vidas.members[vidas.members.length - 1], true);
				if (pj.get_vidas() > 0)
				{
					pj.reset(FlxG.width / 2, FlxG.height - 25);
				}
				if (pj.get_vidas() == 0)
				{
					if (Reg.puntaje >Reg.highscore)
					{
						Reg.highscore = Reg.puntaje;
					}
					Reg.puntaje = 0;
					FlxG.resetState();
				}

			}
		}
	}

	public function disparoEne():Void
	{
		//Disparo de los enemigos
		Reg.cuandoDisparo++;
		if (Reg.cuandoDisparo%70 == 0)
		{
			enemigos.members[random.int(0, enemigos.members.length-1)].disparar();
		}

		if (Reg.cuandoDisparo == 70)
		{
			Reg.cuandoDisparo = 0;
		}

		/*if (FlxG.keys.justPressed.Q)
		{

			enemigos.members[random.int(0, enemigos.members.length-1)].disparar();
		}*/
	}

	public function colBalasBarriles():Void
	{
		for (i in 0...barriles.members.length) //Colision Balas-Barriles
		{
			if (FlxG.overlap(pj.bala, barriles.members[i]))
			{
				pj.bala.kill();
				barriles.members[i].barrilColision();
			}
		}
	}

	public function colBalasAbo(num:Int):Void
	{
		if (FlxG.overlap(pj.bala, abo))
		{
			FlxG.sound.play(AssetPaths.muerteEnemigos__ogg,1, false);
			pj.bala.kill();
			abo.kill();
			if (abo.movIzqADer)
			{
				abo.movIzqADer = false;
			}
			else if (!abo.movIzqADer)
			{
				abo.movIzqADer = true;
			}
			Reg.timer = 0;

			Reg.puntaje += (num + 1) * 50;

		}
	}

	public function respawnAbo(elapsed:Float):Void
	{
		Reg.timer += elapsed;
		if (Reg.timer > 12)
		{
			abo.revivir();
			Reg.timer = 0;

		}
	}

	public function ifBalaseneAliveCheckCol():Void
	{
		for (j in 0...enemigos.members.length-1)
		{

			if (enemigos.members[j].balaEne.alive)
			{
				colBalaseneBarriles(enemigos.members[j].balaEne);
			}

		}
	}

	public function showPuntaje():Void
	{
		puntaje.text = "Score " + Reg.puntaje;

		if (Reg.puntaje > Reg.highscore)
		{
			highscore.text = "Highscore " + Reg.puntaje;
		}
	}

}
