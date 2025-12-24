import 'package:web/web.dart' as web;

/// Manages keyboard and mouse input
class InputManager {
  final web.HTMLCanvasElement canvas;
  final Set<String> _keysPressed = {};
  final Set<String> _keysJustPressed = {};
  final Set<String> _keysJustReleased = {};

  double mouseX = 0;
  double mouseY = 0;
  bool mouseDown = false;

  InputManager(this.canvas) {
    _setupEventListeners();
  }

  void _setupEventListeners() {
    // Keyboard events
    web.window.addEventListener('keydown', (web.Event e) {
      final event = e as web.KeyboardEvent;
      final key = event.key.toLowerCase();
      if (!_keysPressed.contains(key)) {
        _keysJustPressed.add(key);
      }
      _keysPressed.add(key);
    }.toJS);

    web.window.addEventListener('keyup', (web.Event e) {
      final event = e as web.KeyboardEvent;
      final key = event.key.toLowerCase();
      _keysPressed.remove(key);
      _keysJustReleased.add(key);
    }.toJS);

    // Mouse events
    canvas.addEventListener('mousemove', (web.Event e) {
      final event = e as web.MouseEvent;
      final rect = canvas.getBoundingClientRect();
      mouseX = event.clientX - rect.left;
      mouseY = event.clientY - rect.top;
    }.toJS);

    canvas.addEventListener('mousedown', (web.Event e) {
      mouseDown = true;
    }.toJS);

    canvas.addEventListener('mouseup', (web.Event e) {
      mouseDown = false;
    }.toJS);
  }

  bool isKeyPressed(String key) => _keysPressed.contains(key.toLowerCase());

  bool isKeyJustPressed(String key) => _keysJustPressed.contains(key.toLowerCase());

  bool isKeyJustReleased(String key) => _keysJustReleased.contains(key.toLowerCase());

  void clearFrameInput() {
    _keysJustPressed.clear();
    _keysJustReleased.clear();
  }
}
