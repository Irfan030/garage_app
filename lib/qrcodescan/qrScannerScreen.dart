import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  final Function(String) onScan;

  const QRScannerScreen({Key? key, required this.onScan}) : super(key: key);

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  CameraFacing cameraFacing = CameraFacing.back;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void switchCamera() {
    setState(() {
      cameraFacing =
          cameraFacing == CameraFacing.back
              ? CameraFacing.front
              : CameraFacing.back;
      cameraController.switchCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        actions: [
          IconButton(
            icon: Icon(
              cameraController.value.torchState == TorchState.on
                  ? Icons.flash_on
                  : Icons.flash_off,
              color:
                  cameraController.value.torchState == TorchState.on
                      ? Colors.yellow
                      : Colors.grey,
            ),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: Icon(
              cameraFacing == CameraFacing.back
                  ? Icons.camera_rear
                  : Icons.camera_front,
            ),
            onPressed: switchCamera,
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            widget.onScan(barcode.rawValue ?? '');
          }
          Navigator.pop(context); // Close the scanner after detecting a QR code
        },
      ),
    );
  }
}
