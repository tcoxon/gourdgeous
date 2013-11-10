package;

import org.flixel.*;
import org.flixel.util.FlxTimer;

import Sprites;

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
        Sounds.SAD.play();
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
        Sounds.WINK.play();
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
            face.x = Std.int(Math.cos(t * 2 * Math.PI / period) * 2 + baseX);
        }

        if (winking) {
            var period = 8;
            var t = frames % period;
            face.y = Std.int(Math.cos(t * 2 * Math.PI / period) * 2 + baseY);
        }
    }
}


