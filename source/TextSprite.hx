package;

import org.flixel.*;
import flash.geom.*;
import flash.display.*;

import Sprites;

using TextUtil;


class TextSprite extends FlxSprite {

    public var font: BitmapFont;
    public var text(get, set): String;
    private var my_text: String;

    public function new(?x: Float, ?y: Float, width: Int, height: Int) {
        super(x,y);
        this.width = width;
        this.height = height;
        font = new BitmapFont("assets/gourdgeous/font.png");
        text = "";
    }

    public function set_text(text:String) {
        var lines = text.wrapWords(Std.int(width / font.charWidth()));

        pixels = new BitmapData(Std.int(width), Std.int(height), true, 0);
        var dest = new Point(0,0);
        for (line in lines) {
            var lineCanvas = font.draw(line);
            pixels.copyPixels(lineCanvas, lineCanvas.rect, dest);
            dest.y += lineCanvas.height;
        }

        my_text = text;
        dirty = true;
        return text;
    }

    public function get_text() {
        return my_text;
    }
}

class TextBox extends MovableGroup {

    public var background: FlxSprite;
    public var textSpr: TextSprite;
    private var waitSymbol: TextSprite;
    private var text: String;
    private var lines: Array<String>;
    private var textPos: Int;
    private var lineNo: Int;
    public var waitingToProceed: Bool;
    public var waitingToComplete: Bool;
    private var frame: Int;

    public function new(text: String) {
        super();

        background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/TextboxBackground.png");
        add(background);

        textSpr = new TextSprite(8, 8, 144, 32);
        add(textSpr);

        waitSymbol = new TextSprite(144, 36, 8, 16);
        waitSymbol.text = "_";
        add(waitSymbol);
        waitSymbol.kill();

        this.text = text;
        lines = text.wrapWords(18);
        textPos = lineNo = 0;

        waitingToProceed = false;
        waitingToComplete = false;
    }

    override public function update() {
        super.update();

        if (waitingToComplete &&
                (FlxG.keys.justPressed("C") || FlxG.keys.justPressed("X"))) {
            kill();
            return;
        }

        ++frame;
        
        do {
            var curLine = lines[lineNo];
            if (textPos >= curLine.length) {
                if (lineNo + 1 < lines.length) {
                    waitingToProceed = true;
                    if (lineNo < 1 || FlxG.keys.justPressed("C")) {
                        textPos = 0;
                        ++lineNo;
                        if (lineNo > 1) {
                            lineNo = 1;
                            lines.shift();
                        }
                        textSpr.text = curLine+"\n";
                        waitingToProceed = false;
                    }
                } else {
                    waitingToComplete = true;
                }
                break;
            } else {
                var c = curLine.charAt(textPos);
                textSpr.text += c;
                ++textPos;
            }
        } while (FlxG.keys.X);

        waitSymbol.kill();
        if ((waitingToProceed || waitingToComplete) && frame&4 != 0) {
            waitSymbol.revive();
        }
    }

    override public function destroy() {
        textSpr.destroy();
        background.destroy();
        super.destroy();
    }

}


