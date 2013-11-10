package;

import org.flixel.*;
import org.flixel.util.FlxTimer;

class Candle extends FlxSprite {

    public var onTimeOut: Void->Void;
    public var value: Int;
    public var timer: FlxTimer;
    public var animated: Bool;

    public function new() {
        super();
        loadGraphic("assets/gourdgeous/candle.png", true, false, 16, 48);
        for (i in 0...7) {
            addAnimation(Std.string(i), [i*2, i*2+1], 12, true);
            addAnimation(Std.string(i)+"-stopped", [i*2], 12, true);
        }

        timer = new FlxTimer();
        resetCandle();
        stopCandle();
    }

    public function resetCandle() {
        value = 6;
        timer.start(1, 6, function(_) timerCallback());
        animated = true;
    }
    
    public function stopCandle() {
        timer.stop();
        animated = false;
    }

    private function timerCallback() {
        value -= 1;
    }

    override public function update() {
        super.update();

        if (value > 6) value = 6;
        if (value < 0) value = 0;

        play(Std.string(value) + (if (!animated) "-stopped" else ""));


        if (value <= 0 && animated) {
            timer.stop();
            if (onTimeOut != null) {
                onTimeOut();
            }
        }
    }

}
