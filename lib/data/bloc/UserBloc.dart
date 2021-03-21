
import 'package:flutter/material.dart';

class UserBloc extends ChangeNotifier{

String _userName = '';
String _token = '';
String get userName => _userName;
String get token => _token;

set userName(String name){
  _userName = name;
  notifyListeners();
}
set token(String token){
  _token = token;
  notifyListeners();
}

  
}