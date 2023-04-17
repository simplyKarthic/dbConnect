class Counter {
  int _counter = 0;
  int get count => _counter;

  void incrementcounter() {
    _counter++;
  }

  void decrementcounter() {
    _counter--;
  }

  void resetcounter() {
    _counter = 0;
  }

}