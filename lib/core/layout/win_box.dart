import 'package:flutter/widgets.dart';
import 'package:jesus_slot/config/game_colors.dart';
import 'package:jesus_slot/models/game_model.dart';

class Winbox extends StatelessWidget {
  const Winbox({super.key});

  @override
  Widget build(BuildContext context) {
    final gameModel = GameModelProvider.of(context);

    return ListenableBuilder(
      listenable: gameModel,
      builder: (context, _) {
        final winAmount = gameModel.winAmount;

        if (winAmount > 0) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/angels_win.png", scale: 0.9),
              Transform.translate(
                offset: Offset(0.0, -22.0),
                child: Text(
                  "WIN",
                  style: TextStyle(
                    color: GameColors.darkGray,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0.0, 4.0),
                child: Text(
                  '$winAmount',
                  style: TextStyle(
                    color: GameColors.darkGray,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    decoration: TextDecoration.none,
                  ),
                  textScaler: TextScaler.linear(1.6),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
