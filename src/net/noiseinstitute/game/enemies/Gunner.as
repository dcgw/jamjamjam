/**
 * Created with IntelliJ IDEA.
 * User: Zutty
 * Date: 18/08/2013
 * Time: 17:16
 * To change this template use File | Settings | File Templates.
 */
package net.noiseinstitute.game.enemies {
    import flash.geom.Point;

    import net.noiseinstitute.basecode.VectorMath;

    public class Gunner extends Enemy {

        [Embed(source='Gunner.png')]
        private const GUNNER:Class;

        private const FIRE_INTERVAL:uint = 3;

        private var _fireDirection:Point = new Point();

        public function Gunner() {
            super(GUNNER);
        }

        override public function added():void {
            super.added();

            VectorMath.copyTo(_fireDirection, _velocity);
        }

        override public function update():void {
            super.update();

            if (_tick % FIRE_INTERVAL == 0) {
                VectorMath.rotateInPlace(_fireDirection, 5);

                for(var i:int = 0; i <= 6; i++) {
                    VectorMath.rotateInPlace(_fireDirection, 60);
                    fire(_fireDirection);
                }
            }
        }
    }
}
