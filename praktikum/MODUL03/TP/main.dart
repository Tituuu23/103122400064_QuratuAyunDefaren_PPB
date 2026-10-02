void main() {
  int A = 3;
  int B = 2;

  List<List<int>> matriks = [
    [8, 4],
    [5, 6],
    [9, 4],
  ];

  print('Matriks A x B');
  print('A: $A');
  print('B: $B');
  print('Isi matriks:');

  tampilkanMatriks(matriks);

  List<List<int>> transpose = [];

  for (int kolom = 0; kolom < B; kolom++) {
    List<int> barisBaru = [];

    for (int baris = 0; baris < A; baris++) {
      barisBaru.add(matriks[baris][kolom]);
    }

    transpose.add(barisBaru);
  }

  print('\nHasil transpose:');
  tampilkanMatriks(transpose);
}

// Fungsi untuk menampilkan matriks
void tampilkanMatriks(List<List<int>> matriks) {
  for (List<int> baris in matriks) {
    print(baris.join(' '));
  }
}