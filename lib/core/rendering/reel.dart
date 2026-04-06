import 'package:flutter/material.dart';
import 'package:jesus_slot/models/reel_model.dart';
import 'package:jesus_slot/models/symbol.dart';

class Reel extends StatelessWidget {
  final GameReelModel reel;
  const Reel({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    double shift = 122;

    return ListenableBuilder(
      listenable: reel,
      builder: (context, _) {
        var scroll = reel.scroll * shift;
        return Expanded(
          child: Stack(
            children: reel.symbols
                .map(
                  (symbolModel) => _ReelSymbol(
                    symbol: symbolModel.symbol,
                    shift: symbolModel.index * shift - shift * 2 + scroll,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _ReelSymbol extends StatelessWidget {
  final Symbol symbol;
  final double shift;
  const _ReelSymbol({required this.symbol, required this.shift});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, shift),
      child: Image.asset(getSymbolAssetPath(symbol)),
    );
  }
}
