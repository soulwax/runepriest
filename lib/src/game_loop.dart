// File: lib/src/game_loop.dart

import 'package:web/web.dart' as web;

/// Handles the game loop using requestAnimationFrame for smooth rendering
class GameLoop {
  final void Function(double deltaTime) onUpdate;
  final void Function() onRender;

  bool _isRunning = false;
  double _lastTimestamp = 0;
  int? _animationFrameId;

  GameLoop({
    required this.onUpdate,
    required this.onRender,
  });

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _lastTimestamp = DateTime.now().millisecondsSinceEpoch.toDouble();
    _tick(0);
  }

  void stop() {
    _isRunning = false;
    if (_animationFrameId != null) {
      web.window.cancelAnimationFrame(_animationFrameId!);
      _animationFrameId = null;
    }
  }

  void _tick(num timestamp) {
    if (!_isRunning) return;

    final currentTime = timestamp.toDouble();
    final deltaTime = (currentTime - _lastTimestamp) / 1000.0; // Convert to seconds
    _lastTimestamp = currentTime;

    // Cap delta time to prevent spiral of death
    final cappedDeltaTime = deltaTime.clamp(0.0, 0.1);

    // Update game logic
    onUpdate(cappedDeltaTime);

    // Render
    onRender();

    // Schedule next frame
    _animationFrameId = web.window.requestAnimationFrame((num time) => _tick(time));
  }
}
