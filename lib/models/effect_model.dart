import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';

enum EffectAnimation { dissapear }

enum EffectImage { cross, circle }

var effectRandom = Random();

class EffectModel extends ChangeNotifier {
  List<Effect> effects = [];

  void lightPattern(List<int> pattern) {
    for (int i = 0; i < pattern.length; i++) {
      effects.add(
        Effect(
            x: i.toDouble(),
            y: pattern[i].toDouble() - 0.1,
            imageType: EffectImage.circle,
            life: 8.0,
          )
          ..setColorMixing(BlendMode.multiply)
          ..setAnimation(EffectAnimation.dissapear)
          ..setLifeReduceFactor(2.6)
          ..setScale(1.3)
          ..setRandomRotation()
          ..setRotationSpeed(1.2),
      );

      effects.add(
        Effect(
            x: i.toDouble(),
            y: pattern[i].toDouble() - 0.1,
            imageType: EffectImage.circle,
            life: 8.0,
          )
          ..setColorMixing(BlendMode.multiply)
          ..setAnimation(EffectAnimation.dissapear)
          ..setLifeReduceFactor(2.6)
          ..setScale(1.3)
          ..setRandomRotation()
          ..setRotationSpeed(-2.0),
      );

      effects.add(
        Effect(
            x: i.toDouble(),
            y: pattern[i].toDouble(),
            imageType: EffectImage.cross,
            life: 8.0,
          )
          ..setColorMixing(BlendMode.plus)
          ..setAnimation(EffectAnimation.dissapear)
          ..setLifeReduceFactor(2.6)
          ..setScale(2.0),
      );
    }
  }

  void update(double delta) {
    // process
    for (final effect in effects) {
      effect.life -= delta * effect.lifeReduceFactor;
      if (effect.animation == EffectAnimation.dissapear) {
        effect.opacity = max(min(effect.life, 1.0), 0);
      }
      effect.rotation += effect.rotationSpeed * delta;
    }

    // filter
    effects = effects.where((effect) => effect.life > 0.0).toList();
    notifyListeners();
  }
}

class Effect {
  double x;
  double y;
  double scale = 1;
  EffectImage imageType;
  double life;
  double opacity = 1;
  double lifeReduceFactor = 1;
  double rotation = 0.0;
  double rotationSpeed = 0.0;
  BlendMode blendMode = BlendMode.srcOver;
  EffectAnimation animation = EffectAnimation.dissapear;

  Effect({
    required this.x,
    required this.y,
    required this.imageType,
    required this.life,
  });

  void setColorMixing(BlendMode blendMode) {
    this.blendMode = blendMode;
  }

  void setAnimation(EffectAnimation animation) {
    this.animation = animation;
  }

  void setLifeReduceFactor(double lifeReduceFactor) {
    this.lifeReduceFactor = lifeReduceFactor;
  }

  void setScale(double scale) {
    this.scale = scale;
  }

  void setRotationSpeed(double rotationSpeed) {
    this.rotationSpeed = rotationSpeed;
  }

  void setRandomRotation() {
    rotation = effectRandom.nextDouble() * 7.0;
  }
}
