package net.noiseinstitute.game.enemies {
    import net.noiseinstitute.game.*;
    import flash.geom.Point;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.noiseinstitute.basecode.VectorMath;

    public class Enemy extends Entity {

        [Embed(source='Enemy.png')]
        private const ENEMY:Class;

        private const SPEED:Number = 3;
        private const FIRE_INTERVAL:uint = 5;
        private const VOLLEY_INTERVAL:uint = 50;
        private const VOLLEY_SIZE:int = 3;

        private var _tick:uint = 0;
        private var _img:Image;
        private var _velocity:Point = new Point(0, 0);
        private var _shotsFired:int = 0;

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

            if(_tick % VOLLEY_INTERVAL == 0) {
                _shotsFired = 0;
            }
            if (_tick % FIRE_INTERVAL == 0 && _shotsFired < VOLLEY_SIZE) {
                ++_shotsFired;
                fire();
            }

            if (!onCamera) {
                FP.world.recycle(this);
            }
        }
    }
}
