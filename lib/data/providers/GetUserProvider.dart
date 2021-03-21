import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sampleflutterstorage/data/models/GetUserData.dart';


Future<GetUserData> getuserData({String user,String token}) async {
 
  Map<String, String> headers = {'Authorization': 'Bearer $token' };
  print(token);
  print(user);
  final response = await http.get('https://api.spacetraders.io/users/$user',headers: headers,
                                   );
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    
    return GetUserData.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else if (response.statusCode > 400) {
    // If the call to the server was successful, parse the JSON
    
    return GetUserData.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    print(response.statusCode);
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}