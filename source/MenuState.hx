package;

import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.util.FlxMath;

import Sounds;
import Palette;

class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		// Set a background color
        flash.Lib.current.opaqueBackground = 0xff000000;
        FlxG.camera.bgColor = FlxG.bgColor = Palette.getColor(0);

		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
        FlxG.mouse.useSystemCursor = true;
		FlxG.mouse.show();
		#end

        Sounds.init();
		
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
        FlxG.switchState(new PlayState());
	}	

}
