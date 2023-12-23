import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/pipe_position.dart';

import '../game/assets.dart';

/// This class groups the pipes together. It is responsible for creating the
/// obstacles
class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  /// Constructor
  PipeGroup();

  /// Random height of the gap between the pipes
  final _randomHeight = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - groundHeight;
    final spacing = 100 + _randomHeight.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + _randomHeight.nextDouble() * (heightMinusGround - spacing);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(
          pipePosition: PipePosition.bottom,
          height: heightMinusGround - (centerY + spacing / 2)),
    ]);
  }

  /// Updates the score when the bird passes the pipes
  Future<void> updateScore() async {
    gameRef.bird.score += 1;
    FlameAudio.play(point);
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);
    position.x -= gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }

    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }
}
