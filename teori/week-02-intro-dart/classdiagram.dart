abstract interface class BisaDiservis{
  void servis();
}

class Mobil {
  String nomorPolisi;
  String? namaPemilik;
  int? tahunProduksi;
  late String nomorMesin;

  Mobil({
    required this.nomorPolisi,
    this.namaPemilik,
    this.tahunProduksi,
  });

  void tampilkanInformasi() {
    print("Nomor Polisi   : $nomorPolisi");
    print("Nama Pemilik    : ${namaPemilik ?? "Belum diketahui"}");
    print("Tahun Produksi  : ${tahunProduksi ?? "Belum diketahui"}");
    
    // nomorMesin belum tentu sudah diisi
    print("Nomor Mesin     : $nomorMesin");
  }

  void registrasiMesin(String nomor) {
    nomorMesin = nomor;
    print("Nomor mesin berhasil diregistrasikan.");
  }

  void daftarKendaraan({
    required String nama,
    required String nomorPolisi,
    String? pemilik,
    String warna = "Hitam",
    int kecepatan = 0,
  }) {
    print("=== Daftar Kendaraan ===");
    print("Nama           : $nama");
    print("Nomor Polisi   : $nomorPolisi");
    print("Pemilik        : ${pemilik ?? "Belum diketahui"}");
    print("Warna          : $warna");
    print("Kecepatan      : $kecepatan km/jam");
  }
}

void main() {
  Mobil mobil = Mobil(
    nomorPolisi: "R 1234 AB",
    namaPemilik: null,
    tahunProduksi: 2024,
  );

  mobil.registrasiMesin("MESIN001");

  mobil.tampilkanInformasi();

  print("");

  mobil.daftarKendaraan(
    nama: "Toyota Avanza",
    nomorPolisi: "R 1234 AB",
    pemilik: "Titu",
    warna: "Hitam",
    kecepatan: 80,
  );
}
