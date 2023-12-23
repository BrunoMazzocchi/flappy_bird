import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/pipe_position.dart';

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
    final centerY = spacing + _randomHeight.nextDouble() * (heightMinusGround - spacing);


    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(
      pipePosition: PipePosition.bottom,
      height: heightMinusGround - (centerY + spacing / 2)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    /// The pipes move from right to left.
    position.x -= gameSpeed * dt;
    /// Remove the pipes when they are out of the screen
    if (position.x < - 10) {
      removeFromParent();
    }
  }
}