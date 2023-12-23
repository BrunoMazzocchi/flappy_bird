import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

/// Cloud component that renders a ground image. It has a parallax effect.
class Clouds extends ParallaxComponent<FlappyBirdGame>
    with HasGameRef<FlappyBirdGame> {
  /// Constructs a new cloud component.
  Clouds();

  @override
  Future<void> onLoad() async {
    final image = await Flame.images.load(clouds);
    position = Vector2(x, -(gameRef.size.y - cloudsHeight));
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(image, fill: LayerFill.none),
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = gameSpeed;
  }
}
