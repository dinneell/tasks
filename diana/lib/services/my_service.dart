import 'package:logger/logger.dart';

final logger = Logger();

class MyService {
  void doSomething() {
    logger.i("MyService is working!");
  }
}

