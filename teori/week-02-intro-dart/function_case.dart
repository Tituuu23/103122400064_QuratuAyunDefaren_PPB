void sayHello(String name) {
  print("Selamat datang di kelas programming mobile, $name!");
}

double sum(dynamic a, dynamic b){
  return a + b;
}

void main(){
  sayHello("08-02");
  print(sum(5, 3.4));
}


String name, alamat, email, nohp, kelas, nim;
int id;
String? asalSekolah = null;

print(asalSekolah ?? "Asal sekolah tidak diketahui");
