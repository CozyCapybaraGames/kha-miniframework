
import kha.graphics2.Graphics;
import kha.Window;
import kha.math.FastMatrix3 as M3;
#if kha_html5
import js.Browser.document;
import js.Browser.window;
import js.html.CanvasElement;
import kha.Macros;
#end

class Screen {
    public static var designWidth(default, null) = 0;    
    public static var designHeight(default, null) = 0;

    public static var scale(default, null) = 0.0;
    public static var scaledWidth(default, null) = 0;
    public static var scaledHeight(default, null) = 0;

    public static var windowWidth(default, null) = 0;
    public static var windowHeight(default, null) = 0;

    public static var offsetX(default, null) = 0;
    public static var offsetY(default, null) = 0;

    public static var transform(default, null) = M3.identity();
    
    public static function init(designWidth: Int, designHeight: Int) {
        Screen.designWidth = designWidth;
        Screen.designHeight = designHeight;
        
        #if kha_html5
        htmlResize();
        #end

        final win = Window.get(0);
        
        win.notifyOnResize(onResize);
        onResize(win.width, win.height);
    }

    static function htmlResize() {
        document.documentElement.style.padding = "0";
		document.documentElement.style.margin = "0";
		document.body.style.padding = "0";
		document.body.style.margin = "0";
		document.body.style.overflow = "hidden";
		final canvas: CanvasElement = cast document.getElementById(Macros.canvasId());
		canvas.style.display = "block";
		final resize = function() {
			var w = document.documentElement.clientWidth;
			var h = document.documentElement.clientHeight;
			if (w == 0 || h == 0) {
				w = window.innerWidth;
				h = window.innerHeight;
			}
			canvas.width = Std.int(w * window.devicePixelRatio);
			canvas.height = Std.int(h * window.devicePixelRatio);
			if (canvas.style.width == "") {
				canvas.style.width = "100%";
				canvas.style.height = "100%";
			}
		}
		window.onresize = resize;
		resize();
    }

    static function onResize(w: Int, h: Int) {
        windowWidth = w;
        windowHeight = h;

        scale = Math.min(w / designWidth, h / designHeight);

        scaledWidth = Std.int(designWidth * scale);
        scaledHeight = Std.int(designHeight * scale);

        offsetX = Std.int((w - scaledWidth) / 2);
		offsetY = Std.int((h - scaledHeight) / 2);

        transform = M3.translation(offsetX, offsetY).multmat(M3.scale(scale, scale));
    }
}