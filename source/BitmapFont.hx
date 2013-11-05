using TextUtil;

import org.flixel.FlxG;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

class BitmapFont {
    var sheet: BitmapData;
    var colWidth: Int;
    var rowHeight: Int;

    public function new(asset: String) {
        sheet = FlxG.addBitmap(asset);
        colWidth = 8;
        rowHeight = 16;
    }

    public function charWidth(): Int {
        return colWidth;
    }

    public function charHeight(): Int {
        return rowHeight;
    }

    public function cols(): Int {
        return Std.int(sheet.width / colWidth);
    }

    public function rows(): Int {
        return Std.int(sheet.height / rowHeight);
    }

    public function getCharBmp(char: String): BitmapData {
        var index = char.charCodeAt(0);
        var row = Std.int(index / cols()),
            col = index % cols();
        var result = new BitmapData(colWidth, rowHeight, true);
        result.copyPixels(sheet,
            new Rectangle(col * colWidth,
                          row * rowHeight,
                          colWidth, rowHeight),
            new Point(0,0));
        return result;
    }

    public function draw(?canvas: BitmapData, text: String): BitmapData {
        var width = Std.int(Math.max(text.length * colWidth, 1));
        var height = rowHeight;

        if (canvas == null) {
            canvas = new BitmapData(width, height, true, 0);
        }

        var dest = new Point(0,0);
        var source = new Rectangle(0,0, colWidth, rowHeight);
        for (char in text.chars()) {
            var charBmp = getCharBmp(char);
            canvas.copyPixels(charBmp, source, dest);
            dest.x += colWidth;
        }

        return canvas;
    }
}
