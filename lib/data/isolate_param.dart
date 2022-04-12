import 'dart:isolate';

class IsolateParams<T> {
  final SendPort sendPort;
  final T? data;

  IsolateParams({required this.sendPort, this.data});
}
