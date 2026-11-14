import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/penjumlahan_controller.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String? _validasiAngka(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Angka tidak boleh kosong';
    }
    if (double.tryParse(value.trim()) == null) {
      return 'Masukkan angka yang valid';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Dependency Injection: daftarkan controller
    final controller = Get.put(PenjumlahanController());

    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator Penjumlahan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.angka1Controller,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: const InputDecoration(
                  labelText: 'Masukkan Angka Pertama',
                  border: OutlineInputBorder(),
                ),
                validator: _validasiAngka,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller.angka2Controller,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: const InputDecoration(
                  labelText: 'Masukkan Angka Kedua',
                  border: OutlineInputBorder(),
                ),
                validator: _validasiAngka,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: controller.hitung,
                  child: const Text('Jumlahkan'),
                ),
              ),
              const SizedBox(height: 16),
              // Reactive: jumlah perhitungan
              Obx(() => Text(
                    'Jumlah Perhitungan: ${controller.jumlahPerhitungan.value}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 12),
              // Reactive: hasil, Text yang bisa ditekan -> Detail
              Obx(() {
                final data = controller.data.value;
                return InkWell(
                  onTap: () => Get.to(() => const DetailPage()),
                  child: Text(
                    data == null
                        ? 'Belum ada data'
                        : 'Hasil: ${data.hasilText} (Tekan untuk detail)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: data == null ? null : Colors.blue,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}