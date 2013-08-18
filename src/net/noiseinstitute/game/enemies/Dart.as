/**
 * Created with IntelliJ IDEA.
 * User: Zutty
 * Date: 18/08/2013
 * Time: 18:28
 * To change this template use File | Settings | File Templates.
 */
package net.noiseinstitute.game.enemies {
    import flash.geom.Point;

    import net.noiseinstitute.basecode.VectorMath;

    public class Dart extends Enemy {

        [Embed(source='Dart.png')]
        private const DART:Class;

        private const FIRE_INTERVAL:uint = 15;
        private const VOLLEY_INTERVAL:uint = 80;
        private const VOLLEY_SIZE:int = 3;
        private const SPEED:Number = 5;

        private var _shotsFired:int = 0;
        private var _fireDirection:Point = new Point(0, 1);

        public function Dart() {
            super(DART);
        }

        override public function spawn(params:Object):void {
            x = params.left ? 0 : 640;
            y = 240;

            VectorMath.becomePolar(_velocity, params.left ? 270 : 90, SPEED);
        }

        override public function update():void {
            super.update();

            if(_tick % VOLLEY_INTERVAL == 0) {
                _shotsFired = 0;
            }
            if (_tick % FIRE_INTERVAL == 0 && _shotsFired < VOLLEY_SIZE) {
                ++_shotsFired;
                fire(_fireDirection);
            }
        }
    }
}
