// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart';
import '../config.dart';

class Bat extends PositionComponent
    with DragCallbacks, HasGameReference<BrickBreaker> {
  Bat({
    required this.cornerRadius,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, children: [RectangleHitbox()]);

  final Radius cornerRadius;

  final _shadowPaint = Paint()
    ..color = Colors.black.withValues(alpha: 0.35)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
  final _bodyPaint = Paint()
    ..color = playerColor
    ..style = PaintingStyle.fill;
  final _accentPaint = Paint()
    ..color = playerAccentColor
    ..style = PaintingStyle.fill;
  final _glassPaint = Paint()
    ..color = Colors.white.withValues(alpha: 0.75)
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    final bodyRect = Rect.fromLTWH(0, size.y * 0.25, size.x, size.y * 0.5);
    final body = RRect.fromRectAndRadius(bodyRect, cornerRadius);
    final leftWing = Path()
      ..moveTo(size.x * 0.08, size.y * 0.75)
      ..lineTo(size.x * 0.22, size.y)
      ..lineTo(size.x * 0.36, size.y * 0.7)
      ..close();
    final rightWing = Path()
      ..moveTo(size.x * 0.92, size.y * 0.75)
      ..lineTo(size.x * 0.78, size.y)
      ..lineTo(size.x * 0.64, size.y * 0.7)
      ..close();
    canvas.drawRRect(body.shift(const Offset(0, 6)), _shadowPaint);
    canvas.drawPath(leftWing.shift(const Offset(0, 6)), _shadowPaint);
    canvas.drawPath(rightWing.shift(const Offset(0, 6)), _shadowPaint);
    canvas.drawRRect(body, _bodyPaint);
    canvas.drawPath(leftWing, _accentPaint);
    canvas.drawPath(rightWing, _accentPaint);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.x / 2, size.y * 0.42),
        width: size.x * 0.28,
        height: size.y * 0.42,
      ),
      _glassPaint,
    );
    super.render(canvas);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x).clamp(
      size.x / 2,
      game.width - size.x / 2,
    );
  }

  void moveBy(double dx) {
    add(
      MoveToEffect(
        Vector2(
          (position.x + dx).clamp(size.x / 2, game.width - size.x / 2),
          position.y,
        ),
        EffectController(duration: 0.1),
      ),
    );
  }
}
