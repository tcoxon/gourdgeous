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

    var score: Int;
    var question: Int;
    
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

    private function showTextBox(text: String, onClose: Void->Void) {
        var textbox = new TextBox(text);
        textbox.onClose = onClose;
        add(textbox);
    }

    public function startGame() {
        question = 0;
        score = 50;
        showQuestion();
    }

    public function showQuestion() {
        var q = Dialogue.QUESTIONS[question];
        showTextBox(q.text, questionClosed);
    }

    private var textspr: TextSprite;

    public function questionClosed() {
        var q = Dialogue.QUESTIONS[question];
        var textspr = new TextSprite(8, 8, 144, 32);
        textspr.text = q.simpleText;
        add(textspr);
        // TODO display menu, candle
    }

    public function answerChosen(ansNo: Int) {
        // TODO modify score, show response
        if (textspr != null) textspr.kill();
    }

    public function timedOut() {
        // TODO end game
        if (textspr != null) textspr.kill();
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
