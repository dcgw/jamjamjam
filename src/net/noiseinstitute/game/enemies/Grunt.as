package net.noiseinstitute.game.enemies {
    import net.noiseinstitute.basecode.VectorMath;

    public class Grunt extends Enemy {

        [Embed(source='Grunt.png')]
        private const GRUNT:Class;

        private const FIRE_INTERVAL:uint = 5;
        private const VOLLEY_INTERVAL:uint = 50;
        private const VOLLEY_SIZE:int = 3;
        private const SPEED:Number = 3;

        private var _shotsFired:int = 0;

        public function Grunt() {
            super(GRUNT);
        }

        override public function added():void {
            x = 0;
            y = 30;

            VectorMath.becomePolar(_velocity, 200, SPEED);
        }

        override public function update():void {
            super.update();

            VectorMath.rotateInPlace(_velocity, 0.2);

            if(_tick % VOLLEY_INTERVAL == 0) {
                _shotsFired = 0;
            }
            if (_tick % FIRE_INTERVAL == 0 && _shotsFired < VOLLEY_SIZE) {
                ++_shotsFired;
                fire(_velocity);
            }
        }
    }
}
