package;

import org.flixel.*;

import Sprites;
import TextSprite;

class MenuOption {
    public var text: String;
    public var onSelect: Int->Void;

    public function new(text: String, onSelect: Int->Void) {
        this.text = text;
        this.onSelect = onSelect;
    }
}

class MenuSprite extends MovableGroup {

    private inline static var ANSWER_NUMBERS =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    private var options: Array<MenuOption>;
    private var textSpr: TextSprite;
    private var upArrow: TextSprite;
    private var dnArrow: TextSprite;
    private var rtArrow: TextSprite;
    private var selection(get,set): Int;
    private var fSelection: Int;
    private var frames: Int;
    private var acceptInput: Bool;
    
    public function new(options: Array<MenuOption>) {
        super();

        this.options = options;
        this.frames = 0;
        this.acceptInput = false;

        textSpr = new TextSprite(16, 8, 144, 32);
        textSpr.text = "Foobar";

        upArrow = new TextSprite(0, 0, 8, 16);
        upArrow.text = "^";

        dnArrow = new TextSprite(0, 16, 8, 16);
        dnArrow.text = "_";

        //rtArrow = new TextSprite(8, 8, 8, 16);
        //rtArrow.text = ">";

        for (s in [textSpr,upArrow,dnArrow])//,rtArrow])
            add(s);

        this.selection = 0;
        
        x = 0;
        y = 112;
    }

    public function set_selection(s: Int) {
        textSpr.text = ANSWER_NUMBERS.charAt(s)+") "+options[s].text;
        fSelection = s;
        return s;
    }
    public function get_selection() {
        return fSelection;
    }

    public function isFirst() {
        return selection == 0;
    }
    public function isLast() {
        return selection == options.length-1;
    }

    override public function update() {
        super.update();
        
        ++frames;

        upArrow.kill();
        dnArrow.kill();
        if (!isFirst() && frames&4 != 0) {
            upArrow.revive();
        }
        if (!isLast() && frames&4 != 0) {
            dnArrow.revive();
        }

        if (acceptInput) {
            if (FlxG.keys.justPressed("DOWN") && !isLast()) {
                selection += 1;
            }
            if (FlxG.keys.justPressed("UP") && !isFirst()) {
                selection -= 1;
            }
            if (FlxG.keys.justPressed("C")) {
                options[selection].onSelect(selection);
            }
        } else {
            acceptInput = true;
        }
    }

}
