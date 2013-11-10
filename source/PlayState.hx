package;

import org.flixel.*;

import TextSprite;
import MenuSprite;
import Dialogue;
import Pumpkin;
import Candle;


class PlayState extends FlxState {

    var pumpkin: Pumpkin;
    var candle: Candle;
    var glitchBar: GlitchBar;

    var score(get,set): Int;
    private var fScore: Int;
    var question: Int;
    
    override public function create() {
        super.create();

        var background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/Background.png");
        add(background);

        pumpkin = new Pumpkin();
        pumpkin.x = pumpkin.y = 48;
        add(pumpkin);

        add(candle = new Candle());
        candle.x = 16;
        candle.y = 56;
        candle.onTimeOut = timedOut;

        add(glitchBar = new GlitchBar());
        glitchBar.x = 160 - glitchBar.width;

        startGame();
    }

    private function get_score() {
        return fScore;
    }

    private function set_score(s: Int) {
        pumpkin.updateFaceForScore(s);
        glitchBar.value = s;
        fScore = s;
        return s;
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
    private var menuspr: MenuSprite;

    public function questionClosed() {
        var q = Dialogue.QUESTIONS[question];
        textspr = new TextSprite(8, 8, 144, 32);
        textspr.text = q.simpleText;
        add(textspr);

        add(menuspr = new MenuSprite([for (ans in q.answers)
                                new MenuOption(ans.text, answerChosen)]));
        candle.resetCandle();
    }

    public function answerChosen(ansNo: Int) {
        textspr.kill(); textspr = null;
        menuspr.kill(); menuspr = null;
        candle.stopCandle();

        var q = Dialogue.QUESTIONS[question];
        var a = q.answers[ansNo];

        score += a.score;
        if (a.score < 0) pumpkin.shake();
        else if (a.score > 0) pumpkin.wink();

        // show response
        showTextBox(a.response, responseClosed);
    }

    public function timedOut() {
        textspr.kill(); textspr = null;
        menuspr.kill(); menuspr = null;
        candle.stopCandle();
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
