package;

import org.flixel.*;


class Sounds {

    public static var SAD: FlxSound;
    public static var WINK: FlxSound;

    public static function init() {
        SAD = new FlxSound();
        SAD.loadEmbedded("Sad");

        WINK = new FlxSound();
        WINK.loadEmbedded("Wink");
    }

}
