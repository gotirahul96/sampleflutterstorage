import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sampleflutterstorage/data/providers/GetTokenProvider.dart';
import 'package:sampleflutterstorage/data/services/auth.service.dart';
import 'package:sampleflutterstorage/util/Global.dart';
import 'package:sampleflutterstorage/util/Size_Config.dart';
import 'package:toast/toast.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController userName = TextEditingController();
  final Auth _auth = Auth();

  gettoken(){
    setState(() => Global.isLoading = true);
    getToken(
      user: userName.text
    ).then((value){
      setState(() => Global.isLoading = false);
      if (value.error == null)  {
       _auth.writeSecureData('user', userName.text);
       _auth.writeSecureData('token', value.token);
        Navigator.of(context).pushNamed('homescreen');
      } else {
        Toast.show(value.error.message, context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
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
                title: Text('Sign up'),
                centerTitle: true,
                elevation: 0,
                
              ),
              body: LayoutBuilder(
              builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                margin: EdgeInsets.only(top : 5 , left : 10, right : 10),
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
             TextFormField(
               controller: userName,
               decoration: InputDecoration(
                 hintText: 'Enter UserName',
                 isDense: true,
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20)
                 )
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top : 10.0),
               child: FloatingActionButton(
                 child: Icon(Icons.arrow_forward_ios),
                 onPressed: gettoken),
             )
           ]))));}))))
    );
  }
}