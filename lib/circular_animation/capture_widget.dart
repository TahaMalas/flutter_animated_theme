import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CaptureWidget extends StatefulWidget {
  final Widget child;

  const CaptureWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  CaptureWidgetState createState() => CaptureWidgetState();
}

class CaptureWidgetState extends State<CaptureWidget> {
  final _boundaryKey = GlobalKey();

  void captureImage(Function(CaptureResult) onCapture) async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final boundary = _boundaryKey.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final data = await image.toByteData(format: ImageByteFormat.png);
      onCapture(
          CaptureResult(data!.buffer.asUint8List(), image.width, image.height));
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Column(
          children: <Widget>[
            Expanded(
              child: RepaintBoundary(
                child: widget.child,
                key: _boundaryKey,
              ),
            ),
          ],
        );
      },
    );
  }
}

class CaptureResult {
  final Uint8List data;
  final int width;
  final int height;

  const CaptureResult(this.data, this.width, this.height);
}
