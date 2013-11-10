package;

import org.flixel.*;

import TextSprite;
import MenuSprite;
import Dialogue;
import Pumpkin;
import Candle;
import Backdark;


class PlayState extends FlxState {

    var pumpkin: Pumpkin;
    var candle: Candle;
    var glitchBar: GlitchBar;

    var backdark: Backdark;
    var batteryIndicator: BatteryIndicator;

    var baseLayer: FlxGroup;
    var glitchLayer: FlxGroup;
    var screenLayer: FlxGroup;

    var walkingPixels: FlxGroup;

    var score(get,set): Int;
    private var fScore: Int;
    var question: Int;
    
    override public function create() {
        super.create();

        baseLayer = new FlxGroup();
        add(baseLayer);
        glitchLayer = new FlxGroup();
        add(glitchLayer);
        screenLayer = new FlxGroup();
        add(screenLayer);

        walkingPixels = new FlxGroup();

        screenLayer.add(backdark = new Backdark());
        screenLayer.add(batteryIndicator = new BatteryIndicator());
        batteryIndicator.x = 144;
        batteryIndicator.y = 96;

        var backBackground = new FlxSprite();
        backBackground.makeGraphic(200, 200, Palette.getColor(0));
        backBackground.x = -20;
        backBackground.y = -20;
        baseLayer.add(backBackground);

        var background = new FlxSprite();
        background.loadGraphic("assets/gourdgeous/Background.png");
        baseLayer.add(background);

        pumpkin = new Pumpkin();
        pumpkin.x = pumpkin.y = 48;
        baseLayer.add(pumpkin);

        baseLayer.add(candle = new Candle());
        candle.x = 16;
        candle.y = 56;
        candle.onTimeOut = timedOut;

        glitchLayer.add(glitchBar = new GlitchBar());
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
        baseLayer.add(textbox);
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
        baseLayer.add(textspr);

        baseLayer.add(menuspr = new MenuSprite([for (ans in q.answers)
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
        FlxG.camera.fade(0xff000000, 3, fadedOut);
    }

    public function fadedOut() {
        FlxG.switchState(new MenuState());
    }

    override public function update() {
        super.update();

        if (FlxG.random() < 1./512) {
            var wp:FlxSprite = cast(walkingPixels.getRandom(), FlxSprite);
            if (wp != null) {
                wp.kill();
                var burstPixel = new FlxSprite(wp.x-8, wp.y-8);
                burstPixel.loadGraphic("assets/gourdgeous/burst-pixel.png");
                screenLayer.add(burstPixel);
            }
        }


        var progress = (score-50)/50;
        if (progress < 0) progress = 0;

        backdark.target = progress * 0.7;
        batteryIndicator.charge = 1-progress;

        progress *= progress;
        var threshold = 1 - progress * 0.7;
        if (FlxG.random() > threshold) {
            var wp = new WalkingPixel();
            wp.x = 160;
            wp.y = 144;
            if (FlxG.random() < 0.5)
                wp.x = FlxG.random() * wp.x;
            else
                wp.y = FlxG.random() * wp.y;
            glitchLayer.add(wp);
            walkingPixels.add(wp);
        }

        if (progress >= 1) {
            if (FlxG.random() < 1./32.) {
                FlxG.camera.shake(2/160.0, 1./8., null, false, 
                    FlxCamera.SHAKE_BOTH_AXES);
            }

            if (FlxG.random() < 1./128.) {
                pumpkin.background.replaceColor(Palette.getColor(1),
                    Palette.getColor(3));
            }

            if (FlxG.random() < 1./64) {
                pumpkin.glitch();
                Sounds.GLITCH.play();
            }

            if (FlxG.random() < 1./32.) {
                candle.value = Std.int(FlxG.random()*6);
            }
        }
    }

}
