import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sampleflutterstorage/data/bloc/UserBloc.dart';
import 'package:sampleflutterstorage/data/models/GetUserData.dart';
import 'package:sampleflutterstorage/data/providers/GetUserProvider.dart';
import 'package:sampleflutterstorage/data/services/auth.service.dart';
import 'package:sampleflutterstorage/util/Global.dart';
import 'package:sampleflutterstorage/util/Size_Config.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController userName = TextEditingController();
  final Auth _auth = Auth();
  GetUserData getUserData = GetUserData();
  
  @override
  void initState() {
    super.initState();
    initData();
  }
  initData({String user, String token}){
    WidgetsBinding.instance.addPostFrameCallback((_){
    _auth.readSecureData('user').then((valueuser) {
      
      _auth.readSecureData('token').then((valuetoken) {
      
      setState(() => Global.isLoading = true);
    getuserData(
      user: valueuser,token: valuetoken
    ).then((value) {
      setState(() => Global.isLoading = false);
      if (value.error == null) {
        setState(() {
          getUserData = value;
        });
      } else {
        Toast.show(value.error.message, context);
      }
    });
    });
      
    });
    
    
});
  }
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<UserBloc>(context);
    
     
    
    return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: Colors.black,
        progressIndicator: CircularProgressIndicator(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
          child: Scaffold( 
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                title: Text('Home Screen'),
                centerTitle: true,
                elevation: 0,
                
              ),
              body: LayoutBuilder(
              builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                margin: EdgeInsets.only( top : 5 , left : 10, right : 10),
                width: double.infinity,   
                height: SizeConfig.screenHeight,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.max,
           children: [
             Text('UserName : ${getUserData.user.username}',style: TextStyle(
               fontSize: 18
             ),),
             Text('Credits : ${getUserData.user.credits}',style: TextStyle(
               fontSize: 18
             ),),
           ]))));}))))
    );
  }
}