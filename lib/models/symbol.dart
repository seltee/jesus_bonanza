import 'dart:math';

enum Symbol { angel, lira, devil, jesus, gates, soul, hellGrandma }

final random = Random();

const weightedSymbols = [
  Symbol.soul,
  Symbol.soul,
  Symbol.soul,
  Symbol.soul,
  Symbol.soul,
  Symbol.soul,
  Symbol.soul,
  Symbol.lira,
  Symbol.lira,
  Symbol.lira,
  Symbol.lira,
  Symbol.lira,
  Symbol.lira,
  Symbol.angel,
  Symbol.angel,
  Symbol.angel,
  Symbol.angel,
  Symbol.angel,
  Symbol.gates,
  Symbol.gates,
  Symbol.gates,
  Symbol.gates,
  Symbol.devil,
  Symbol.devil,
  Symbol.devil,
  Symbol.jesus,
  Symbol.jesus,
  Symbol.hellGrandma,
];

Symbol getRandomSymbol() {
  return weightedSymbols[random.nextInt(weightedSymbols.length)];
}

String getSymbolAssetPath(Symbol symbol) {
  switch (symbol) {
    case Symbol.soul:
      return "assets/symbol_soul.png";
    case Symbol.angel:
      return "assets/symbol_angle.png";
    case Symbol.lira:
      return "assets/symbol_lira.png";
    case Symbol.devil:
      return "assets/symbol_devil2.png";
    case Symbol.jesus:
      return "assets/symbol_jesus.png";
    case Symbol.gates:
      return "assets/symbol_gates.png";
    case Symbol.hellGrandma:
      return "assets/symbol_hell_grandma.png";
  }
}

double getSymbolMultiplier(Symbol symbol) {
  switch (symbol) {
    case Symbol.soul:
      return 2.0;
    case Symbol.lira:
      return 5.0;
    case Symbol.angel:
      return 10.0;
    case Symbol.gates:
      return 50.0;
    case Symbol.devil:
      return 500.0;
    case Symbol.jesus:
      return 1000.0;
    case Symbol.hellGrandma:
      return 5000.0;
  }
}
