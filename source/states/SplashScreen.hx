package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxGame;

/**
 * ...
 * @author Aleman5
 */
class SplashScreen extends FlxState 
{
	private var ale:FlxText;
	private var fran:FlxText;
	private var rodri:FlxText;
	private var produ:FlxText;
	
	public function new() 
	{
		produ = new FlxText(camera.width / 2 - 10, camera.height / 2 - 15, 0, "Producciones Cowboy's", 18, true);
		produ.setFormat(AssetPaths.kenpixel_mini__ttf, 18, 0xFFBB1515);
		
		ale = new FlxText(camera.width / 2 - 20, camera.height / 2 + 1, 0, "Alejandro Abecasis", 15, true);
		ale.setFormat(AssetPaths.kenpixel_mini__ttf, 18, 0xFFBB1515);
		
		fran = new FlxText(camera.width / 2 - 20, camera.height / 2 + 17, 0, "Francisco Hogner", 15, true);
		fran.setFormat(AssetPaths.kenpixel_mini__ttf, 18, 0xFFBB1515);
		
		rodri = new FlxText(camera.width / 2 - 20, camera.height / 2 + 33, 0, "Federico Peralta", 15, true);
		rodri.setFormat(AssetPaths.kenpixel_mini__ttf, 18, 0xFFBB1515);
	}
	
}