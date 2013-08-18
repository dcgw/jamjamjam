package net.noiseinstitute.game {
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;

    public class Enemy extends Entity {

        [Embed(source='Enemy.png')]
        private const ENEMY:Class;

        private var _tick:uint = 0;
        private var _img:Image;

        public function Enemy() {
            _img = new Image(ENEMY);
            _img.centerOrigin();
            _img.smooth = true;
            graphic = _img;
        }

        override public function update():void {
            super.update();

            ++_tick;

            x = 320 + Math.cos(_tick / 20) * 120;
            y = 240 + Math.sin(_tick / 20) * 120;

            _img.angle = ((_tick/20) * FP.DEG) + 180;
        }
    }
}
