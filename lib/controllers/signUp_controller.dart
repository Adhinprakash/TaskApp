import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:taskapp/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:taskapp/view/login/login_screen.dart';
import 'package:taskapp/view/task/task_list_screen.dart';

class Registercontroller extends GetxController {
  final usernamecontroller = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

RxBool _isloding=false.obs;
RxBool get isloading =>_isloding;


  Future<void> register() async {
    final url = buildBaseUrl('/register');
isloading.value=true;
    try {

   
      final response = await http.post(url, headers:  {'Content-Type': 'application/json',"Accept": "application/json",}, body: jsonEncode({
  'username':usernamecontroller.value.text,
  'password':passwordController.value.text
      }));

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        print(response.statusCode);
        print(data);
        isloading.value=false;
        usernamecontroller.value.clear();
        passwordController.value.clear();
        Get.offAll(LoginScreen());
      } else {
        isloading.value=false;
        throw json.decode(response.body)['message'] ?? 'unknown error';

      }
    } catch (e) {
              isloading.value=false;
    Get.snackbar("error", '${e.toString()}');
    
    }
  }
}
