package;

import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.ExprTools;

class AssertError {
    private var expr: String;

    public function new(expr: String) {
        this.expr = expr;
    }

    public function toString() {
        return "AssertionError: "+expr;
    }
}


class MyUtil {
    
    macro public static function assert(e: Expr): Expr {
        var es = Context.makeExpr(ExprTools.toString(e), Context.currentPos());
        return macro if (!$e) throw new AssertError($es);
    }

}

