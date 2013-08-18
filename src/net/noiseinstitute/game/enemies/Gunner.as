package net.noiseinstitute.game.enemies {
    import flash.geom.Point;

    import net.noiseinstitute.basecode.VectorMath;

    public class Gunner extends Enemy {

        [Embed(source='Gunner.png')]
        private const GUNNER:Class;

        private const FIRE_INTERVAL:uint = 3;
        private const VOLLEY_INTERVAL:uint = 100;
        private const VOLLEY_SIZE:int = 15;
        private const SPEED:Number = 1.5;

        private var _shotsFired:int = 0;
        private var _fireDirection:Point = new Point();

        public function Gunner() {
            super(GUNNER);
        }

        override public function spawn(params:Object):void {
            x = 320;
            y = 0;

            VectorMath.set(_velocity, 0, SPEED);

            VectorMath.copyTo(_fireDirection, _velocity);
        }

        override public function update():void {
            super.update();

            if(_tick % VOLLEY_INTERVAL == 0) {
                _shotsFired = 0;
            }
            if (_tick % FIRE_INTERVAL == 0 && _shotsFired < VOLLEY_SIZE) {
                ++_shotsFired;
                VectorMath.rotateInPlace(_fireDirection, 6);

                for(var i:int = 0; i <= 6; i++) {
                    VectorMath.rotateInPlace(_fireDirection, 60);
                    fire(_fireDirection);
                }
            }
        }
    }
}
