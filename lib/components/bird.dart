import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/bird_movement.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

/// This represents the player [Bird] in the game.
class Bird extends SpriteGroupComponent<BirdMovement> with HasGameRef<FlappyBirdGame>{
  /// Constructor
  Bird();

  @override
  Future<void> onLoad() async {
    final birdMidFlapSprite = await Flame.images.load(birdMidFlap);
    final birdUpFlapSprite = await Flame.images.load(birdUpFlap);
    final birdDownFlapSprite = await Flame.images.load(birdDownFlap);

    size = Vector2(50, 40);
    /// The bird starts at the middle of the screen.
    /// The size of the bird is 50x40.
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.normal;

    /// The bird can have 3 states [BirdMovement.up], [BirdMovement.down] and [BirdMovement.normal].
    sprites = {
      BirdMovement.normal: Sprite(birdMidFlapSprite),
      BirdMovement.up: Sprite(birdUpFlapSprite),
      BirdMovement.down: Sprite(birdDownFlapSprite),
    };

  }
}