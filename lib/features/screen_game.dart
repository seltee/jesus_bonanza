import 'package:flutter/widgets.dart';
import 'package:jesus_slot/core/layout/controls.dart';
import 'package:jesus_slot/core/layout/reels.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover, // 🔥 this is CSS "cover"
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 4,
                horizontal: 64,
              ),
              child: Image.asset("assets/logo.png"),
            ),
          ),
          Expanded(child: Reels()),
          Controls(),
        ],
      ),
    );
  }
}
