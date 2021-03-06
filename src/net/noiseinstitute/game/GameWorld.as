package net.noiseinstitute.game {
    import net.flashpunk.World;
    import net.noiseinstitute.game.enemies.Boss;
    import net.noiseinstitute.game.enemies.Dart;
    import net.noiseinstitute.game.enemies.Grunt;
    import net.noiseinstitute.game.enemies.Gunner;

    public class GameWorld extends World {

        private var _waves:Vector.<Wave> = new Vector.<Wave>();

        private var player:Player;

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

            _waves.push(Wave.at(950)
                    .withEnemy(0, Boss)
            );

            player = new Player;
            player.x = Main.WIDTH * 0.5;
            player.y = Main.HEIGHT * 0.8;
            add(player);
        }

        override public function update():void {
            super.update();

            for each(var wave:Wave in _waves) {
                wave.update();
            }
        }
    }
}
