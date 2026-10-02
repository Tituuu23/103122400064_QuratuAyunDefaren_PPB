int cariFPB(int a, int b) {
  while (b != 0) {
    int sisa = a % b;
    a = b;
    b = sisa;
  }

  return a;
}

void main() {
  int bilangan1 = 48;
  int bilangan2 = 18;

  print('Bilangan 1: $bilangan1');
  print('Bilangan 2: $bilangan2');
  print('FPB $bilangan1 dan $bilangan2 = ${cariFPB(bilangan1, bilangan2)}');

  print('');

  bilangan1 = 27;
  bilangan2 = 18;

  print('Bilangan 1: $bilangan1');
  print('Bilangan 2: $bilangan2');
  print('FPB $bilangan1 dan $bilangan2 = ${cariFPB(bilangan1, bilangan2)}');
}