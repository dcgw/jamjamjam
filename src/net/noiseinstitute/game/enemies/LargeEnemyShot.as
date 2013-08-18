package net.noiseinstitute.game.enemies {
    public class LargeEnemyShot extends EnemyShot {

        [Embed(source='LargeEnemyShot.png')]
        private const LARGE_ENEMY_SHOT:Class;

        public function LargeEnemyShot() {
            super(LARGE_ENEMY_SHOT, 16, 3);
        }
    }
}
