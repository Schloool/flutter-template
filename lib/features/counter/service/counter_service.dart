class CounterService {
  Future<int> fetchInitialCount() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    return 0;
  }
}
