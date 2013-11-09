package;

import org.flixel.*;

import Sprites;
import TextSprite;
import Dialogue;


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


class PlayState extends FlxState {

    var pumpkin: Pumpkin;
    
    override public function create() {
        super.create();

        var background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/Background.png");
        add(background);

        var pumpkin = new Pumpkin();
        pumpkin.x = pumpkin.y = 48;
        add(pumpkin);

        startGame();
    }

    public function startGame() {
        // TODO start first question
        endGame(Dialogue.BEST_ENDING);
    }

    public function questionClosed() {
        // TODO display menu, candle
    }

    public function answerChosen(ansNo: Int) {
        // TODO modify score, show response
    }

    public function timedOut() {
        // TODO end game
    }

    public function responseClosed() {
        // TODO display next question or end game
    }

    public function endGame(ending: String) {
        var textbox = new TextBox(ending);
        textbox.onClose = endGameDone;
        add(textbox);
    }

    public function endGameDone() {
        // TODO reset
        startGame();
    }
}
