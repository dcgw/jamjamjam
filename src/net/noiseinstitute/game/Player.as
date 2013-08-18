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

        private var input:Point = new Point;
        private var velocity:Point = new Point;

        public function Player() {
            var image:Image = new Image(PLAYER_IMAGE);
            image.centerOrigin();
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

            var speed:Number = VectorMath.magnitude(velocity);
            if (speed > MAX_SPEED) {
                VectorMath.scaleInPlace(velocity, MAX_SPEED / speed);
            }

            x += velocity.x;
            y += velocity.y;
        }
    }
}
