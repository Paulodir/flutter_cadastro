/*import 'package:http/http.dart' as http;
import 'dart:convert';
import 'helpers/contact_helper.dart';
*/
/*
const BASE_URL = "http://api.com.br/";

class Api {
  String token;
  Api(this.token);

  Future<void> login(String email, String senha) async {
    String url = BASE_URL + "/login";
    http.Response response = await http.post(url, body: jsonEncode({"senha": senha,"email": email}),
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<Contact> update(String codigoContato) async {
    http.Response response = await http.patch(BASE_URL+'/'+codigoContato,headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return new Contact.fromMap(json.decode(response.body));
    } else {
      return null;
    }
  }
  Future<bool> delete(String codigoContato) async {
    http.Response response = await http.delete(BASE_URL+'/'+codigoContato,headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  Future<Contact> get() async {
    http.Response response = await http.get(BASE_URL,headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return new Contact.fromMap(json.decode(response.body));
    } else {
      return null;
    }
  }

}*/
