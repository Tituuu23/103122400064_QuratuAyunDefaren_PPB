int cariKPK(int a, int b) {
  int kpk = a > b ? a : b;

  while (true) {
    if (kpk % a == 0 && kpk % b == 0) {
      return kpk;
    }
    kpk++;
  }
}

void main() {
  int bilangan1 = 12;
  int bilangan2 = 8;

  print('Bilangan 1: $bilangan1');
  print('Bilangan 2: $bilangan2');
  print('KPK $bilangan1 dan $bilangan2 = ${cariKPK(bilangan1, bilangan2)}');

  print('');

  bilangan1 = 15;
  bilangan2 = 20;

  print('Bilangan 1: $bilangan1');
  print('Bilangan 2: $bilangan2');
  print('KPK $bilangan1 dan $bilangan2 = ${cariKPK(bilangan1, bilangan2)}');
}