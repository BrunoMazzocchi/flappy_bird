import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/clouds.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe_group.dart';
import 'package:flutter/material.dart';

import 'configuration.dart';

/// This is the entry point of your game.
class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  /// The late bird player
  late Bird bird;

  /// Timer to spawn the pipes
  Timer interval = Timer(pipeInterval, repeat: true);

  /// Tracks if it was hit
  bool isHit = false;

  /// Text component to render the score
  late TextComponent score;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      Clouds(),
      bird = Bird(),
      score = buildScore(),
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  /// Renders the score on the screen
  TextComponent buildScore() => TextComponent(
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 40, fontFamily: 'Game', fontWeight: FontWeight.bold),
      ));

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';
  }

  @override
  Future<void> onTap() async {
    bird.fly();
  }
}
