package;

import org.flixel.*;


/* Like a backlight but makes things darker. */

class Backdark extends FlxSprite {

    public var target: Float;
    public var enableFade: Bool;

    public function new() {
        super();
        alpha = 0;
        target = alpha;
        enableFade = true;
        makeGraphic(160, 144, 0xff000000, true);
    }

    override public function update() {
        super.update();

        if (enableFade && alpha != target) {
            alpha = (alpha*15+target)/16;
        }

        if (!Params.isCheaty()) {
            target = Std.int(target);
            alpha = target;
        }

    }

}
