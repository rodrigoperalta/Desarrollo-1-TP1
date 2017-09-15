package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
/**
 * ...
 * @author Aleman5
 */
class PantallaTitulo extends FlxState 
{
	//private var jugar:FlxText;
	//private var highscore:FlxText;
	public var pantallaTitulo:PantallaTitulo;
	
	override public function create():Void
	{
		super.create();
		
		var jugar:FlxButton = new FlxButton(camera.width / 4, camera.height / 2, "Jugar", onClickButton);
		add(jugar);
	}
	
	function onClickButton() 
	{
		FlxG.switchState(new PlayState());
	}
	

	public function new(state:PantallaTitulo)
	{
		super();
		
		pantallaTitulo = state;
	}
	
}