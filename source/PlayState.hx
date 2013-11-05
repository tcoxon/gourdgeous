package;

import org.flixel.*;
import flash.geom.*;
import flash.display.*;

using TextUtil;


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

class Pumpkin extends MovableGroup {

    public var background: FlxSprite;
    public var face: FlxSprite;
    
    public function new() {
        super();

        background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/Pumpkin.png");
        add(background);
        
        face = new FlxSprite();
        face.loadGraphic("assets/gourdgeous/Faces/Default/001.png");
        add(face);
    }
}


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
        return text;
    }

    public function get_text() {
        return my_text;
    }
}

class TextBox extends MovableGroup {

    public var background: FlxSprite;
    public var textSpr: TextSprite;
    private var text: String;
    private var lines: Array<String>;
    private var textPos: Int;
    private var lineNo: Int;

    public function new(text: String) {
        super();

        background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/TextboxBackground.png");
        add(background);

        textSpr = new TextSprite(8, 8, FlxG.width-16, 32);
        add(textSpr);

        this.text = text;
        lines = text.wrapWords(18);
        textPos = lineNo = 0;
    }

    override public function update() {
        super.update();

        var curLine = lines[lineNo];
        if (textPos >= curLine.length) {
            if (lineNo + 1 < lines.length) {
                textPos = 0;
                ++lineNo;
                textSpr.text = curLine+"\n";
            }
        } else {
            var c = curLine.charAt(textPos);
            textSpr.text += c;
            ++textPos;
        }
    }

    override public function destroy() {
        textSpr.destroy();
        background.destroy();
        super.destroy();
    }

}


class PlayState extends FlxState {

    var pumpkin: Pumpkin;
    var textbox: TextBox;
    
    override public function create() {
        super.create();

        var background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/Background.png");
        add(background);

        var pumpkin = new Pumpkin();
        pumpkin.x = pumpkin.y = 48;
        add(pumpkin);

        var textbox = new TextBox("This is a test; please wait for the signal to ignore!\nOr just don't...\n\nWhatever.");
        add(textbox);
    }
}
