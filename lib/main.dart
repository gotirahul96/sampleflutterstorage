import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleflutterstorage/data/bloc/UserBloc.dart';
import 'package:sampleflutterstorage/data/services/auth.service.dart';
import 'package:sampleflutterstorage/screens/Auth/SignUp.dart';
import 'package:sampleflutterstorage/screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  Widget _defaultHome = SignIn();
  final Auth _auth = Auth();
  String user = '';
  String token = '';
  @override
  void initState() { 
    super.initState();
    initData();
  }
  initData(){
    _auth.readSecureData('user').then((value) {
      if (value != null) {
      setState(() {
        _defaultHome = HomeScreen();
      });
      _auth.readSecureData('user').then((value) {
      setState(() {
        user = value;
      });
      
    });
    _auth.readSecureData('token').then((value) {
      setState(() {
        token = value;
      });
    });
    }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserBloc>(
      create: (context) => UserBloc(),
      builder: (context, child) { 
        var bloc = Provider.of<UserBloc>(context);
     WidgetsBinding.instance.addPostFrameCallback((_){ 
       bloc.userName = user;
       bloc.token = token;
     });
        return MaterialApp(
        title: 'Flutter StorageDemo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _defaultHome,
        routes: <String,WidgetBuilder>{
          'homescreen' : (BuildContext context) => HomeScreen(),
        },
      );}
    );
  }
}

