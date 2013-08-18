package net.noiseinstitute.game {
    import net.flashpunk.FP;

    public class Wave {

        private var _tick:uint;
        private var _startTick = 0;
        private var _index:uint = 0;
        private var _enemies:Array = [];

        function Wave(startTick) {
            _startTick = startTick;
        }

        public static function at(tick:uint) {
            return new Wave(tick);
        }

        public function withEnemy(tick:uint, enemy:Class):Wave {
            _enemies.push({
                tick: tick,
                enemy: enemy
            });

            return this;
        }

        public function update():void {
            ++_tick;

            if(_index < _enemies.length && _tick == (_startTick + _enemies[_index].tick)) {
                FP.world.create(_enemies[_index].enemy);
                ++_index;
            }
        }
    }
}
