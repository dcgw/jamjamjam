package net.noiseinstitute.game {
    import flash.geom.Point;

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;
    import net.noiseinstitute.basecode.VectorMath;

    public class EnemyShot extends Entity {

        [Embed(source='EnemyShot.png')]
        private const ENEMY_SHOT:Class;

        private const SPEED:Number = 15;

        private var _velocity:Point = new Point(0, 0);

        public function EnemyShot() {
            var img = new Image(ENEMY_SHOT);
            img.centerOrigin();
            graphic = img;
            setHitbox(20, 20, 10, 10);
            layer = 200;
        }

        public function fire(x:Number, y:Number, direction:Point) {
            this.x = x;
            this.y = y;
            _velocity.x = direction.x;
            _velocity.y = direction.y;
            VectorMath.normalizeInPlace(_velocity);
            VectorMath.scaleInPlace(_velocity, SPEED);
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
