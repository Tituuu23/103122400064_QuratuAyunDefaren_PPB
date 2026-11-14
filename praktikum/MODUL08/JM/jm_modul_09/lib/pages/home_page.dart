import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kalkulator_controller.dart';
import '../models/perhitungan.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dependency Injection: daftarkan controller
    final controller = Get.put(KalkulatorController());

    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- FORM ----------
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.angka1Controller,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    decoration: const InputDecoration(
                      labelText: 'Angka Pertama',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Angka pertama wajib diisi';
                      }
                      if (double.tryParse(value.trim()) == null) {
                        return 'Masukkan angka yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: controller.angka2Controller,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: true),
                    decoration: const InputDecoration(
                      labelText: 'Angka Kedua',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Angka kedua wajib diisi';
                      }
                      if (double.tryParse(value.trim()) == null) {
                        return 'Masukkan angka yang valid';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ---------- PILIHAN OPERASI ----------
            Row(
              children: [
                _tombolOperasi(controller, '+', Operasi.penjumlahan),
                const SizedBox(width: 8),
                _tombolOperasi(controller, '-', Operasi.pengurangan),
                const SizedBox(width: 8),
                _tombolOperasi(controller, '×', Operasi.perkalian),
                const SizedBox(width: 8),
                _tombolOperasi(controller, '÷', Operasi.pembagian),
              ],
            ),
            const SizedBox(height: 24),

            // ---------- HEADER RIWAYAT ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Riwayat Perhitungan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  tooltip: 'Hapus semua riwayat',
                  onPressed: controller.hapusSemua,
                ),
              ],
            ),

            // ---------- DAFTAR RIWAYAT (reaktif) ----------
            Obx(() {
              if (controller.riwayat.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 48),
                  child: Center(child: Text('Belum ada data')),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.riwayat.length,
                itemBuilder: (context, index) {
                  final item = controller.riwayat[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.ekspresi),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: 'Hapus',
                        onPressed: () => controller.hapusSatu(index),
                      ),
                      onTap: () => Get.to(() => DetailPage(index: index)),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _tombolOperasi(
      KalkulatorController controller, String label, Operasi operasi) {
    return Expanded(
      child: FilledButton.tonal(
        onPressed: () => controller.hitung(operasi),
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}