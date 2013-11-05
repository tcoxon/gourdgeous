package;

import org.flixel.*;

class MovableGroup extends FlxGroup {

    public var x(default, set_x): Int;
    public var y(default, set_y): Int;

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

