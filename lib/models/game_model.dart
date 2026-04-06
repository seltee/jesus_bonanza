import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:jesus_slot/models/effect_model.dart';
import 'package:jesus_slot/models/get_win_list.dart';
import 'package:jesus_slot/models/reel_model.dart';
import 'package:jesus_slot/models/symbol.dart';
import 'package:jesus_slot/utils/provider.dart';

enum GameState { idle, spinning, displayWins }

class GameModel extends ChangeNotifier {
  late var reels = [
    GameReelModel(),
    GameReelModel(),
    GameReelModel(),
    GameReelModel(),
    GameReelModel(),
  ];

  int money = 1000;
  int bet = 10;
  final betList = [5, 10, 20, 50, 100];
  int winAmount = 0;
  GameState gameState = GameState.idle;
  List<List<Symbol>> spinResult = [];
  List<WinResult> winResult = [];
  EffectModel effectModel = EffectModel();
  double winShowTime = 0.0;
  int winIndex = 0;

  void startReels() {
    if (gameState == GameState.idle) {
      spinResult = makeResult();
      for (int i = 0; i < reels.length; i++) {
        final nextSymbols = List.generate(7, (i) => getRandomSymbol());
        nextSymbols.addAll(spinResult[i]);
        nextSymbols.add(getRandomSymbol());
        reels[i].startReel(0.07 * i, nextSymbols);
      }
      gameState = GameState.spinning;
      money -= bet;
      winAmount = 0;
      notifyListeners();
    }
  }

  void stopReels() {
    if (gameState == GameState.spinning) {
      for (int i = 0; i < reels.length; i++) {
        reels[i].stopReel(spinResult[i]);
        reels[i].update(0);
      }
      processWin();
      notifyListeners();
    }
  }

  void processWin() {
    winResult = getWinsList(spinResult, bet);

    if (winResult.isEmpty) {
      gameState = GameState.idle;
    } else {
      winAmount = winResult
          .map((win) => win.amount)
          .reduce((value, element) => value + element);

      gameState = GameState.displayWins;
      winShowTime = 3.2;
      winIndex = 0;
      money += winResult[winIndex].amount;
      playWinResult(winResult[winIndex].pattern);
    }
  }

  void playWinResult(List<int> pattern) {
    effectModel.lightPattern(pattern);
  }

  void setBet(int bet) {
    this.bet = bet;
    notifyListeners();
  }

  List<List<Symbol>> makeResult() {
    final baseSym = getRandomSymbol();
    var rng = Random();

    return List.generate(
      5,
      (_) => List.generate(3, (i) {
        if (rng.nextInt(6) == 0) {
          return baseSym;
        } else {
          return getRandomSymbol();
        }
      }).reversed.toList(),
    );
  }

  bool canPlay() {
    return money >= bet;
  }

  bool isShowingResult() {
    return gameState == GameState.displayWins;
  }

  void update(double delta) {
    switch (gameState) {
      case GameState.spinning:
        for (int i = 0; i < reels.length; i++) {
          reels[i].update(delta);
        }
        if (reels.every((reel) => reel.state == ReelState.idle)) {
          processWin();
        }
        notifyListeners();
        break;
      case GameState.displayWins:
        winShowTime -= delta;
        if (winShowTime < 0) {
          winIndex++;
          if (winIndex < winResult.length) {
            winShowTime = 3.2;
            money += winResult[winIndex].amount;
            playWinResult(winResult[winIndex].pattern);
          } else {
            gameState = GameState.idle;
          }
          notifyListeners();
        }
      default:
        break;
    }
    effectModel.update(delta);
  }
}

class GameModelProvider extends Provider<GameModel> {
  const GameModelProvider({
    super.key,
    required super.child,
    required super.model,
  });

  // Easy access via context
  static GameModel of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<GameModelProvider>();
    assert(provider != null, 'No ModelProvider found in context');
    return provider!.model;
  }
}
