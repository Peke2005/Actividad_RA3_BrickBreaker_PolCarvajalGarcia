// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

const brickColors = [
  Color(0xffff4d6d),
  Color(0xffff7a00),
  Color(0xffffc300),
  Color(0xff70e000),
  Color(0xff00f5d4),
  Color(0xff00bbf9),
  Color(0xff4361ee),
  Color(0xff7209b7),
  Color(0xffff006e),
  Color(0xffffbe0b),
];

const gameBackgroundTop = Color(0xff08122d);
const gameBackgroundBottom = Color(0xff16213f);
const gameGridColor = Color(0x5538bdf8);
const gameStarColor = Color(0xfff8f9fa);
const playerColor = Color(0xff00f5d4);
const playerAccentColor = Color(0xffff006e);
const ballColor = Color(0xffffd166);
const ballGlowColor = Color(0x88ffffff);

const gameWidth = 820.0;
const gameHeight = 1600.0;
const ballRadius = gameWidth * 0.02;
const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 3;
const batStep = gameWidth * 0.05;
const brickGutter = gameWidth * 0.015;
final brickWidth =
    (gameWidth - (brickGutter * (brickColors.length + 1))) / brickColors.length;
const brickHeight = gameHeight * 0.03;
const difficultyModifier = 1.015;
const initialLives = 3;
