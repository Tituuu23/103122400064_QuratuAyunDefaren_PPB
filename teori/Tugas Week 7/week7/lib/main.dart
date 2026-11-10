
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camera App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: HomePage(cameras: cameras),
    ),
  );
}

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const HomePage({super.key, required this.cameras});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? capturedImage;
  bool isLoading = false;

  Future<void> openCamera() async {
    if (widget.cameras.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kamera tidak ditemukan'),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    final camera = widget.cameras.first;
    final controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    try {
      await controller.initialize();

      if (!mounted) {
        await controller.dispose();
        return;
      }

      final image = await Navigator.push<XFile>(
        context,
        MaterialPageRoute(
          builder: (_) => CameraPage(
            controller: controller,
          ),
        ),
      );

      if (image != null && mounted) {
        setState(() => capturedImage = image);
      }
    } catch (e) {
      await controller.dispose();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuka kamera: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera App'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const Text(
                'Aplikasi Kamera',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Ambil gambar menggunakan kamera.'),
              const SizedBox(height: 24),

              if (capturedImage != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(capturedImage!.path),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Foto berhasil diambil!',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
              ],

              ElevatedButton.icon(
                onPressed: isLoading ? null : openCamera,
                icon: const Icon(Icons.camera_alt),
                label: Text(
                  isLoading ? 'Membuka kamera...' : 'Buka Kamera',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CameraPage extends StatefulWidget {
  final CameraController controller;

  const CameraPage({
    super.key,
    required this.controller,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool isTakingPicture = false;

  Future<void> takePicture() async {
    if (isTakingPicture) return;

    setState(() => isTakingPicture = true);

    try {
      final image = await widget.controller.takePicture();

      if (!mounted) return;

      Navigator.pop(context, image);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil foto: $e')),
        );
        setState(() => isTakingPicture = false);
      }
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambil Foto'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(widget.controller),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: FloatingActionButton.large(
              onPressed: isTakingPicture ? null : takePicture,
              child: const Icon(
                Icons.camera,
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
