import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:taskapp/const/app_consts.dart';
import 'package:taskapp/controllers/signUp_controller.dart';
import 'package:taskapp/view/widgets/text_fieild_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Registercontroller registercontroller=Get.put(Registercontroller());

        final _formKey = GlobalKey<FormState>();

  @override

  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Form
                    
                    (
                      key: _formKey,
                      child: 
                    Column(
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
                        const SizedBox(height: 8),
                        const Text(
                          "Create an new account",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF757575)),
                        ),
                        // const SizedBox(height: 16),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),

                              SizedBox(
                        height: 300,
                        child: Lottie.asset(
                          'assets/animations/Animation - 1740463052852.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Column(
                            children: [
                            
                            InputTextField(
                                controller: registercontroller.usernamecontroller.value,
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
                          controller: registercontroller.passwordController.value,
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
                            
                            
                             Obx((){
                              return  ElevatedButton(
                          
                                onPressed: ()  async{
                                   if (_formKey.currentState!.validate()) {
                      registercontroller.register();
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
                             
                                child:registercontroller.isloading.value?const CircularProgressIndicator(color: Colors.white,):
                                 const Text('SignUp'),
                              );
                             })
                            ],
                          ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.10),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black),
                        ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 8),
                                  child:InkWell(
                                    onTap: (){
Get.offAllNamed('/login');
                                    },
                                    child:  const Text(
                                "Login",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  )
                                )
                          ],
                        ),
                       
                      ],
                    ),
                    )
                  ),
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