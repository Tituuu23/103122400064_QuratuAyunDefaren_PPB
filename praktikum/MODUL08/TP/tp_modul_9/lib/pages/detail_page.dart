import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/penjumlahan_controller.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency Injection: ambil controller yang sudah terdaftar
    final controller = Get.find<PenjumlahanController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Penjumlahan')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            final data = controller.data.value;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (data == null)
                  const Text('Belum ada data')
                else
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Angka Pertama : ${data.angka1Text}'),
                          const SizedBox(height: 8),
                          Text('Angka Kedua : ${data.angka2Text}'),
                          const Divider(height: 24),
                          Text(
                            'Hasil Penjumlahan : ${data.hasilText}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                FilledButton.tonal(
                  onPressed: () => Get.back(),
                  child: const Text('Kembali'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}