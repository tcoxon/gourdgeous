package;

import org.flixel.*;


/* Like a backlight but makes things darker. */

class Backdark extends FlxSprite {

    public var target: Float;

    public function new() {
        super();
        alpha = 0;
        target = alpha;
        makeGraphic(160, 144, 0xff000000, true);
    }

    override public function update() {
        super.update();

        if (alpha != target) {
            alpha = (alpha*15+target)/16;
        }

    }

}
