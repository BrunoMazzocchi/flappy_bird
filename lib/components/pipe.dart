import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/configuration.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/game/pipe_position.dart';

/// This represents the pipes in the game. The pipes are the obstacles that the
/// bird has to avoid.
class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame> {

  /// Constructs a new pipe component.
  Pipe({
    required this.pipePosition,
    required this.height,
  });

  @override
  /// Height of the pipe
  final double height;
  /// The pipe can be in 2 positions [PipePosition.top] or [PipePosition.bottom].
  final PipePosition pipePosition;

  @override
  Future<void> onLoad () async {
    final pipeSprite = await Flame.images.load(pipe);
    final rotatedPipeSprite = await Flame.images.load(pipeRotated);

    size = Vector2(50, height);

    switch(pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(rotatedPipeSprite);
        break;
      case PipePosition.bottom:
        position.y  = gameRef.size.y - size.y - groundHeight;
        sprite = Sprite(pipeSprite);
        break;
    }

    add(RectangleHitbox());
  }


}