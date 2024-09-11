package;

class Utils {
    public static function boxCollision(x1: Float, y1: Float, w1: Float, h1: Float) {
        return (x2: Float, y2: Float, w2: Float, h2: Float) -> !(
            x1 + w1 <= x2 ||
            x1 >= x2 + w2 ||
            
            y1 + h1 <= y2 ||
            y1 >= y2 + h2
        );
    }
}