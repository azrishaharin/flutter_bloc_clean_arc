final stopwatch = Stopwatch();

void main() {
  stopwatch.start();
  print('Start ${stopwatch.elapsed})');
  print('Start2 ${stopwatch.elapsed})');
  print('Start3 ${stopwatch.elapsed})');
  doSomethingAsync();
  print('End1 ${stopwatch.elapsed})');
  print('End2 ${stopwatch.elapsed})');
}

Future<void> doSomethingAsync() async {
  print('StartAsync ${stopwatch.elapsed})');
  print('StartAsync2 ${stopwatch.elapsed})');
  print('StartAsync3 ${stopwatch.elapsed})');
  Future.delayed(const Duration(seconds: 2));
  print('SomethingAsync finished ${stopwatch.elapsed})');
  print('SomethingAsync2 finished ${stopwatch.elapsed})');
  print('SomethingAsync3 finished ${stopwatch.elapsed})');
}
