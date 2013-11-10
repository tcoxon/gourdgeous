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
import TextSprite;

class MenuState extends FlxState {
    
    public var pressText: TextSprite;
    public var frameNo: Int;

	override public function create() {
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

        var background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/title-screen.png");
        add(background);

        pressText = new TextSprite(88, 88, 64, 32);
        pressText.text = "PRESS START";
        add(pressText);

        frameNo = 0;
	}
	
    private static var BUTTONS = ["X", "C", "UP", "RIGHT", "DOWN", "LEFT"];

	override public function update() {
		super.update();
        
        for (b in BUTTONS) {
            if (FlxG.keys.justPressed(b)) {
                FlxG.switchState(new PlayState());
                return;
            }
        }

        ++frameNo;
        pressText.alpha = if (frameNo&4 == 0) 1 else 0;
	}	

}
