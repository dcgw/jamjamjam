package net.noiseinstitute.game {
    import net.flashpunk.World;
    import net.noiseinstitute.game.enemies.Grunt;
    import net.noiseinstitute.game.enemies.Gunner;

    public class GameWorld extends World {

        private var _waves:Vector.<Wave> = new Vector.<Wave>();

        public function GameWorld() {
            addGraphic(new Starfield);

            _waves.push(Wave.at(50)
                    .withEnemy(0, Grunt, {left: true})
                    .withEnemy(0, Grunt, {left: false})
                    .withEnemy(30, Gunner)
                    .withEnemy(60, Grunt, {left: true})
                    .withEnemy(60, Grunt, {left: false}));
        }

        override public function update():void {
            super.update();

            for each(var wave:Wave in _waves) {
                wave.update();
            }
        }
    }
}
