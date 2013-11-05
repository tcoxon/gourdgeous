package;

import org.flixel.*;

import Sprites;
import TextSprite;


class Pumpkin extends MovableGroup {

    public var background: FlxSprite;
    public var face: FlxSprite;
    
    public function new() {
        super();

        background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/Pumpkin.png");
        add(background);
        
        face = new FlxSprite();
        face.loadGraphic("assets/gourdgeous/Faces/Default/001.png");
        add(face);
    }
}


class PlayState extends FlxState {

    var pumpkin: Pumpkin;
    var textbox: TextBox;
    
    override public function create() {
        super.create();

        var background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/Background.png");
        add(background);

        var pumpkin = new Pumpkin();
        pumpkin.x = pumpkin.y = 48;
        add(pumpkin);

        var textbox = new TextBox("This is a test; please wait for the signal to ignore!\nOr just don't...\n\nWhatever.");
        add(textbox);
    }
}
