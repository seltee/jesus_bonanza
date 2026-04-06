import 'package:flutter/material.dart';
import 'package:jesus_slot/features/screen_game.dart';
import 'package:jesus_slot/models/game_controller.dart';
import 'package:jesus_slot/models/game_model.dart';

void main() {
  runApp(GameApp());
}

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameState();
}

class _GameState extends State<GameApp> with SingleTickerProviderStateMixin {
  late GameController controller;
  late GameModel gameModel;

  @override
  void initState() {
    super.initState();

    gameModel = GameModel();
    controller = GameController(gameModel, this);
    controller.start();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameModelProvider(model: gameModel, child: Game()),
    );
  }
}
