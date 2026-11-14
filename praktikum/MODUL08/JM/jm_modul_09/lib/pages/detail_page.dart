import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kalkulator_controller.dart';

class DetailPage extends StatelessWidget {
  final int index;

  const DetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // Dependency Injection: ambil controller yang sudah terdaftar
    final controller = Get.find<KalkulatorController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Perhitungan')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            if (index >= controller.riwayat.length) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Belum ada data'),
                  const SizedBox(height: 12),
                  FilledButton.tonal(
                    onPressed: () => Get.back(),
                    child: const Text('Kembali'),
                  ),
                ],
              );
            }

            final data = controller.riwayat[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Angka Pertama : ${data.angka1Text}'),
                        const SizedBox(height: 8),
                        Text('Operasi : ${data.namaOperasi} (${data.simbol})'),
                        const SizedBox(height: 8),
                        Text('Angka Kedua : ${data.angka2Text}'),
                        const Divider(height: 24),
                        Text(
                          'Hasil : ${data.hasilText}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(data.keterangan),
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