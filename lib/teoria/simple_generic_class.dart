class SimpleGenericClass<T> {
  T _value;

  set value(T newValue) {
    _value = newValue;
  }

  T get value {
    if (true) {
      return _value;
    }
  }
}

void main() {
  SimpleGenericClass<String> b = SimpleGenericClass<String>();
  SimpleGenericClass<int> c = SimpleGenericClass<int>();
}
