import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe_group.dart';

import 'configuration.dart';

/// This is the entry point of your game.
class FlappyBirdGame extends FlameGame {
  /// The late bird player
  late Bird bird;
  /// Timer to spawn the pipes
  Timer interval = Timer(pipeInterval, repeat: true);

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      bird = Bird(),
      Ground(),
    ]);

    /// The interval timer will spawn a new pipe group every 1.5 seconds.
    interval.onTick = () {
      add(PipeGroup());
    };
  }

  @override
  void update(double dt) {
    super.update(dt);

    interval.update(dt);
  }
}
