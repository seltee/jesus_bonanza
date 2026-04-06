import 'package:jesus_slot/models/symbol.dart';

class WinResult {
  final int amount;
  final List<int> pattern;
  WinResult({required this.amount, required this.pattern});
}

List<WinResult> getWinsList(List<List<Symbol>> spinResult, int bet) {
  List<WinResult> winResult = [];

  List<List<int>> patterns = [
    [0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1],
    [2, 2, 2, 2, 2],
    [0, 0, 1, 2, 2],
    [2, 2, 1, 0, 0],
    [2, 1, 0, 1, 2],
    [0, 1, 2, 1, 0],
    [0, 1, 0, 1, 0],
    [2, 1, 2, 1, 2],
    [1, 1, 0, 1, 1],
    [1, 1, 2, 1, 1],
  ];

  for (final pattern in patterns) {
    List<Symbol> list = [];
    for (int i = 0; i < pattern.length; i++) {
      list.add(spinResult[i][pattern[i]]);
    }

    Symbol target = list[0];
    if (list.every((sym) => sym == target)) {
      double symbolCost = getSymbolMultiplier(target);
      winResult.add(
        WinResult(amount: (symbolCost * bet).toInt(), pattern: pattern),
      );
    }
  }

  return winResult;
}
