package net.noiseinstitute.game {
    import net.flashpunk.FP;
    import net.noiseinstitute.game.enemies.Enemy;

    public class Wave {

        private var _tick:uint;
        private var _startTick:int = 0;
        private var _index:uint = 0;
        private var _enemies:Array = [];

        function Wave(startTick:int) {
            _startTick = startTick;
        }

        public static function at(tick:uint):Wave {
            return new Wave(tick);
        }

        public function withEnemy(tick:uint, enemy:Class, params:Object = null):Wave {
            _enemies.push({
                tick: tick,
                enemy: enemy,
                params: params
            });

            return this;
        }

        public function update():void {
            ++_tick;

            while(_index < _enemies.length && _tick == (_startTick + _enemies[_index].tick)) {
                var enemy:Enemy  = FP.world.create(_enemies[_index].enemy) as Enemy;
                enemy.spawn(_enemies[_index].params);
                ++_index;
            }
        }
    }
}
