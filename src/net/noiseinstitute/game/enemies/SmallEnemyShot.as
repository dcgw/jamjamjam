package net.noiseinstitute.game.enemies {
    public class SmallEnemyShot extends EnemyShot {

        [Embed(source='SmallEnemyShot.png')]
        private const SMALL_ENEMY_SHOT:Class;

        public function SmallEnemyShot() {
            super(SMALL_ENEMY_SHOT, 8, 7);
        }
    }
}
