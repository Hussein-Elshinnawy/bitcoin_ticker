import 'dart:convert';
import 'package:http/http.dart' as http;
class NetwrokCall{

  NetwrokCall(this.url);
  final Uri url;
  Future callApi() async{
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // Handle error case
      print('Request failed with status: ${response.statusCode}');
    }
  }



}