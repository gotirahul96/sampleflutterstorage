import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sampleflutterstorage/data/models/GetTokenModel.dart';


Future<GetTokenModel> getToken({String user}) async {
 
  Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
  
  final response = await http.post('https://api.spacetraders.io/users/$user/token',headers: headers,
                                   );
      print(response.body);
  if (response.statusCode == 201) {
    // If the call to the server was successful, parse the JSON
    
    return GetTokenModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else if (response.statusCode > 400) {
    // If the call to the server was successful, parse the JSON
    
    return GetTokenModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    print(response.statusCode);
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}