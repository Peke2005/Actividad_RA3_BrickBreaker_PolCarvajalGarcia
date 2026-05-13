// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart';
import '../config.dart';

class PlayArea extends RectangleComponent with HasGameReference<BrickBreaker> {
  PlayArea()
    : super(
        paint: Paint()..color = Colors.transparent,
        children: [RectangleHitbox()],
      );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }

  @override
  void render(Canvas canvas) {
    final rect = Offset.zero & size.toSize();
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [gameBackgroundTop, gameBackgroundBottom],
        ).createShader(rect),
    );

    final starPaint = Paint()..color = gameStarColor.withValues(alpha: 0.75);
    for (var i = 0; i < 36; i++) {
      final x = ((i * 97) % gameWidth).toDouble();
      final y = ((i * 181) % (gameHeight * 0.55)).toDouble();
      canvas.drawCircle(Offset(x, y), 1.5 + (i % 3), starPaint);
    }

    final gridPaint = Paint()
      ..color = gameGridColor
      ..strokeWidth = 2;
    const gridGap = gameWidth / 8;
    for (var x = 0.0; x <= gameWidth; x += gridGap) {
      canvas.drawLine(Offset(x, 0), Offset(x, gameHeight), gridPaint);
    }
    for (var y = gameHeight * 0.35; y <= gameHeight; y += gridGap) {
      canvas.drawLine(Offset(0, y), Offset(gameWidth, y), gridPaint);
    }

    super.render(canvas);
  }
}
