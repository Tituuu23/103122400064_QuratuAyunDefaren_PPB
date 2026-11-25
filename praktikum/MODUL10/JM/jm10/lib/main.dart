import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

List<CameraDescription> _cameras = [];

/// Menampilkan foto hasil capture sesuai platform.
/// Di web, path berupa blob URL sehingga memakai Image.network.
Widget _buildPhoto(XFile file, {BoxFit fit = BoxFit.cover}) {
  return kIsWeb
      ? Image.network(file.path, fit: fit)
      : Image.file(File(file.path), fit: fit);
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    _cameras = await availableCameras();
  } on CameraException catch (e) {
    debugPrint('Gagal mengambil daftar kamera: ${e.code} ${e.description}');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 10',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  XFile? _capturedImage;
  bool _isBusy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (_cameras.isEmpty) {
      _error = 'Kamera tidak ditemukan pada perangkat ini.';
    } else {
      final initial = _cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras.first,
      );
      _startCamera(initial);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      controller.dispose();
      _controller = null;
    } else if (state == AppLifecycleState.resumed) {
      _startCamera(controller.description);
    }
  }

  Future<void> _startCamera(CameraDescription description) async {
    if (_isBusy) return;
    _isBusy = true;

    final old = _controller;
    if (mounted) {
      setState(() {
        _controller = null;
        _error = null;
      });
    }
    await old?.dispose();

    final controller = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await controller.initialize();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() => _controller = controller);
    } on CameraException catch (e) {
      await controller.dispose();
      if (mounted) {
        setState(() {
          _error = (e.code == 'CameraAccessDenied')
              ? 'Izin kamera ditolak. Aktifkan lewat pengaturan aplikasi.'
              : 'Terjadi kesalahan kamera: ${e.description ?? e.code}';
        });
      }
    } finally {
      _isBusy = false;
    }
  }

  Future<void> _switchCamera() async {
    final current = _controller?.description;
    if (_isBusy || current == null || _cameras.length < 2) return;

    final target = _cameras.firstWhere(
      (c) => c.lensDirection != current.lensDirection,
      orElse: () => current,
    );
    await _startCamera(target);
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null ||
        !controller.value.isInitialized ||
        controller.value.isTakingPicture) {
      return;
    }

    try {
      final file = await controller.takePicture();
      if (mounted) setState(() => _capturedImage = file);
    } on CameraException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil foto: ${e.description ?? e.code}')),
      );
    }
  }

  void _showPhotoSheet() {
    final image = _capturedImage;
    if (image == null) return;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _buildPhoto(image, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreview() {
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            _error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    // Preview memenuhi layar (cover) tanpa terdistorsi.
    final size = controller.value.previewSize!;
    return ClipRect(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: size.height,
          height: size.width,
          child: CameraPreview(controller),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ready = _controller != null && _controller!.value.isInitialized;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Modul 10',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildPreview(),

          // Thumbnail hasil capture di kanan atas.
          if (_capturedImage != null)
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: _showPhotoSheet,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: _buildPhoto(_capturedImage!),
                  ),
                ),
              ),
            ),

          // Tombol Switch Camera dan Capture.
          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: 'Switch Camera',
                  iconSize: 32,
                  color: Colors.white,
                  disabledColor: Colors.white38,
                  icon: const Icon(Icons.flip_camera_android),
                  onPressed: (ready && _cameras.length > 1) ? _switchCamera : null,
                ),
                const SizedBox(width: 32),
                GestureDetector(
                  onTap: ready ? _capture : null,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                  ),
                ),
                const SizedBox(width: 72), // penyeimbang agar tombol capture di tengah
              ],
            ),
          ),
        ],
      ),
    );
  }
}