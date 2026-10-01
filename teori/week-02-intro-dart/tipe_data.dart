void main() {
  // string, int, bool, float, list, map, var, dynamic
  // tipe primitif --> int, bool, float/double
  // tipe data non primitif --> string, list, map
  String nama = 'Quratu Ayun Defaren'; // tipe data string
  int umur = 10; // tipe data integer
  bool isStudent = true; // tipe data boolean
  double height = 170.0; // tipe data double (float)

  print('Nama saya adalah $nama, umur saya $umur tahun, tinggi badan saya adalah $height, apakah saya seorang pelajar? $isStudent');

  var a = "Nilai saya adalah A";
  print (a);
  print("tipe data dari variabel a adalah: ${a.runtimeType}" ); // untuk mengetahui tipe data dari variabel a
  a = "Nilai saya adalah B";
  print(a);
  // jadi pada ssat program sudah di compile, maka value dari variabel tidak boleh diganti
  // contoh adalah kita mengganti value dari string ke integer, maka akan error

  dynamic b = "Nilai saya adalah A"; // mode runtime
  print (b);
  print("tipe data dari variabel b adalah: ${b.runtimeType}" ); // untuk mengetahui tipe data dari variabel b
  b = 10;
  print(b);
  print("tipe data dari variabel b adalah: ${b.runtimeType}" ); // untuk mengetahui tipe data dari variabel b
  // jadi pada saat program sudah di compile, maka value dari variabel tidak boleh diganti
  // contoh adalah kita mengganti value dari string ke integer, maka akan error

  var namaDepan = "Quratu";
  var namaBelakang = "Ayun";  

  //collection -> list -> array, map -> dictionary
  List<String> names = ["Quratu", "Ayun", "Defaren"]; // tipe data list
  print(names);
  names.add("titu");
  print(names);


}