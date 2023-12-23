import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

/// Ground component that renders a ground image. It has a parallax effect.
/// that makes it look like the bird is moving.
class Ground extends ParallaxComponent<FlappyBirdGame>  with HasGameRef<FlappyBirdGame>{
  /// Constructs a new ground component.
  Ground();

  @override
  Future<void> onLoad() async {
    final groundSprite = await Flame.images.load(ground);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(groundSprite, fill: LayerFill.none),
      )
    ]);
  }

  @override
  /// Updates the sprite with the delta time got from the game's configuration file
  void update(double dt) {
    super.update(dt);
    // Assigns the speed of the ground to the game's speed
    parallax?.baseVelocity.x = gameSpeed;
  }
}