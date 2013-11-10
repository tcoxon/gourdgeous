package;

import flash.geom.*;
import org.flixel.*;

import Palette;


class GlitchBar extends FlxSprite {

    public static inline var W = 16;
    public static inline var H = 144;
    public static inline var TILESIZE = 8;
    public static inline var TILEW = Std.int(W/TILESIZE);
    public static inline var TILEH = Std.int(H/TILESIZE);
    
    public var value(get,set): Int;
    private var fValue: Int;

    public function new() {
        super();
        makeGraphic(16, 144, 0xffffffff, true);
        value = 50;
    }

    public function set_value(v: Int) {
        fValue = v;
        redraw();
        return v;
    }

    public function get_value() {
        return fValue;
    }

    private function redraw() {
        pixels.fillRect(pixels.rect, 0);

        var tileV = if (value > 50) (value-50) * TILEH / 50 else 0;

        for (y in 0...TILEH) {
            if (y >= tileV) break;
            fillTile(1, y);
            if (y+2 < tileV && FlxG.random() < 0.5)
                fillTile(0, y);
        }

        dirty = true;
    }

    private function fillTile(tx: Int, ty: Int) {
        var baseX = tx * TILESIZE;
        var baseY = ty * TILESIZE;

        for (x in 0...TILESIZE) for (y in 0...TILESIZE) {
            var color = Palette.getColor(Std.int(
                    FlxG.random() * Palette.getColorCount()));
            pixels.setPixel32(baseX+x, baseY+y, color);
        }
    }

}
