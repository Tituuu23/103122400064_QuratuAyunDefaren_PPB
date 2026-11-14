enum Operasi { penjumlahan, pengurangan, perkalian, pembagian }

class Perhitungan {
  final double angka1;
  final double angka2;
  final Operasi operasi;
  final double hasil;

  Perhitungan({
    required this.angka1,
    required this.angka2,
    required this.operasi,
    required this.hasil,
  });

  /// Tampilkan angka tanpa ".0" jika bilangan bulat (3.0 -> "3")
  static String format(double nilai) {
    if (nilai.isNaN || nilai.isInfinite) return nilai.toString();
    return nilai == nilai.truncateToDouble()
        ? nilai.toInt().toString()
        : nilai.toString();
  }

  String get angka1Text => format(angka1);
  String get angka2Text => format(angka2);
  String get hasilText => format(hasil);

  /// Simbol operasi: + - × ÷
  String get simbol {
    switch (operasi) {
      case Operasi.penjumlahan:
        return '+';
      case Operasi.pengurangan:
        return '-';
      case Operasi.perkalian:
        return '×';
      case Operasi.pembagian:
        return '÷';
    }
  }

  /// Nama operasi: penjumlahan, pengurangan, perkalian, pembagian
  String get namaOperasi => operasi.name;

  /// Contoh: "3 + 3 = 6"
  String get ekspresi => '$angka1Text $simbol $angka2Text = $hasilText';

  /// Contoh: "Hasil penjumlahan antara 3 dan 3 adalah 6"
  String get keterangan =>
      'Hasil $namaOperasi antara $angka1Text dan $angka2Text adalah $hasilText';
}