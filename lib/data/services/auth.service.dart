
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth {
  final _storage = FlutterSecureStorage();
  
  Future writeSecureData(String key, String value)   {
    var writeData =  _storage.write(key: key, value: value);
    return writeData;
  }
  Future readSecureData(String key)  {
    var readData =  _storage.read(key: key);
    return readData;
  }
}