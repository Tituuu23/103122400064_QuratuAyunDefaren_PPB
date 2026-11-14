import 'package:flutter/material.dart';

class ComicEditPage extends StatefulWidget {
  final Map<String, String> komik;
  final List<String> daftarKategori;

  const ComicEditPage({
    super.key,
    required this.komik,
    required this.daftarKategori,
  });

  @override
  State<ComicEditPage> createState() => _ComicEditPageState();
}

class _ComicEditPageState extends State<ComicEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController judulController;
  late TextEditingController deskripsiController;
  late String kategoriTerpilih;

  @override
  void initState() {
    super.initState();
    judulController = TextEditingController(text: widget.komik['judul']);
    deskripsiController =
        TextEditingController(text: widget.komik['deskripsi']);
    kategoriTerpilih = widget.komik['kategori']!;
  }

  @override
  void dispose() {
    judulController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  void perbarui() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'judul': judulController.text.trim(),
        'deskripsi': deskripsiController.text.trim(),
        'kategori': kategoriTerpilih,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Komik')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: judulController,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (nilai) {
                  if (nilai == null || nilai.trim().isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                isExpanded: true,
                value: kategoriTerpilih,
                items: widget.daftarKategori
                    .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                    .toList(),
                onChanged: (nilai) {
                  setState(() {
                    kategoriTerpilih = nilai!;
                  });
                },
              ),
              const SizedBox(height: 24),
              FilledButton.tonal(
                onPressed: perbarui,
                child: const Text('Perbarui'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}