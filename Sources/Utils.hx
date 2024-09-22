package;

import haxe.macro.Expr.ExprOf;
import haxe.macro.Context;
import haxe.macro.ExprTools;

class Utils {
    public static function boxCollision(x1: Float, y1: Float, w1: Float, h1: Float) {
        return (x2: Float, y2: Float, w2: Float, h2: Float) -> !(
            x1 + w1 <= x2 ||
            x1 >= x2 + w2 ||
            
            y1 + h1 <= y2 ||
            y1 >= y2 + h2
        );
    }

    public static macro function emitWarning(msg: String) {
        Context.warning(msg, Context.currentPos());

        return macro trace($v{msg});
    }

    public static inline function lerp(start: Float, end: Float, t: Float) {
        return start + (end-start)*t;
    }

    public static inline function lerpInt(start: Int, end: Int, t: Float) {
        return Math.floor(lerp(start, end, t));
    }

    public static inline function mid(min: Float, v: Float, max: Float) {
        return Math.max(min, Math.min(v, max));
    }

    public static inline function midInt(min: Int, v: Int, max: Int) {
        final mid = Math.floor(Math.min(v, max));

        return Math.ceil(Math.min(min, mid));
    }
}