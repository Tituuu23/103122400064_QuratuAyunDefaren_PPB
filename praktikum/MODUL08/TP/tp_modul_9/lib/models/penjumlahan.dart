class Penjumlahan {
  final double angka1;
  final double angka2;
  final double hasil;

  Penjumlahan({
    required this.angka1,
    required this.angka2,
    required this.hasil,
  });

  /// Tampilkan angka tanpa ".0" jika bilangan bulat (3.0 -> "3")
  static String format(double nilai) {
    return nilai == nilai.truncateToDouble()
        ? nilai.toInt().toString()
        : nilai.toString();
  }

  String get angka1Text => format(angka1);
  String get angka2Text => format(angka2);
  String get hasilText => format(hasil);
}