package net.noiseinstitute.game.enemies {
    import flash.geom.Point;

    import net.flashpunk.tweens.misc.VarTween;

    import net.noiseinstitute.basecode.VectorMath;

    public class Boss extends Enemy {

        [Embed(source='Boss.png')]
        private const BOSS:Class;

        private const STATE_WAIT:int = -1;
        private const STATE_MOVE:int = 0;
        private const STATE_BURST:int = 1;
        private const STATE_FLOWER:int = 2;

        private const BURST_DIRECTIONS:Number = 20;
        private const BURST_ARC:Number = 220;
        private const BURST_MAX_VOLLEYS:int = 3;

        private const FLOWER_DIRECTIONS:Number = 5;
        private const FLOWER_MAX_SHOTS:int = 121;

        private const FIRE_INTERVAL:uint = 4;
        private const VOLLEY_INTERVAL:uint = 120;
        private const VOLLEY_SIZE:int = 24;
        private const SPEED:Number = 2;

        private var _state:int = STATE_MOVE;
        private var _stateTransitionFn:Function;
        private var _stateTransitionTime:uint = 0;
        private var _shotsFired:int = 0;
        private var _volleysFired:int = 0;
        private var _fireDirection:Point = new Point(0, 1);
        private var _contraFireDirection:Point = new Point(0, 1);

        public function Boss() {
            super(BOSS);
        }

        override public function spawn(params:Object):void {
            x = 320;
            y = 0;

            VectorMath.set(_velocity, 0, SPEED);

            var stopTween:VarTween = new VarTween();
            stopTween.tween(_velocity, "y", 0, 140);
            stopTween.complete = transitionBurst;
            addTween(stopTween, true);
        }

        public function transition(fn:Function, time:uint):void {
            _state = STATE_WAIT;
            _tick = 0;
            _stateTransitionFn = fn;
            _stateTransitionTime = time;
        }

        public function transitionBurst():void {
            _volleysFired = 0;
            _tick = 0;
            _state = STATE_BURST;
        }

        public function transitionFlower():void {
            _tick = 0;
            _shotsFired = 0;
            _state = STATE_FLOWER;
        }

        override public function update():void {
            super.update();

            if(_state == STATE_WAIT) {
                if(_tick == _stateTransitionTime) {
                    _stateTransitionFn();
                }
            }

            if(_state == STATE_BURST) {
                // After three volleys, transition to flower fire
                if(_volleysFired >= BURST_MAX_VOLLEYS) {
                    transition(transitionFlower, 100);
                } else {
                    updateBurst();
                }

            }

            if(_state == STATE_FLOWER) {
                // After 300 ticks in flower fire, transition to burst fire
                if(_shotsFired > FLOWER_MAX_SHOTS) {
                    transition(transitionBurst, 120);
                } else {
                    updateFlower();
                }
            }
        }

        private function updateBurst():void {
            if(_tick % VOLLEY_INTERVAL == 0) {
                _shotsFired = 0;
            }
            if (_tick % FIRE_INTERVAL == 0 && _shotsFired < VOLLEY_SIZE && _volleysFired < BURST_MAX_VOLLEYS) {
                ++_shotsFired;
                VectorMath.becomeUnitVector(_fireDirection, 180 - BURST_ARC/2);

                for(var i:int = 0; i <= BURST_DIRECTIONS; i++) {
                    fire(_fireDirection, SmallEnemyShot);
                    VectorMath.rotateInPlace(_fireDirection, BURST_ARC/BURST_DIRECTIONS);
                }

                if(_shotsFired == VOLLEY_SIZE) {
                    ++_volleysFired;
                }
            }
        }

        private function updateFlower():void {
            if (_tick % FIRE_INTERVAL == 0) {
                ++_shotsFired;
                VectorMath.rotateInPlace(_fireDirection, 6);
                VectorMath.rotateInPlace(_contraFireDirection, -6);

                for(var i:int = 0; i < FLOWER_DIRECTIONS; i++) {
                    fire(_fireDirection, LargeEnemyShot);
                    VectorMath.rotateInPlace(_fireDirection, 360/FLOWER_DIRECTIONS);
                    fire(_contraFireDirection, LargeEnemyShot);
                    VectorMath.rotateInPlace(_contraFireDirection, 360/FLOWER_DIRECTIONS);
                }
            }
        }
    }
}
