import 'iExternalValue.dart';

class ExternalValues implements IExternalValues {
  @override
  String getBaseUrl() {
   // return 'http://192.168.18.12:4000/v1/';
    return 'https://api.coincap.io/v2/';
  }

  @override
  String getSocketUrl() {
  //  return 'http://192.168.18.12:4000/';
    return 'http://api.dadss.com.au/';
  }
}
