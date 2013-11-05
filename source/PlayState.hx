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


class TextBox extends MovableGroup {

    public var background: FlxSprite;
    public var font: BitmapFont;
    public var textSprite: FlxSprite;
    public var text(default,set_text): String;
    public var lines: Array<String>;

    public function new() {
        super();

        background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/TextboxBackground.png");
        add(background);

        set_text("This is a test; please ignore!");

        font = new BitmapFont("assets/gourdgeous/font.png");
    }

    public function set_text(text: String) {
        if (textSprite != null) {
            textSprite.destroy();
            textSprite = null;
        }
        lines = text.wrapWords(18);
        return text;
    }

    override public function update() {
        super.update();
        
        if (textSprite == null) {
            textSprite = new FlxSprite(8,8);
            textSprite.width = FlxG.width-16;
            textSprite.height = 32;
            add(textSprite);
        //}

        /* if we need to refresh the text: */
        //if (true) {
            textSprite.pixels = new BitmapData(
                Std.int(textSprite.width), Std.int(textSprite.height),
                true, 0);
            var dest = new Point(0,0);
            // TODO only visible lines
            for (line in lines) {
                var lineCanvas = font.draw(line);
                textSprite.pixels.copyPixels(lineCanvas, lineCanvas.rect, dest);
                dest.y += lineCanvas.height;
                trace(lineCanvas.rect);
            }
            
            trace(textSprite.pixels.rect);
            trace(textSprite.width);
            trace(textSprite.height);
        }
    }

    override public function destroy() {
        textSprite.destroy();
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

        var textbox = new TextBox();
        add(textbox);
    }
}
