package;

import org.flixel.*;


class WalkingPixel extends FlxSprite {
    
    private var frameNo: Int;

    public function new() {
        super();

        loadGraphic("assets/gourdgeous/palette.png", true, false, 1, 1);
        addAnimation("walk", [0,1,2,3], 16, true);
        play("walk");

        frameNo = 0;
    }

    override public function update() {
        super.update();

        switch (Std.int(FlxG.random() * 6)) {
        case 0, 1:  x -= 1;
        case 2, 3:  y -= 1;
        case 4:     x += 1;
        case 5:     y += 1;
        }

        ++frameNo;
        if (frameNo > 50 && !onScreen()) {
            kill();
        }
    }

}
