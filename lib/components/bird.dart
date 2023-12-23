import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
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

  /// The bird's score.
  int score = 0;

  @override
  Future<void> onLoad() async {
    final birdMidFlapSprite = await gameRef.loadSprite(birdMidFlap);
    final birdUpFlapSprite = await gameRef.loadSprite(birdUpFlap);
    final birdDownFlapSprite = await gameRef.loadSprite(birdDownFlap);

    gameRef.bird;

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    current = BirdMovement.normal;
    sprites = {
      BirdMovement.normal: birdMidFlapSprite,
      BirdMovement.up: birdUpFlapSprite,
      BirdMovement.down: birdDownFlapSprite,
    };

    add(CircleHitbox());
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
    position.y += birdVelocity * dt;
    if (position.y < 1) {
      gameOver();
    }
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

  @override
  Future<void> onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) async {
    super.onCollisionStart(intersectionPoints, other);

    gameOver();
  }

  /// Resets the bird to its initial position and score.
  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    score = 0;
  }

  /// When the bird collides with a pipe or the ground, the game is over.
  Future<void> gameOver() async {
    FlameAudio.play(collision);
    game.isHit = true;
    gameRef.overlays.add('gameOver');
    gameRef.pauseEngine();
  }
}
