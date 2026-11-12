import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Model data sederhana untuk komik
class Comic {
  final String title;
  final String category;
  final String description;
  final Color color;

  const Comic({
    required this.title,
    required this.category,
    required this.description,
    required this.color,
  });
}

// Data daftar komik (minimal 2 item)
const List<Comic> comics = [
  Comic(
    title: 'Boku no Hero Academia',
    category: 'Manga',
    description:
        'Boku no Hero Academia adalah manga shonen Jepang karya Kohei Horikoshi '
        'yang mengisahkan tentang Izuku Midoriya, seorang anak tanpa kekuatan '
        'di dunia di mana hampir semua orang memilikinya. Ia kemudian bertemu '
        'All Might dan memulai perjalanan menjadi pahlawan.',
    color: Colors.amber,
  ),
  Comic(
    title: 'Jujutsu Kaisen',
    category: 'Manga',
    description:
        'Jujutsu Kaisen adalah manga karya Gege Akutami. Bercerita tentang '
        'Yuji Itadori yang terlibat dalam dunia kutukan setelah menelan salah '
        'satu jari Ryomen Sukuna. Manga ini terbit di Weekly Shonen Jump sejak '
        '2018 dan telah diadaptasi menjadi anime populer.',
    color: Colors.blue,
  ),
  Comic(
    title: 'One Piece',
    category: 'Manga',
    description:
        'One Piece adalah manga karya Eiichiro Oda yang mengikuti petualangan '
        'Monkey D. Luffy dan kru Topi Jerami dalam mencari harta karun legendaris '
        'untuk menjadi Raja Bajak Laut.',
    color: Colors.red,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comic Books',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// ================= HALAMAN DAFTAR =================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Ganti "YourName" dengan namamu
        title: const Text("Titu Comic Books"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: comics.length,
        itemBuilder: (context, index) {
          final comic = comics[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              // Ikon berupa lingkaran berwarna
              leading: CircleAvatar(backgroundColor: comic.color),
              title: Text(
                comic.title,
                style: TextStyle(
                  color: comic.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Buka halaman baru saat item diklik
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(comic: comic),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ================= HALAMAN DETAIL =================
class DetailPage extends StatelessWidget {
  final Comic comic;

  const DetailPage({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comic.title),
        backgroundColor: comic.color,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              comic.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: comic.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              comic.category,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Text(
              comic.description,
              textAlign: TextAlign.justify,
            ),
            const Spacer(),
            // Tombol kembali ke halaman sebelumnya
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('KEMBALI'),
            ),
          ],
        ),
      ),
    );
  }
}