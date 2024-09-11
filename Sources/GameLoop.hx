import keeb.Input;
import kha.Assets;
import kha.Scheduler;
import kha.math.Random;
import kha.System;
import kha.math.FastMatrix3 as M3;

class GameLoop {
    static var currentScene: Scene;

    public static function run(opts: GameLoopOptions) {
        final rngSeed = opts.rngSeed ?? Std.int(System.time * 1000000);
        final updateFps = opts.updateFps ?? 60;
        final updateDelta = 1 / updateFps;

        var windowMode: kha.WindowMode;
        var width: Null<Int> = null;
        var height: Null<Int> = null;

        switch (opts.windowMode) {
            case Fullscreen:
                windowMode = ExclusiveFullscreen;
            case BorderlessFullscreen:
                windowMode = Fullscreen;
            case Windowed(scale):
                windowMode = Windowed;
                width = opts.designWidth * scale;
                height = opts.designHeight * scale;
        }

        System.start(
            {
                title: opts.windowTitle,
                window: {
                    title: opts.windowTitle,
                    mode: windowMode, 
                    width: width,
                    height: height
                }
            },
            (_) -> {
                Assets.loadEverything(() -> {
                    Random.init(rngSeed);
                    Screen.init(opts.designWidth, opts.designHeight);

                    currentScene = opts.initialScene();

                    var lastT = Scheduler.realTime();
                    var accumulator = 0.0;
                    
                    System.notifyOnFrames(windows -> {
                        Input.update();

                        final now = Scheduler.realTime();
                        final frameTime = now - lastT;
                        lastT = now;

                        accumulator += frameTime;

                        if (accumulator >= updateDelta) {
                            currentScene.update();
                        }

                        accumulator %= updateDelta;
                        final alpha = accumulator / updateDelta; 

                        final fb = windows[0];
                        final g = fb.g2;
                        final g4 = fb.g4;

                        g.begin();
                        g.font = Assets.fonts.dogicapixel;
                        g.fontSize = 16;

                        currentScene.drawBackground(g, g4, alpha);

                        g.pushTransformation(Screen.transform);
                        g.scissor(
                            Screen.offsetX,
                            Screen.offsetY,
                            Screen.scaledWidth,
                            Screen.scaledHeight
                        );

                        currentScene.draw(g, g4, alpha);

                        g.disableScissor();
                        g.popTransformation();

                        currentScene.drawAfterScale(g, g4, alpha);

                        g.end();
                    });
                });
            }
        );
    }
}

@:structInit
class GameLoopOptions {
    @:optional
    public final rngSeed: Null<Int>;

    @:optional
    public final updateFps: Null<Int>;

    public final windowTitle: String;
    public final designWidth: Int;
    public final designHeight: Int;
    public final windowMode: WindowMode;

    public final initialScene: () -> Scene;
}

enum WindowMode {
    Fullscreen;
    Windowed(?scale: Int);
    BorderlessFullscreen;
}