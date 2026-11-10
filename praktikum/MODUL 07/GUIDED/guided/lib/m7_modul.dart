import 'package:flutter/material.dart';

class Mahasiswa {
  final String nama, nim;
  final int umur;

  const Mahasiswa({required this.nama, required this.nim, required this.umur});

  factory Mahasiswa.fromJson(Map<String, dynamic> json){
    return Mahasiswa(
      nama: json["nama"], 
      nim: json["nim"], 
      umur: int.parse(json["umur"].toString()),
    );
  }

    Map<String, dynamic> toJson(){
      return{"nama": nama, "nim": nim, "umur": umur};
    }
  }

  class M7Modul extends StatelessWidget {
  const M7Modul({super.key});

  @override
  Widget build(BuildContext context) {
    Mahasiswa dataMahasiswa = Mahasiswa(
      nama: "Marta",
      nim: "103122400047",
      umur: 20,
      );
      print(dataMahasiswa.nama);

      Map<String, dynamic> dataJson = {
        "nama": "Fitri", 
        "nim": "1031224000",
        "umur": 21,
        };

        Mahasiswa dataFromJson = Mahasiswa.fromJson(dataJson);
        print (dataFromJson);

        Map<String, dynamic> dataToJson = dataFromJson.toJson();
        print(dataToJson);
        
        return const Placeholder();
  }
}