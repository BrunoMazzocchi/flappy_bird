import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/bird_movement.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/animation.dart';

/// This represents the player [Bird] in the game.
class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
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

    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += birdVelocity * dt;
  }

  @override
  Future<void> onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) async {
    super.onCollisionStart(intersectionPoints, other);

    gameOver();
  }

  /// When the bird collides with a pipe or the ground, the game is over.
  Future<void> gameOver() async {
    FlameAudio.play(collision);
    gameRef.pauseEngine();
  }

  /// When the player taps the screen, the bird will move up.
  Future<void> fly() async {
    add(
      MoveByEffect(
        Vector2(0, gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );
    FlameAudio.play(flying);
    current = BirdMovement.up;
  }
}
