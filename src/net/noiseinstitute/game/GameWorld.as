package net.noiseinstitute.game {
    import net.flashpunk.World;
    import net.noiseinstitute.game.enemies.Dart;
    import net.noiseinstitute.game.enemies.Grunt;
    import net.noiseinstitute.game.enemies.Gunner;

    public class GameWorld extends World {

        private var _waves:Vector.<Wave> = new Vector.<Wave>();

        public function GameWorld() {
            addGraphic(new Starfield);

            _waves.push(Wave.at(10)
                    .withEnemy(0, Dart, {left:true})
                    .withEnemy(25, Dart, {left:true})
                    .withEnemy(50, Dart, {left:true})
            );

            _waves.push(Wave.at(200)
                    .withEnemy(0, Dart, {left:false})
                    .withEnemy(25, Dart, {left:false})
                    .withEnemy(50, Dart, {left:false})
            );

            _waves.push(Wave.at(420)
                    .withEnemy(0, Grunt, {left:true})
                    .withEnemy(0, Grunt, {left:false})
                    .withEnemy(30, Gunner)
                    .withEnemy(60, Grunt, {left:true})
                    .withEnemy(60, Grunt, {left:false})
            );
        }

        override public function update():void {
            super.update();

            for each(var wave:Wave in _waves) {
                wave.update();
            }
        }
    }
}
