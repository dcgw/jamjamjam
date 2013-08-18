package net.noiseinstitute.game.enemies {
    import flash.geom.Point;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.noiseinstitute.basecode.VectorMath;

    public class Enemy extends Entity {

        private const SPEED:Number = 3;

        protected var _tick:uint = 0;
        private var _img:Image;
        protected var _velocity:Point = new Point(0, 0);

        public function Enemy(img:Class) {
            _img = new Image(img);
            _img.centerOrigin();
            _img.smooth = true;
            graphic = _img;
            layer = 101;
        }

        public function fire(direction:Point):void {
            var shot:EnemyShot = FP.world.create(EnemyShot) as EnemyShot;
            shot.fire(x, y, direction);
        }

        override public function added():void {
            x = 0;
            y = 0;

            VectorMath.set(_velocity, 1, 1)
            VectorMath.setMagnitudeInPlace(_velocity, SPEED);
        }

        override public function update():void {
            super.update();

            ++_tick;

            x += _velocity.x;
            y += _velocity.y;

            _img.angle = VectorMath.angle(_velocity);

            if (!onCamera) {
                FP.world.recycle(this);
            }
        }
    }
}
