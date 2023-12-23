import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

/// Background component that renders a background image.
class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  /// Creates a new background component.
  Background();

  @override
  Future<void> onLoad() async {
    final backgroundSprite = await Flame.images.load(background);
    size = gameRef.size;
    sprite = Sprite(backgroundSprite);
  }
}