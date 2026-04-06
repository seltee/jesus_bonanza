import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jesus_slot/core/layout/win_box.dart';
import 'package:jesus_slot/core/rendering/effects.dart';
import 'package:jesus_slot/core/rendering/reel.dart';
import 'package:jesus_slot/models/game_model.dart';

class Reels extends StatelessWidget {
  const Reels({super.key});

  @override
  Widget build(BuildContext context) {
    final model = GameModelProvider.of(context);

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 480, maxHeight: 420),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final reelWidth = width / 5;
          final boxHeight = reelWidth * 3 + 104;
          final double scale = min(height / 490.0, 1);

          print(boxHeight);

          return Transform.translate(
            offset: Offset(0.0, (height / 2 - boxHeight / 2) * 0.3),
            child: Transform.scale(
              scale: scale,
              child: Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.08, 0.92, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: SizedBox(
                      height: boxHeight,
                      width: width,
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 1),
                        child: ClipRect(
                          child: Row(
                            children: model.reels
                                .map((reel) => Reel(reel: reel))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Effects(reelWidth: reelWidth),
                  Align(
                    alignment: AlignmentGeometry.topCenter,
                    child: Transform.translate(
                      offset: Offset(0.0, boxHeight - 80 / scale),
                      child: Winbox(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
