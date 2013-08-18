package net.noiseinstitute.game {
    import net.flashpunk.World;
    import net.noiseinstitute.game.enemies.Enemy;

    public class GameWorld extends World {

        private var _waves:Vector.<Wave> = new Vector.<Wave>();

        public function GameWorld() {
            _waves.push(Wave.at(50)
                    .withEnemy(0, Enemy)
                    .withEnemy(30, Enemy)
                    .withEnemy(60, Enemy));
        }

        override public function update():void {
            super.update();

            for each(var wave:Wave in _waves) {
                wave.update();
            }
        }
    }
}
