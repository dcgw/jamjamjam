package net.noiseinstitute.game {
    import net.flashpunk.World;

    public class GameWorld extends World {

        public function GameWorld() {
            add(new Enemy());
        }
    }
}
