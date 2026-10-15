
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int halaman = 0;

  final List<Map<String, dynamic>> pesan = [
    {
      'nama': 'Titu',
      'isi': 'Hari Kamis tuh selalu punya vibe ya',
      'waktu': '07:45 AM',
      'warna': Colors.pinkAccent,
      'ikon': Icons.message,
    },
    {
      'nama': 'Tituw',
      'isi': 'Lucu ya kamu',
      'waktu': '08:30 AM',
      'warna': Colors.blueAccent,
      'ikon': Icons.chat,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> halamanList = [
      // BERANDA
      Stack(
        children: [
          Container(color: const Color(0xFF9DCEFA)),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.40,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  const Text(
                    'PPB MODUL 5!',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ampun! jangan kasih aku laprak',
                            style: TextStyle(fontSize: 10)),
                        Text('pls jangan kasih aku laprak',
                            style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Hari ini.',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ],
      ),

      // PESAN
      ListView(
  padding: const EdgeInsets.all(12),
  children: [
    for (var item in pesan)
      Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: item['warna'],
            child: Icon(
              item['ikon'],
              color: Colors.white,
            ),
          ),
          title: Text(item['nama']),
          subtitle: Text(item['isi']),
          trailing: Text(item['waktu']),
        ),
      ),
  ],
),

      // FORM BIODATA
      ListView(
        padding: const EdgeInsets.all(12),
        children: [
          biodataField('Quratu Ayun Defaren', Icons.person_outline),
          biodataField('103122400064', Icons.badge_outlined),
          biodataField('Software Engineering', Icons.school_outlined),
          biodataField('19', Icons.cake_outlined),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),

      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        backgroundColor: const Color(0xFFE4F2FF),
        title: Text(
          ['Beranda', 'Pesan', 'Form Biodata'][halaman],
          style: const TextStyle(
            fontSize: 13,
            color: Colors.blueAccent,
          ),
        ),
      ),

      body: halamanList[halaman],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: halaman,
        onTap: (index) {
          setState(() {
            halaman = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 18),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 18),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 18),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget biodataField(String label, IconData ikon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(ikon, size: 18),
          hintText: label,
          hintStyle: const TextStyle(fontSize: 12),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
