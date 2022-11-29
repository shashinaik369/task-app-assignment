import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tasks_app_asignment/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/container_widget.dart';
import '../widgets/text_input_field.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _rePassController = TextEditingController();

  void createAccount(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String recheckPass = _rePassController.text.trim();
    if (email == '' || password == '' || recheckPass == '') {
    
      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                           backgroundColor: Colors.black,
            content: Text('fields not be empty'),
                        ),
                      );
      
    } else if (password != recheckPass) {
        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                           backgroundColor: Colors.black,
            content: Text('passwords not matched'),
                        ),
                      );
    } else {
      try {
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pop(context);
           ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                           backgroundColor: Colors.black,
            content: Text('account created successfully'),
                        ),
                      );
        }
      } on FirebaseAuthException catch (ex) {
        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                           backgroundColor: Colors.black,
            content: Text(ex.code.toString()),
                        ),
                      );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Create your account",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 15,
              ),
              customContainer(
                child: TextInputField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Iconsax.game,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              customContainer(
                child: TextInputField(
                  controller: _passwordController,
                  hintText: 'Password',
                  icon: Iconsax.lock,
                  isObscure: true,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              customContainer(
                child: TextInputField(
                  controller: _rePassController,
                  hintText: 'Password',
                  icon: Iconsax.lock,
                  isObscure: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 321,
                height: 76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(39),
                  color: const Color(0xff1adda8),
                ),
                child: InkWell(
                  onTap: () {
                    createAccount(context);
                  },
                  child: const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: buttonColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
