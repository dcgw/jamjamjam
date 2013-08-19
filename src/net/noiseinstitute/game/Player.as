package net.noiseinstitute.game {
    import flash.geom.Point;

    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.utils.Input;
    import net.noiseinstitute.basecode.Static;
    import net.noiseinstitute.basecode.VectorMath;

    public class Player extends Entity {
        [Embed(source="Player.png")]
        private static const PLAYER_IMAGE:Class;

        private static const ACCELERATION:Number = 6000 / Main.LOGIC_FPS / Main.LOGIC_FPS;
        private static const DRAG:Number = 4000 / Main.LOGIC_FPS / Main.LOGIC_FPS;
        private static const MAX_SPEED:Number = 500 / Main.LOGIC_FPS;
        private static const MAX_SPEED_IN_FOCUS:Number = 200 / Main.LOGIC_FPS;

        private static const FOCUS_HOLD_TICKS:int = 300 / Main.LOGIC_FPS;

        private static const MIN_SCALE:Number = 0.8;
        private static const MAX_SCALE:Number = 1;
        private static const SCALE_SMOOTHING_FACTOR:Number = 0.2;

        private var image:Image;
        private var scaleX:Number = 1;
        private var scaleY:Number = 1;

        private var input:Point = new Point;
        private var velocity:Point = new Point;

        private var fireHeldTicks:int = 0;

        public function Player() {
            image = new Image(PLAYER_IMAGE);
            image.centerOrigin();
            image.smooth = true;
            graphic = image;
        }

        override public function update():void {
            super.update();

            input.x = 0;
            input.y = 0;

            if (Input.check(Main.INPUT_LEFT)) {
                --input.x;
            }

            if (Input.check(Main.INPUT_RIGHT)) {
                ++input.x;
            }

            if (Input.check(Main.INPUT_UP)) {
                --input.y;
            }

            if (Input.check(Main.INPUT_DOWN)) {
                ++input.y;
            }

            if (VectorMath.magnitude(input) == 0) {
                VectorMath.copyTo(Static.point, velocity);
                VectorMath.setMagnitudeInPlace(Static.point, DRAG);

                if (Math.abs(Static.point.x) > Math.abs(velocity.x)) {
                    velocity.x = 0;
                } else {
                    velocity.x -= Static.point.x
                }

                if (Math.abs(Static.point.y) > Math.abs(velocity.y)) {
                    velocity.y = 0;
                } else {
                    velocity.y -= Static.point.y
                }
            } else {
                VectorMath.setMagnitudeInPlace(input, ACCELERATION);
                VectorMath.addTo(velocity, input);
            }

            if (Input.check(Main.INPUT_FIRE)) {
                ++fireHeldTicks;
            } else {
                fireHeldTicks = 0;
            }

            var maxSpeed:Number;
            if (fireHeldTicks >= FOCUS_HOLD_TICKS) {
                maxSpeed = MAX_SPEED_IN_FOCUS;
            } else {
                maxSpeed = MAX_SPEED;
            }

            var speed:Number = VectorMath.magnitude(velocity);
            if (speed > maxSpeed) {
                VectorMath.scaleInPlace(velocity, maxSpeed / speed);
            }

            x += velocity.x;
            y += velocity.y;

            var scaleTargetX:Number = MIN_SCALE + Math.abs(velocity.x) * (MAX_SCALE - MIN_SCALE) / MAX_SPEED;
            var scaleTargetY:Number = MIN_SCALE + Math.abs(velocity.y) * (MAX_SCALE - MIN_SCALE) / MAX_SPEED;
            scaleX = scaleTargetX * SCALE_SMOOTHING_FACTOR + scaleX * (1 - SCALE_SMOOTHING_FACTOR);
            scaleY = scaleTargetY * SCALE_SMOOTHING_FACTOR + scaleY * (1 - SCALE_SMOOTHING_FACTOR);

            image.scaleX = scaleX;
            image.scaleY = scaleY;
        }
    }
}
