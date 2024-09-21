
/**
 * Represents a *state* of your game. You can `override` the following functions.
 * 
 * - `update()`: Runs every frame, use it to update game logic.
 * - `draw(g, g4, alpha)`: Use it to draw core game elements.
 *     - `g`: Use this to draw 2D stuff, images, etc.
 *     - `g4`: Use this to work with shaders, 3D and other advanced stuff.
 *     - `alpha`: This is used to make the game look nice on high refresh rate display. Pass it along to every other `draw()`-like function, but no need to use it until the polishing phase of the game. 
 * 
 * The following, more advanced functions are also available:
 * 
 * - `drawBackground(g, g4, alpha)`: This runs before `draw()` and before scaling/cropping is applied. Use this to draw full-window backgrounds, regardless of the `designSize`. Use `Screen.windowWidth`/`Screen.windowHeight` to get the actual viewport size.
 * - `drawAfterScale(g, g4, alpha)`: This runs after `draw()` and **after** scaling is active. Use this to draw **full-resolution, unscaled** elements on top of the game *(like UI)*. Use `Screen.windowWidth`/`Screen.windowHeight` to get the actual viewport size.
 * 
 * Here's a small table on how to access the appropriate sizes for the drawing functions:
 * 
 * | Draw. Fn.          | Width                | Height                |
 * |--------------------|----------------------|-----------------------|
 * | `draw()`           | `Screen.designWidth` | `Screen.designHeight` |
 * | `drawBackground()` | `Screen.windowWidth` | `Screen.windowHeight` |
 * | `drawAfterScale()` | `Screen.windowWidth` | `Screen.windowHeight` |
 * 
 * `Screen.scale` is also useful for getting the scaling factor of `draw()` in unscaled contexts, so you can adjust *e.g.* **font size** based on how large the game itself is.
 */
abstract class Scene {
    public function update() {}
    public function drawBackground(g: G2, g4: G4, alpha: Float) {}
    public function draw(g: G2, g4: G4, alpha: Float) {}
    public function drawAfterScale(g: G2, g4: G4, alpha: Float) {}
}
