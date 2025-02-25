import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskapp/view/login/login_screen.dart';
import 'package:taskapp/view/register/register_screen.dart';
import 'package:taskapp/view/task/task_list_screen.dart';

void main() async{
  runApp(const MyApp());
   WidgetsFlutterBinding.ensureInitialized();  // Add this line
  await SharedPreferences.getInstance(); 
  HttpOverrides.global=MyHttpOverrides();
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/login',
       getPages: [
      GetPage(name: '/login', page: () => LoginScreen()),
      GetPage(name: '/tasklist', page: () => 
      TaskListScreen()), // Create HomePage
      GetPage(name: '/register', page: ()=>RegisterScreen())
    ],
      theme: ThemeData(
       
        useMaterial3: true,
      ),
      home: LoginScreen()
    );
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

