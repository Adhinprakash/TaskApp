import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:taskapp/const/app_consts.dart';
import 'package:taskapp/controllers/login_controller.dart';
import 'package:taskapp/view/widgets/text_fieild_widget.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Sign in with your Username and password  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF757575)),
                  ),
                  // const SizedBox(height: 16),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    SizedBox(
                        height: 300,
                        child: Lottie.asset(
                          'assets/animations/Animation - 1740463052852.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),
                  Column(
                    children: [
                         InputTextField(
                        controller: loginController.usernamecontroller.value,
                        hintText: "Enter your username",
                        labelText: "username",
                        svgIcon: mailIcon,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                        Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: InputTextField(
                          controller: loginController.passwordController.value,
                          hintText: "Enter your password",
                          labelText: "Password",
                          svgIcon: lockIcon,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                      
                    
                      Obx(() {
                        return ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              loginController.login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 48),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          ),
                         
                          child: loginController.isloading.value
                              ? const CircularProgressIndicator(color: Colors.white,)
                              : const Text('Login'),
                        );
                      })
                    ],
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
 const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.black),
                        ),
                       Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child:InkWell(
                          onTap: () => Get.offAllNamed('/register'),
                          child:  Text(
                          "SignUp",
                          style: TextStyle(color: Colors.blue),
                        ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);
