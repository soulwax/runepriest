import 'dart:async';
import 'package:web/web.dart' as web;
import 'package:runepriest/game.dart';

void main() {
  final canvas = web.document.querySelector('#game-canvas') as web.HTMLCanvasElement;
  final debugInfo = web.document.querySelector('#debug-info') as web.HTMLDivElement;

  final game = Game(canvas, debugInfo);
  game.start();
}
