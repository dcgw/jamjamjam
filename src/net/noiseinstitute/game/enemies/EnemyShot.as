package net.noiseinstitute.game.enemies {
    import flash.geom.Point;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.noiseinstitute.basecode.VectorMath;

    public class EnemyShot extends Entity {

        private var _speed:Number = 0;
        private var _velocity:Point = new Point(0, 0);

        public function EnemyShot(bitmap:Class, size:Number, speed:Number) {
            var img:Image = new Image(bitmap);
            img.centerOrigin();
            graphic = img;
            setHitbox(size, size, size/2, size/2);
            layer = 200;
            _speed = speed;
        }

        public function fire(x:Number, y:Number, direction:Point):void {
            this.x = x;
            this.y = y;
            VectorMath.copyTo(_velocity, direction);
            VectorMath.setMagnitudeInPlace(_velocity, _speed);
        }

        override public function update():void {
            super.update();

            x += _velocity.x;
            y += _velocity.y;

            if (!onCamera) {
                FP.world.recycle(this);
            }
        }
    }
}
