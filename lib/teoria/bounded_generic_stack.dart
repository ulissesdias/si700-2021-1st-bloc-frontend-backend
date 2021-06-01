import 'package:aula09_2021/teoria/quadrado.dart';
import 'package:aula09_2021/teoria/rectangle.dart';

class Stack<T extends Rectangle> {
  List<T> _stack = [];

  void push(T item) => _stack.add(item);
  T pop() => _stack.removeLast();
}

void main() {
  final stackQ = Stack<Quadrado>();
  final stackR = Stack<Rectangle>();

  // Abaixo a linha gera erro.
  // final stackS = Stack<String>();
}
