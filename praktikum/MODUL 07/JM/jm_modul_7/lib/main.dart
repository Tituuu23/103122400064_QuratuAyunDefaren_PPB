import 'package:flutter/material.dart';
import 'comic_detail_page.dart';
import 'comic_edit_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Komik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: const DaftarKomikPage(),
    );
  }
}

class DaftarKomikPage extends StatefulWidget {
  const DaftarKomikPage({super.key});

  @override
  State<DaftarKomikPage> createState() => _DaftarKomikPageState();
}

class _DaftarKomikPageState extends State<DaftarKomikPage> {
  final List<String> kategori = ['Manga', 'Action', 'Fantasy'];

  final List<Map<String, String>> daftarKomik = [
    {
      'judul': 'Boku no Hero Academia',
      'deskripsi': 'Boku no Hero Academia adalah manga karya Kohei Horikoshi.',
      'kategori': 'Manga',
    },
    {
      'judul': 'Jujutsu Kaisen',
      'deskripsi': 'Jujutsu Kaisen adalah manga karya Gege Akutami.',
      'kategori': 'Action',
    },
  ];

  void tampilkanDialogTambah() {
    final judulCtrl = TextEditingController();
    final deskripsiCtrl = TextEditingController();
    String kategoriDipilih = kategori[0];
    String? errorJudul;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Tambah Komik Baru'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: judulCtrl,
                    decoration: InputDecoration(
                      labelText: 'Judul',
                      errorText: errorJudul,
                    ),
                  ),
                  TextField(
                    controller: deskripsiCtrl,
                    decoration: const InputDecoration(labelText: 'Deskripsi'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: kategoriDipilih,
                    items: kategori
                        .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                        .toList(),
                    onChanged: (nilai) {
                      setDialogState(() {
                        kategoriDipilih = nilai!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                FilledButton.tonal(
                  onPressed: () {
                    if (judulCtrl.text.trim().isEmpty) {
                      setDialogState(() {
                        errorJudul = 'Judul tidak boleh kosong';
                      });
                      return;
                    }

                    setState(() {
                      daftarKomik.add({
                        'judul': judulCtrl.text.trim(),
                        'deskripsi': deskripsiCtrl.text.trim(),
                        'kategori': kategoriDipilih,
                      });
                    });
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void lihatDetail(Map<String, String> komik) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComicDetailPage(komik: komik),
      ),
    );
  }

  Future<void> ubahKomik(int index) async {
    final hasil = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => ComicEditPage(
          komik: daftarKomik[index],
          daftarKategori: kategori,
        ),
      ),
    );

    if (hasil != null && mounted) {
      setState(() {
        daftarKomik[index] = hasil;
      });
    }
  }

  void hapusKomik(int index) {
    final judul = daftarKomik[index]['judul'];

    setState(() {
      daftarKomik.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Data '$judul' sudah dihapus")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Komik')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: daftarKomik.length,
        itemBuilder: (context, index) {
          final komik = daftarKomik[index];

          return Card(
            child: InkWell(
              onTap: () => lihatDetail(komik),
              onLongPress: () => ubahKomik(index),
              onDoubleTap: () => hapusKomik(index),
              child: ListTile(
                leading: const Icon(Icons.book, color: Colors.blue),
                title: Text(komik['judul']!),
                subtitle: Text(komik['kategori']!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      tooltip: 'Edit',
                      onPressed: () => ubahKomik(index),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Hapus',
                      onPressed: () => hapusKomik(index),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tampilkanDialogTambah,
        child: const Icon(Icons.add),
      ),
    );
  }
}