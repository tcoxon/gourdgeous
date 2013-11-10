package;

import flash.display.*;
import org.flixel.*;


class Palette {
    
    private static var bmpdata: BitmapData = null;

    private static function getBitmapData() {
        if (bmpdata == null) {
            bmpdata = FlxG.addBitmap("assets/gourdgeous/palette.png");
        }
        return bmpdata;
    }

    public static function getColorCount() {
        var bd = getBitmapData();
        return bd.width * bd.height;
    }

    public static function getColor(index: Int) {
        var bd = getBitmapData();
        var x = index % bd.width;
        var y = Std.int(index / bd.width);
        return bd.getPixel32(x,y);
    }

}


