import 'package:flappy_bird/game/assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

/// Main menu screen of the game. This screen is shown when the game starts.
class MainMenuScreen extends StatelessWidget {
  /// Constructs a new main menu screen.
  const MainMenuScreen({
    Key? key,
    required this.game,
  }) : super(key: key);

  /// The game instance.
  final FlappyBirdGame game;

  /// The id of the screen.
  static const String id = 'mainMenu';

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove('mainMenu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(menu),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(message),
        ),
      ),
    );
  }
}
