class Ticker {
  const Ticker();

  /// Returns a stream of seconds based on the entered value with an interval of one second
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
