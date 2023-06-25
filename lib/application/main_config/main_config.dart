



import '../../di/di.dart';

Future<void> initMainServiceLocator() async {
  await setup();
  return inject.allReady();
}
