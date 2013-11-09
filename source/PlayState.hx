package;

import org.flixel.*;

import Sprites;
import TextSprite;
import MenuSprite;
import Dialogue;

using MyUtil;


class Pumpkin extends MovableGroup {

    public static var FACES = [
        "cry" => 0,
        "sad" => 25,
        "meh" => 50,
        "happy" => 75,
        "ecstatic" => 100,
    ];

    public var background: FlxSprite;
    public var face: FlxSprite;
    
    public function new() {
        super();

        background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/Pumpkin.png");
        add(background);
        
        face = new FlxSprite();
        face.loadGraphic("assets/gourdgeous/Faces/happy.png");
        add(face);
    }

    public function setFace(face: String) {
        this.face.loadGraphic("assets/gourdgeous/Faces/"+face+".png");
    }

    public function updateFaceForScore(score: Int) {
        var bestD = 999999.;
        var bestFace = null;
        for (face in FACES.keys()) {
            var faceVal = FACES[face];
            var d = Math.abs(faceVal - score);
            if (d < bestD) {
                bestD = d;
                bestFace = face;
            }
        }
        (bestFace != null).assert();
        setFace(bestFace);
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

        pumpkin = new Pumpkin();
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
        pumpkin.updateFaceForScore(score);
        showQuestion();
    }

    public function showQuestion() {
        var q = Dialogue.QUESTIONS[question];
        showTextBox(q.text, questionClosed);
    }

    private var textspr: TextSprite;
    private var menuspr: MenuSprite;

    public function questionClosed() {
        var q = Dialogue.QUESTIONS[question];
        textspr = new TextSprite(8, 8, 144, 32);
        textspr.text = q.simpleText;
        add(textspr);

        add(menuspr = new MenuSprite([for (ans in q.answers)
                                new MenuOption(ans.text, answerChosen)]));
        // TODO display menu, candle
    }

    public function shakePumpkin() {
        // TODO, sound also
    }

    public function winkPumpkin() {
        // TODO, sound also
    }

    public function answerChosen(ansNo: Int) {
        textspr.kill(); textspr = null;
        menuspr.kill(); menuspr = null;

        var q = Dialogue.QUESTIONS[question];
        var a = q.answers[ansNo];

        score += a.score;
        if (a.score < 0) shakePumpkin();
        else if (a.score > 0) winkPumpkin();
        pumpkin.updateFaceForScore(score);

        // show response
        showTextBox(a.response, responseClosed);
    }

    public function timedOut() {
        textspr.kill(); textspr = null;
        menuspr.kill(); menuspr = null;
        endGame(Dialogue.OUT_OF_TIME_ENDING);
    }

    public function responseClosed() {
        ++question;
        if (score <= 0 || question >= Dialogue.QUESTIONS.length) {
            if (score >= 100) {
                endGame(Dialogue.BEST_ENDING);
            } else if (score > 0) {
                endGame(Dialogue.MIDDLE_ENDING);
            } else {
                endGame(Dialogue.WORST_ENDING);
            }
            return;
        }
        showQuestion();
    }

    public function endGame(ending: String) {
        showTextBox(ending, endGameDone);
    }

    public function endGameDone() {
        FlxG.switchState(new MenuState());
    }
}
