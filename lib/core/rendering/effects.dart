import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jesus_slot/models/effect_model.dart';
import 'package:jesus_slot/models/game_model.dart';

class Effects extends StatefulWidget {
  final double reelWidth;
  const Effects({super.key, required this.reelWidth});

  @override
  State<Effects> createState() => _EffectsState();
}

class _EffectsState extends State<Effects> with SingleTickerProviderStateMixin {
  ui.Image? imageCross;
  ui.Image? imageCircle;

  ui.Image? getEffectImage(EffectImage image) {
    switch (image) {
      case EffectImage.cross:
        return imageCross;
      case EffectImage.circle:
        return imageCircle;
    }
  }

  @override
  void initState() {
    super.initState();

    loadUiImage("assets/effect_cross.jpg").then((img) {
      setState(() {
        imageCross = img;
      });
    });

    loadUiImage("assets/effect_circle.jpg").then((img) {
      setState(() {
        imageCircle = img;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameModel = GameModelProvider.of(context);

    return ListenableBuilder(
      listenable: gameModel.effectModel,
      builder: (context, _) {
        return Stack(
          children: gameModel.effectModel.effects.map((effect) {
            final image = getEffectImage(effect.imageType);
            if (image != null) {
              return _Effect(
                effect: effect,
                reelWidth: widget.reelWidth,
                image: image,
              );
            }
            return Container();
          }).toList(),
        );
      },
    );
  }
}

class _Effect extends StatelessWidget {
  final Effect effect;
  final double reelWidth;
  final ui.Image image;
  const _Effect({
    required this.effect,
    required this.reelWidth,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final posX =
        effect.x * reelWidth - (reelWidth * effect.scale) / 2 + reelWidth / 2;
    final posY =
        effect.y * 122.0 - (reelWidth * effect.scale) / 2 + reelWidth / 2 + 36;

    return Transform.translate(
      offset: Offset(posX, posY),
      child: Transform.rotate(
        angle: effect.rotation,
        child: CustomPaint(
          size: Size(
            reelWidth * effect.scale,
            reelWidth * effect.scale, // or your actual height
          ),
          painter: AdditiveImagePainter(
            image: image,
            opacity: effect.opacity,
            blendMode: effect.blendMode,
          ),
        ),
      ),
    );
  }
}

class AdditiveImagePainter extends CustomPainter {
  final ui.Image image;
  final double opacity;
  final BlendMode blendMode;
  AdditiveImagePainter({
    required this.image,
    required this.opacity,
    required this.blendMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..blendMode = blendMode
      ..color = Color.fromARGB((opacity * 255).toInt(), 255, 255, 255);

    final src = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );

    final dst = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawImageRect(image, src, dst, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Future<ui.Image> loadUiImage(String asset) async {
  final data = await rootBundle.load(asset);
  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  final frame = await codec.getNextFrame();
  return frame.image;
}
