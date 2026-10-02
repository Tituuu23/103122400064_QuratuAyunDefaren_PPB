void cariPosisi(int nilai, List<List<int>> data) {
  bool ditemukan = false;

  for (int i = 0; i < data.length; i++) {
    for (int j = 0; j < data[i].length; j++) {
      if (data[i][j] == nilai) {
        print('$nilai berada di: baris ${i + 1} kolom ${j + 1}');
        ditemukan = true;
      }
    }
  }

  if (!ditemukan) {
    print('$nilai tidak ditemukan di dalam List.');
  }
}

void main() {
  List<List<int>> data = [
    [5, 10, 15],
    [2, 4, 6, 8],
    [1, 4, 9, 16, 25],
    [3, 4, 5, 6, 7, 8],
  ];

  print('Isi List:');
  for (List<int> baris in data) {
    print(baris.join(' '));
  }

  print('');

  int nilai = 2;

  print('Bilangan yang dicari: $nilai');
  cariPosisi(nilai, data);

  print('\n-------------------------\n');

  nilai = 11;

  print('Bilangan yang dicari: $nilai');
  cariPosisi(nilai, data);
}