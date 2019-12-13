void main() {
  List<int> A = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 9];
  List<int> B = List<int>(A.length);
  var C = List<int>(10);
  C.fillRange(0, 10, 0);

  for (int i = 0; i < A.length; i++) {
    C[A[i]]++;
  }
  print(C);
  for (int i = 1; i < C.length; i++)
    //
    C[i] += C[i - 1];
  print(C);
  for (int i = A.length - 1; i >= 0; i--) {
    B[--C[A[i]]] = A[i];
  }
  print(B);
}
