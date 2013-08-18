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

        private static const NUM_STARS:int = 64;
        private static const MIN_SPEED:Number = 100 / Main.LOGIC_FPS;
        private static const MAX_SPEED:Number = 400 / Main.LOGIC_FPS;

        private static const DISTANCE_BRIGHTNESS_VARIANCE:Number = 0.4;

        private static const GLOW_MIN_FREQUENCY:Number = 0.1;
        private static const GLOW_MAX_FREQUENCY:Number = 0.6;
        private static const GLOW_BRIGHTNESS_AMPLITUDE:Number = 0.3;

        private var tick:int;

        private var palette:Vector.<uint>;

        private var starBitmapData:BitmapData;
        private var starBitmap:Bitmap;

        private var colorTransform:ColorTransform;

        private var stars:Vector.<Star>;

        public function Starfield() {
            active = true;
            tick = 0;

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
            star.distance = Math.random();
            star.color = palette[int(Math.random() * palette.length)];
            star.glowFrequency = GLOW_MIN_FREQUENCY + Math.random() * (GLOW_MAX_FREQUENCY - GLOW_MIN_FREQUENCY);
            star.glowIntensity = Math.random();
            star.glowPhaseOffset = Math.random();
        }

        override public function update():void {
            ++tick;
        }

        override public function render(target:BitmapData, point:Point, camera:Point):void {
            for (var i:int = 0; i < NUM_STARS; ++i) {
                var star:Star = stars[i];
                star.y += MIN_SPEED + (1 - star.distance) * (MAX_SPEED - MIN_SPEED);

                if (star.y > Main.HEIGHT + starBitmapData.height) {
                    randomizeStar(star);
                    star.y -= (Main.HEIGHT + starBitmapData.height);
                }

                colorTransform.redMultiplier = ((star.color >> 16) & 0xff) / 0xff;
                colorTransform.greenMultiplier = ((star.color >> 8) & 0xff) / 0xff;
                colorTransform.blueMultiplier = (star.color & 0xff) / 0xff;

                var glowPosition:Number = star.glowPhaseOffset
                        + tick / Main.LOGIC_FPS * star.glowFrequency * (Math.PI * 2);
                colorTransform.alphaMultiplier = 1 - (star.distance * DISTANCE_BRIGHTNESS_VARIANCE)
                        - (Math.sin(glowPosition) * GLOW_BRIGHTNESS_AMPLITUDE * star.glowIntensity);

                Static.matrix.identity();
                Static.matrix.tx = star.x - starBitmapData.width * 0.5;
                Static.matrix.ty = star.y;
                target.draw(starBitmap, Static.matrix, colorTransform, BlendMode.ADD);
            }
        }
    }
}
