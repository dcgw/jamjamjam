package net.noiseinstitute.game {
    import flash.geom.Point;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.noiseinstitute.basecode.VectorMath;

    public class Enemy extends Entity {

        [Embed(source='Enemy.png')]
        private const ENEMY:Class;

        private const SPEED:Number = 3;
        private const FIRE_INTERVAL:uint = 10;

        private var _tick:uint = 0;
        private var _img:Image;
        private var _velocity:Point = new Point(0, 0);

        public function Enemy() {
            _img = new Image(ENEMY);
            _img.centerOrigin();
            _img.smooth = true;
            graphic = _img;
            layer = 100;
        }

        public function fire():void {
            var shot:EnemyShot = FP.world.create(EnemyShot) as EnemyShot;
            shot.fire(x, y, _velocity);
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

            if (_tick % FIRE_INTERVAL == 0) {
                fire();
            }

            if (!onCamera) {
                FP.world.recycle(this);
            }
        }
    }
}
