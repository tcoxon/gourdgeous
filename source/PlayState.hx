package;

import org.flixel.*;
import org.flixel.util.FlxTimer;

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
    private var currentFace: String;
    private var shaking: Bool;
    private var winking: Bool;
    private var timer: FlxTimer;
    private var frames: Int;
    private var score: Int;
    private var baseX: Float;
    private var baseY: Float;
    
    public function new() {
        super();

        background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/Pumpkin.png");
        add(background);
        
        face = new FlxSprite();
        setFace("happy");
        add(face);

        shaking = false;
        winking = false;
        timer = new FlxTimer();
        score = 50;
    }

    public function setFace(face: String) {
        currentFace = face;
        this.face.loadGraphic("assets/gourdgeous/Faces/"+face+".png");
    }

    public function updateFaceForScore(score: Int) {
        this.score = score;
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

    public function shake() {
        if (shaking) return;
        shaking = true;
        frames = 0;
        baseX = face.x;
        if (currentFace != "cry")
            setFace("sad");
        timer.start(0.7, 1, function(_) {
            shaking = false;
            updateFaceForScore(score);
            face.x = baseX;
        });
    }

    public function wink() {
        if (winking) return;
        winking = true;
        frames = 0;
        baseY = face.y;
        setFace("wink");
        timer.start(0.7, 1, function(_) {
            winking = false;
            updateFaceForScore(score);
            face.y = baseY;
        });
    }

    override public function update() {
        super.update();
        ++frames;

        if (shaking) {
            var period = 4;
            var t = frames % period;
            face.x = Math.cos(t * 2 * Math.PI / period) * 2 + baseX;
        }

        if (winking) {
            var period = 8;
            var t = frames % period;
            face.y = Math.cos(t * 2 * Math.PI / period) * 2 + baseY;
        }
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

    public function answerChosen(ansNo: Int) {
        textspr.kill(); textspr = null;
        menuspr.kill(); menuspr = null;

        var q = Dialogue.QUESTIONS[question];
        var a = q.answers[ansNo];

        score += a.score;
        pumpkin.updateFaceForScore(score);
        if (a.score < 0) pumpkin.shake();
        else if (a.score > 0) pumpkin.wink();

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
