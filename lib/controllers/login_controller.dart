import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/utils/api_endpoints.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskapp/view/task/task_list_screen.dart';
class LoginController extends GetxController{
  final usernamecontroller = TextEditingController().obs;
  final passwordController = TextEditingController().obs;


RxBool _isloggedin=false.obs;

RxBool get isloggedin =>_isloggedin;


RxBool _isloding=false.obs;
RxBool get isloading =>_isloding;


  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }


// this is to check if the user is already loggedin or not

// by getting the value from SharedPreferences
  Future<void> checkLoginStatus()async {

    final prefs=await SharedPreferences.getInstance();
    _isloggedin.value= prefs.getBool('isLoggedin')??false;
    if(_isloggedin.value){
      Get.offAllNamed('/tasklist');
    }
  }
  Future<void>login()async{
final url=buildBaseUrl('/login');
print(usernamecontroller.value.text);
print(passwordController.value.text);

_isloding.value=true;
    try {

         
final response=await http.post(url,body:jsonEncode({
  'username':usernamecontroller.value.text,
  'password':passwordController.value.text
}),headers: {'Content-Type': 'application/json',"Accept": "application/json",});
print(response.statusCode);
if(response.statusCode==200){
  _isloding.value=false;
_isloggedin.value=true;

final prefs =await SharedPreferences.getInstance();
await prefs.setBool('isLoggedin', true);
var data=jsonDecode(response.body);
      print("Login successful: ${data['message']}");



        Get.snackbar("welcome", '${data['message']}');

 usernamecontroller.value.clear();
          passwordController.value.clear();
 Get.offAllNamed('/tasklist');
}else{
  _isloding.value=false;
  throw json.decode(response.body)['error']??'unknown error';
}
    } catch (e) {
      _isloding.value=false;
    Get.snackbar("error", '${e.toString()}');
    }
  }

}