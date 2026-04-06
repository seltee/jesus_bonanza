import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jesus_slot/config/game_colors.dart';
import 'package:jesus_slot/models/game_model.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    final gameModel = GameModelProvider.of(context);

    return ListenableBuilder(
      listenable: gameModel,
      builder: (context, _) {
        final money = gameModel.money;
        final bet = gameModel.bet;
        final betList = gameModel.betList;

        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 480, maxHeight: 420),
          child: Padding(
            padding: EdgeInsetsGeometry.directional(
              start: 8,
              end: 8,
              top: 8,
              bottom: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ControlsValue(title: "MONEY", value: money),
                _PlayButton(),
                _BetValue(
                  bet: bet,
                  bets: betList,
                  onSelect: (int bet) => gameModel.setBet(bet),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BetValue extends StatefulWidget {
  final int bet;
  final List<int> bets;
  final Function onSelect;
  const _BetValue({
    required this.bet,
    required this.bets,
    required this.onSelect,
  });

  @override
  State<_BetValue> createState() => _BetValueState();
}

class _BetValueState extends State<_BetValue> {
  OverlayEntry? overlay;

  final buttonKey = GlobalKey();

  _BetValueState();

  void showDropdown(BuildContext context) {
    final renderBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
    final buttonSize = renderBox.size;
    final buttonPosition = renderBox.localToGlobal(Offset.zero);

    overlay = OverlayEntry(
      builder: (context) => Positioned(
        left: buttonPosition.dx, // align left of dropdown to button
        bottom:
            MediaQuery.of(context).size.height -
            buttonPosition.dy -
            buttonSize.height,
        width: buttonSize.width, // same width as button
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // dropdown background
              borderRadius: BorderRadius.circular(20), // rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.bets.reversed.map((bet) {
                return ListTile(
                  title: Center(
                    child: Text(
                      bet.toString(),
                      style: TextStyle(
                        color: GameColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () {
                    widget.onSelect(bet);
                    overlay?.remove();
                    overlay = null;
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(overlay!);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 35,
      child: ElevatedButton(
        key: buttonKey,
        onPressed: () {
          overlay?.remove();
          overlay = null;
          showDropdown(context);
        },
        child: Text(
          'BET ${widget.bet}',
          style: TextStyle(
            color: GameColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ControlsValue extends StatelessWidget {
  const _ControlsValue({required this.value, required this.title});
  final int value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 35,
      child: Container(
        decoration: BoxDecoration(
          color: GameColors.lightGrey,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$title $value',
            style: TextStyle(
              color: GameColors.darkGray,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  Color getPlayBackgroundColor(GameState state) {
    if (state == GameState.spinning) {
      return GameColors.orange;
    }
    return GameColors.darkGray;
  }

  Color getPlayIconColor(GameState state) {
    if (state == GameState.spinning) {
      return GameColors.darkGray;
    }
    return GameColors.orange;
  }

  IconData getPlayIcon(GameState state) {
    if (state == GameState.spinning) {
      return CupertinoIcons.stop_fill;
    }
    return CupertinoIcons.play_fill;
  }

  void Function()? getPlayFunction(GameModel gameModel) {
    switch (gameModel.gameState) {
      case GameState.idle:
        return gameModel.canPlay() ? () => gameModel.startReels() : null;
      case GameState.spinning:
        return () => gameModel.stopReels();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameModel = GameModelProvider.of(context);

    Color backgroundColor = getPlayBackgroundColor(gameModel.gameState);
    Color iconColor = getPlayIconColor(gameModel.gameState);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: getPlayFunction(gameModel),
        child: Container(
          padding: const EdgeInsets.fromLTRB(2, 20, 0, 20),
          child: Icon(getPlayIcon(gameModel.gameState), color: iconColor),
        ),
      ),
    );
  }
}
