class BaseTestCase {
  void given(Function task) {
    task();
  }

  void when(Function task) {
    task();
  }

  void then(Function task) {
    task();
  }
}
