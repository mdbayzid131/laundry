import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMapMarker {
  // Create custom marker icon
  static Future<BitmapDescriptor> createCustomMarker({
    Color backgroundColor = const Color(0xFFA6D4E9),
    Color centerColor = Colors.white,
    double size = 80,
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = backgroundColor;

    // Draw the marker pin shape
    final path = Path();
    
    // Top circle
    canvas.drawCircle(
      Offset(size / 2, size / 3),
      size / 3,
      paint,
    );

    // Bottom triangle/point
    path.moveTo(size / 2 - size / 4, size / 2);
    path.lineTo(size / 2, size);
    path.lineTo(size / 2 + size / 4, size / 2);
    path.close();
    canvas.drawPath(path, paint);

    // Draw white center circle
    final centerPaint = Paint()..color = centerColor;
    canvas.drawCircle(
      Offset(size / 2, size / 3),
      size / 6,
      centerPaint,
    );

    // Convert to image
    final picture = recorder.endRecording();
    final img = await picture.toImage(size.toInt(), (size * 1.2).toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(bytes);
  }

  // Alternative: Create from widget
  static Future<BitmapDescriptor> createMarkerFromWidget({
    required Widget widget,
    required Size size,
  }) async {
    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
    final RenderView renderView = RenderView(
      view: ui.PlatformDispatcher.instance.views.first,
      child: RenderPositionedBox(
        alignment: Alignment.center,
        child: repaintBoundary,
      ),
      configuration: ViewConfiguration(
        devicePixelRatio: 1.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox> rootElement =
        RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: widget,
      ),
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    final ui.Image image = await repaintBoundary.toImage(pixelRatio: 2.0);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }
}

// Custom Marker Widget
class MarkerPinWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color centerColor;
  final double size;

  const MarkerPinWidget({
    super.key,
    this.backgroundColor = const Color(0xFFA6D4E9),
    this.centerColor = Colors.white,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.5,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Main pin shape
          CustomPaint(
            size: Size(size, size * 1.5),
            painter: MarkerPinPainter(
              backgroundColor: backgroundColor,
              centerColor: centerColor,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for marker
class MarkerPinPainter extends CustomPainter {
  final Color backgroundColor;
  final Color centerColor;

  MarkerPinPainter({
    required this.backgroundColor,
    required this.centerColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Draw shadow
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.25 + 2),
      size.width / 2.5,
      shadowPaint,
    );

    // Draw main circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.25),
      size.width / 2.5,
      paint,
    );

    // Draw triangle/point
    final path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.4);
    path.lineTo(size.width / 2, size.height * 0.7);
    path.lineTo(size.width * 0.7, size.height * 0.4);
    path.close();
    canvas.drawPath(path, paint);

    // Draw white center
    final centerPaint = Paint()
      ..color = centerColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.25),
      size.width / 5,
      centerPaint,
    );

    // Optional: Add border to white circle
    final borderPaint = Paint()
      ..color = backgroundColor.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.25),
      size.width / 5,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(MarkerPinPainter oldDelegate) => false;
}