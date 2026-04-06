import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:jesus_slot/models/symbol.dart';

enum ReelState { idle, waiting, spinning, stopping }

class GameReelModel extends ChangeNotifier {
  final symbols = List.generate(
    4,
    (i) => GameReelSymbolModel(symbol: getRandomSymbol(), index: i),
  );
  List<Symbol> nextSymbols = [];

  ReelState state = ReelState.idle;
  double scroll = 0;
  double acceleration = 0;
  double moveBack = 0;
  double delay = 0;

  void startReel(double delay, List<Symbol> nextSymbols) {
    this.delay = delay;
    this.nextSymbols = nextSymbols;
    scroll = 0;
    acceleration = 0;
    moveBack = 1;
    state = ReelState.waiting;
  }

  void stopReel(List<Symbol> result) {
    scroll = 0;
    acceleration = 0;
    moveBack = 0;
    state = ReelState.idle;
    nextSymbols = [];
    symbols[0].index = 0;
    symbols[0].symbol = getRandomSymbol();
    symbols[1].index = 1;
    symbols[1].symbol = result[0];
    symbols[2].index = 2;
    symbols[2].symbol = result[1];
    symbols[3].index = 3;
    symbols[3].symbol = result[2];
    notifyListeners();
  }

  void update(double delta) {
    switch (state) {
      case ReelState.waiting:
        delay -= delta;
        if (delay <= 0) {
          state = ReelState.spinning;
          notifyListeners();
        }
        break;

      case ReelState.spinning:
        moveBack = max(moveBack - delta * 13, 0);
        acceleration = min(
          acceleration + delta * (20.0 - moveBack * 60.0),
          400.0,
        );
        scroll += acceleration * delta;

        while (scroll > 1.0) {
          scroll -= 1.0;
          symbols.removeLast();
          Symbol next = nextSymbols.removeAt(0);
          symbols.insert(0, GameReelSymbolModel(symbol: next, index: 0));
          for (int i = 0; i < symbols.length; i++) {
            symbols[i].index = i;
          }
          if (nextSymbols.isEmpty) {
            scroll = 0;
            state = ReelState.stopping;
            acceleration = 0.2;
          }
        }
        notifyListeners();
        break;

      case ReelState.stopping:
        if (acceleration > 0.01) {
          scroll = acceleration;
          acceleration = acceleration - acceleration * delta * 16;
        } else {
          scroll = 0;
          acceleration = 0;
          state = ReelState.idle;
        }
        notifyListeners();
        break;

      default:
        break;
    }
  }
}

class GameReelSymbolModel {
  Symbol symbol;
  int index;
  GameReelSymbolModel({required this.symbol, required this.index});
}
