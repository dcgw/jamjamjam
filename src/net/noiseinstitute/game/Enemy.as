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

        private var _tick:uint = 0;
        private var _img:Image;
        private var _velocity:Point = new Point(0, 0);

        public function Enemy() {
            _img = new Image(ENEMY);
            _img.centerOrigin();
            _img.smooth = true;
            graphic = _img;
        }

        override public function added():void {
            x = 0;
            y = 0;

            _velocity.x = 1;
            _velocity.y = 1;

            VectorMath.normalizeInPlace(_velocity);
            VectorMath.scaleInPlace(_velocity, SPEED);
        }

        override public function update():void {
            super.update();

            ++_tick;

            x += _velocity.x;
            y += _velocity.y;

            _img.angle = VectorMath.angle(_velocity);

            if(!onCamera) {
                FP.world.recycle(this);
            }
        }
    }
}
