import 'package:web/web.dart' as web;

/// Handles all rendering operations to the canvas
class Renderer {
  final web.HTMLCanvasElement canvas;
  late final web.CanvasRenderingContext2D ctx;

  Renderer(this.canvas) {
    ctx = canvas.getContext('2d') as web.CanvasRenderingContext2D;
  }

  void clear() {
    ctx.fillStyle = '#0a0a0a';
    ctx.fillRect(0, 0, canvas.width, canvas.height);
  }

  void drawRect(double x, double y, double width, double height, String color) {
    ctx.fillStyle = color;
    ctx.fillRect(x, y, width, height);
  }

  void drawCircle(double x, double y, double radius, String color) {
    ctx.fillStyle = color;
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, 2 * 3.14159);
    ctx.fill();
  }

  void drawText(String text, double x, double y, {String color = '#ffffff', String font = '16px monospace'}) {
    ctx.fillStyle = color;
    ctx.font = font;
    ctx.fillText(text, x, y);
  }

  void drawLine(double x1, double y1, double x2, double y2, String color, {double width = 1}) {
    ctx.strokeStyle = color;
    ctx.lineWidth = width;
    ctx.beginPath();
    ctx.moveTo(x1, y1);
    ctx.lineTo(x2, y2);
    ctx.stroke();
  }
}
