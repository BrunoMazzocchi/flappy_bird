import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/flappy_bird_game.dart';

void main () {

  // Create a new game instance
  final game = FlappyBirdGame();

  runApp(GameWidget(game: game)); // game is your instance of Game
}