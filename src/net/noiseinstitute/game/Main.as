package net.noiseinstitute.game {
    import net.flashpunk.Engine;
    import net.flashpunk.FP;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;

    [SWF(width="640", height="480", frameRate="60", backgroundColor="000000")]
    public class Main extends Engine {
        public static const WIDTH:int = 640;
        public static const HEIGHT:int = 480;

        public static const LOGIC_FPS:int = 60;

        public static const INPUT_UP:String = "up";
        public static const INPUT_DOWN:String = "down";
        public static const INPUT_LEFT:String = "left";
        public static const INPUT_RIGHT:String = "right";
        public static const INPUT_FIRE:String = "fire";

        public function Main () {
            super(WIDTH, HEIGHT, LOGIC_FPS, true);

            Input.define(INPUT_UP, Key.UP);
            Input.define(INPUT_DOWN, Key.DOWN);
            Input.define(INPUT_LEFT, Key.LEFT);
            Input.define(INPUT_RIGHT, Key.RIGHT);
            Input.define(INPUT_FIRE, Key.X);

            FP.screen.color = 0x000000;
            FP.console.enable();

            FP.world = new GameWorld();
        }
    }
}
