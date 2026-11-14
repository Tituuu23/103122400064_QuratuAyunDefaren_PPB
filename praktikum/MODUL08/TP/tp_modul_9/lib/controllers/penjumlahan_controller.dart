import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/penjumlahan.dart';

class PenjumlahanController extends GetxController {
  // Form & input
  final formKey = GlobalKey<FormState>();
  final angka1Controller = TextEditingController();
  final angka2Controller = TextEditingController();

  // State reaktif
  final Rxn<Penjumlahan> data = Rxn<Penjumlahan>();
  final RxInt jumlahPerhitungan = 0.obs;

  void hitung() {
    // Validasi ditulis di masing-masing TextFormField (home_page.dart)
    if (!formKey.currentState!.validate()) return;

    final a = double.parse(angka1Controller.text.trim());
    final b = double.parse(angka2Controller.text.trim());

    data.value = Penjumlahan(angka1: a, angka2: b, hasil: a + b);
    jumlahPerhitungan.value++;

    final p = data.value!;
    Get.snackbar(
      'Berhasil',
      'Proses penjumlahan berhasil dilakukan '
          '(${p.angka1Text} + ${p.angka2Text} = ${p.hasilText})',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
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