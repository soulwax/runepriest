// File: lib/src/game.dart

import 'dart:async';
import 'package:web/web.dart' as web;
import 'game_loop.dart';
import 'renderer.dart';
import 'input_manager.dart';
import 'entities/player.dart';
import 'world/world.dart';

/// Main game class that orchestrates all game systems
class Game {
  final web.HTMLCanvasElement canvas;
  final web.HTMLDivElement debugInfo;
  late final Renderer renderer;
  late final InputManager inputManager;
  late final GameLoop gameLoop;
  late final World world;
  late final Player player;

  bool _isRunning = false;
  int _fps = 0;
  int _frameCount = 0;
  DateTime _lastFpsUpdate = DateTime.now();

  Game(this.canvas, this.debugInfo) {
    _initialize();
  }

  void _initialize() {
    // Set canvas size
    canvas.width = 800;
    canvas.height = 600;

    // Initialize game systems
    renderer = Renderer(canvas);
    inputManager = InputManager(canvas);
    world = World();
    player = Player(x: 400, y: 300);

    // Create game loop
    gameLoop = GameLoop(
      onUpdate: _update,
      onRender: _render,
    );
  }

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    gameLoop.start();
    print('RunePriest game started!');
  }

  void stop() {
    _isRunning = false;
    gameLoop.stop();
  }

  void _update(double deltaTime) {
    // Update player based on input
    player.update(deltaTime, inputManager);

    // Update world
    world.update(deltaTime);

    // Update FPS counter
    _updateFps();
  }

  void _render() {
    // Clear canvas
    renderer.clear();

    // Render world
    world.render(renderer);

    // Render player
    player.render(renderer);

    // Update debug info
    _updateDebugInfo();
  }

  void _updateFps() {
    _frameCount++;
    final now = DateTime.now();
    final elapsed = now.difference(_lastFpsUpdate).inMilliseconds;

    if (elapsed >= 1000) {
      _fps = (_frameCount * 1000 / elapsed).round();
      _frameCount = 0;
      _lastFpsUpdate = now;
    }
  }

  void _updateDebugInfo() {
    debugInfo.textContent = '''
FPS: $_fps
Player: (${player.x.toStringAsFixed(1)}, ${player.y.toStringAsFixed(1)})
''';
  }
}
