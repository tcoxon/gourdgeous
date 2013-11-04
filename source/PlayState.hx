package;

import org.flixel.*;


class Pumpkin extends FlxGroup {

    public var x(default, set_x): Int;
    public var y(default, set_y): Int;

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

    public function set_x(x: Int) {
        for (spr in members) {
            if (Std.is(spr, FlxObject))
                cast(spr,FlxObject).x += x - this.x;
        }
        return x;
    }

    public function set_y(y: Int) {
        for (spr in members) {
            if (Std.is(spr, FlxObject))
                cast(spr,FlxObject).y += y - this.y;
        }
        return y;
    }
}


class PlayState extends FlxState {

    var pumpkin: Pumpkin;
    
    override public function create() {
        super.create();

        var background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/Background.png");
        add(background);

        var pumpkin = new Pumpkin();
        pumpkin.x = pumpkin.y = 48;
        add(pumpkin);
    }
}
