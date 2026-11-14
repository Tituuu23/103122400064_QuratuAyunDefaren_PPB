import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/perhitungan.dart';

class KalkulatorController extends GetxController {
  // Form & input
  final formKey = GlobalKey<FormState>();
  final angka1Controller = TextEditingController();
  final angka2Controller = TextEditingController();

  // Riwayat perhitungan (reaktif)
  final RxList<Perhitungan> riwayat = <Perhitungan>[].obs;

  void hitung(Operasi operasi) {
    // Validasi input ditulis di masing-masing TextFormField (home_page.dart)
    if (!formKey.currentState!.validate()) return;

    final a = double.parse(angka1Controller.text.trim());
    final b = double.parse(angka2Controller.text.trim());

    // Validasi: pembagian dengan nol
    if (operasi == Operasi.pembagian && b == 0) {
      Get.snackbar(
        'Gagal',
        'Tidak dapat melakukan pembagian dengan nol',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );
      return;
    }

    double hasil;
    switch (operasi) {
      case Operasi.penjumlahan:
        hasil = a + b;
        break;
      case Operasi.pengurangan:
        hasil = a - b;
        break;
      case Operasi.perkalian:
        hasil = a * b;
        break;
      case Operasi.pembagian:
        hasil = a / b;
        break;
    }

    riwayat.add(Perhitungan(
      angka1: a,
      angka2: b,
      operasi: operasi,
      hasil: hasil,
    ));

    Get.snackbar(
      'Berhasil',
      'Perhitungan berhasil dilakukan',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
    );
  }

  void hapusSatu(int index) {
    if (index < 0 || index >= riwayat.length) return;
    riwayat.removeAt(index);
    Get.snackbar(
      'Berhasil',
      'Riwayat berhasil dihapus',
      margin: const EdgeInsets.all(12),
    );
  }

  void hapusSemua() {
    if (riwayat.isEmpty) return;
    riwayat.clear();
    Get.snackbar(
      'Berhasil',
      'Seluruh riwayat berhasil dihapus',
      margin: const EdgeInsets.all(12),
    );
  }

  @override
  void onClose() {
    angka1Controller.dispose();
    angka2Controller.dispose();
    super.onClose();
  }
}