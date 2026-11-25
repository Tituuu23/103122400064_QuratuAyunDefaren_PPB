import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> _cameras = [];

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
      title: 'Camera App',
      theme: ThemeData.dark(useMaterial3: true),
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
  bool _isBusy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (_cameras.isEmpty) {
      _error = 'Kamera tidak ditemukan pada perangkat ini.';
    } else {
      // Mulai dengan kamera belakang jika tersedia.
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

  // Lepas kamera saat app di-background, aktifkan lagi saat kembali.
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

    // Buang controller lama dulu agar preview tidak memakai controller yang sudah di-dispose.
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
      enableAudio: true, // memunculkan izin mikrofon seperti pada contoh output
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
          _error = (e.code == 'CameraAccessDenied' ||
                  e.code == 'AudioAccessDenied')
              ? 'Izin kamera/mikrofon ditolak. Aktifkan lewat pengaturan aplikasi.'
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

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Camera Preview'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_error != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(_error!, textAlign: TextAlign.center),
              ),
            )
          else if (controller == null || !controller.value.isInitialized)
            const Center(child: CircularProgressIndicator())
          else
            Center(child: CameraPreview(controller)),
          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: Center(
              child: ElevatedButton(
                onPressed: (_cameras.length > 1 && controller != null)
                    ? _switchCamera
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Switch Camera'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}