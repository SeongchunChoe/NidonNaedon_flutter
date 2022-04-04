import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nidonnaedon/screens/start_game.dart';

void main() => runApp(GetMaterialApp(
    home: StartGame(),
    theme: ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
    )));
