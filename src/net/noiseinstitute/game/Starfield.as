package net.noiseinstitute.game {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BitmapDataChannel;
    import flash.display.BlendMode;
    import flash.geom.ColorTransform;
    import flash.geom.Point;

    import net.flashpunk.Graphic;
    import net.noiseinstitute.basecode.Static;

    public class Starfield extends Graphic {
        [Embed("Palette.png")]
        private static const PALETTE_IMAGE:Class;

        [Embed("Star.png")]
        private static const STAR_IMAGE:Class;

        private static const NUM_STARS = 64;
        private static const MIN_SPEED = 100 / Main.LOGIC_FPS;
        private static const MAX_SPEED = 400 / Main.LOGIC_FPS;

        private var palette:Vector.<uint>;

        private var starBitmapData:BitmapData;
        private var starBitmap:Bitmap;

        private var colorTransform:ColorTransform;

        private var stars:Vector.<Star>;

        public function Starfield() {
            var paletteImage:BitmapData = new PALETTE_IMAGE().bitmapData;
            palette = paletteImage.getVector(paletteImage.rect);

            var starSource:BitmapData = new STAR_IMAGE().bitmapData;
            starBitmapData = new BitmapData(starSource.width, starSource.height, true, 0xffffffff);
            starBitmapData.copyChannel(starSource, starSource.rect, Static.origin,
                    BitmapDataChannel.RED, BitmapDataChannel.ALPHA);

            starBitmap = new Bitmap(starBitmapData);

            colorTransform = new ColorTransform;

            stars = new <Star>[];
            for (var i:int = 0; i < NUM_STARS; ++i) {
                var star:Star = new Star;
                randomizeStar(star);
                star.y = Math.random() * (starBitmapData.height + Main.HEIGHT) - starBitmapData.height;
                stars[i] = star;
            }
        }

        private function randomizeStar(star:Star):void {
            star.x = Math.random() * Main.WIDTH;
            star.speed = MIN_SPEED + Math.random() * (MAX_SPEED - MIN_SPEED);
            star.color = palette[int(Math.random() * palette.length)];
        }

        override public function render(target:BitmapData, point:Point, camera:Point):void {
            for (var i:int = 0; i < NUM_STARS; ++i) {
                var star:Star = stars[i];
                star.y += star.speed;

                if (star.y > Main.HEIGHT + starBitmapData.height) {
                    randomizeStar(star);
                    star.y -= (Main.HEIGHT + starBitmapData.height);
                }

                colorTransform.redMultiplier = ((star.color >> 16) & 0xff) / 0xff;
                colorTransform.greenMultiplier = ((star.color >> 8) & 0xff) / 0xff;
                colorTransform.blueMultiplier = (star.color & 0xff) / 0xff;

                Static.matrix.identity();
                Static.matrix.tx = star.x - starBitmapData.width * 0.5;
                Static.matrix.ty = star.y;
                target.draw(starBitmap, Static.matrix, colorTransform, BlendMode.ADD);
            }
        }
    }
}
