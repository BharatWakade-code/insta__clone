import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/Screens/number_plate_detector/number_plate_detector_cubit.dart';
import 'package:insta_clone/Screens/number_plate_detector/number_plate_detector_state.dart';
import 'package:insta_clone/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;
  DateTime lastSent = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    init();
  }

  Future<void> init() async {
    await requestPermission();
    await initCamera();

    // connect cubit
    context.read<NumberPlateCubit>().connect();
  }

  /// 🔐 Camera Permission
  Future<void> requestPermission() async {
    final status = await Permission.camera.request();

    if (!status.isGranted) {
      debugPrint("Camera permission denied");
    }
  }

  /// 📸 Initialize Camera
  Future<void> initCamera() async {
    try {
      if (cameras.isEmpty) throw Exception("No cameras found");

      final camera = cameras.firstWhere(
        (cam) => cam.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await controller!.initialize();

      if (!mounted) return;

      setState(() {});
      startStreaming();
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  /// 🎥 Stream frames
  void startStreaming() {
    controller?.startImageStream((CameraImage image) async {
      if (DateTime.now().difference(lastSent).inMilliseconds < 800) return;

      final jpeg = convertYUV420ToJpeg(image);
      if (jpeg == null) return;

      context.read<NumberPlateCubit>().sendFrame(jpeg);

      lastSent = DateTime.now();
    });
  }

  /// 🔄 Convert Image
  Uint8List? convertYUV420ToJpeg(CameraImage image) {
    try {
      final width = image.width;
      final height = image.height;

      final img.Image rgbImage = img.Image(width: width, height: height);

      final yPlane = image.planes[0];
      final uPlane = image.planes[1];
      final vPlane = image.planes[2];

      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          final yIndex = y * yPlane.bytesPerRow + x;
          final uvIndex = (y ~/ 2) * uPlane.bytesPerRow +
              (x ~/ 2) * uPlane.bytesPerPixel!;

          final yp = yPlane.bytes[yIndex];
          final up = uPlane.bytes[uvIndex];
          final vp = vPlane.bytes[uvIndex];

          int r = (yp + 1.402 * (vp - 128)).round();
          int g = (yp - 0.344 * (up - 128) - 0.714 * (vp - 128)).round();
          int b = (yp + 1.772 * (up - 128)).round();

          rgbImage.setPixelRgb(
            x,
            y,
            r.clamp(0, 255),
            g.clamp(0, 255),
            b.clamp(0, 255),
          );
        }
      }

      final resized = img.copyResize(rgbImage, width: 320);

      return Uint8List.fromList(img.encodeJpg(resized, quality: 60));
    } catch (_) {
      return null;
    }
  }

  /// 🔁 Lifecycle Handling
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null || !controller!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Plate Detection"),
        actions: [
          BlocBuilder<NumberPlateCubit, NumberPlateState>(
            builder: (context, state) {
              bool isConnected = false;

              if (state is NumberPlateConnected ||
                  state is NumberPlateDetected) {
                isConnected = true;
              }

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  isConnected ? Icons.wifi : Icons.wifi_off,
                  color: isConnected ? Colors.green : Colors.red,
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          CameraPreview(controller!),

          /// 🔥 Bottom overlay
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: BlocBuilder<NumberPlateCubit, NumberPlateState>(
              builder: (context, state) {
                String text = "Scanning...";

                if (state is NumberPlateLoading) {
                  text = "Connecting...";
                } else if (state is NumberPlateDetected) {
                  text = "Plate: ${state.plate}";
                } else if (state is NumberPlateDisconnected) {
                  text = "Reconnecting...";
                } else if (state is NumberPlateError) {
                  text = state.message;
                }

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}