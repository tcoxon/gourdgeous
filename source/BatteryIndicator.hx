package;

import flash.display.BlendMode;
import org.flixel.*;


class BatteryIndicator extends FlxSprite {

    public var charge: Float;
    private var frameNo: Int;
    
    public function new() {
        super();
        loadGraphic("assets/gourdgeous/battery-indicator.png");
        blend = BlendMode.HARDLIGHT;
        alpha = 0;
        charge = 1;
        frameNo = 0;
    }

    override public function update() {
        ++frameNo;

        alpha = 0;
        if ((charge > 0.2 && charge < 0.5 && (frameNo&8) != 0)) {
            alpha = 0.5;
        } else if (charge < 0.2 && (frameNo&4) != 0) {
            alpha = 0.75;
        }
    }
}
