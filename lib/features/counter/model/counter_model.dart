class CounterModel {
  CounterModel(this.value);

  final int value;

  int get count => value;

  CounterModel increment() => CounterModel(value + 1);
}
