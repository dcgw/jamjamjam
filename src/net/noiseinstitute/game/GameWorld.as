package net.noiseinstitute.game {
    import net.flashpunk.World;
    import net.noiseinstitute.game.enemies.Grunt;

    public class GameWorld extends World {

        private var _waves:Vector.<Wave> = new Vector.<Wave>();

        public function GameWorld() {
            _waves.push(Wave.at(50)
                    .withEnemy(0, Grunt)
                    .withEnemy(30, Grunt)
                    .withEnemy(60, Grunt));
        }

        override public function update():void {
            super.update();

            for each(var wave:Wave in _waves) {
                wave.update();
            }
        }
    }
}
