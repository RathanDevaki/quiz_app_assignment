import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_assignment/Domain/authFunctions.dart';
import 'package:quiz_app_assignment/Provider/quiz_provider.dart';

import '../Components/constants.dart';
import '../Components/controllers.dart';
import '../Components/router.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username = '';

  bool _isPasswordVisible = false;
  bool _isLogged = false;

  @override
  Widget build(BuildContext context) {
    MyRouter myRouter = MyRouter();

    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: ThemeColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    blurRadius: 12,
                    offset: Offset(1, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                    key: _formkey,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //-----------------Heading
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text("Sign In",
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w800,
                                      color: ThemeColor)),
                            ),
                            //-----------------Email field

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    hintText: "Enter your Email",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Email ID';
                                  }
                                  return null;
                                },
                                controller: emailController1,
                              ),
                            ),
                            //-----------------Password field
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock),
                                    hintText: "Enter your Password",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)))),
                                controller: passController1,
                                obscureText: !_isPasswordVisible,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Password';
                                  }
                                },
                              ),
                            ),
                            //-----------------show / hide password
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _isPasswordVisible,
                                    onChanged: (value) {
                                      setState(() {
                                        _isPasswordVisible = value!;
                                      });
                                    },
                                  ),
                                  const Text('Show Password'),
                                ],
                              ),
                            ),
                            //-----------------Sign in button
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    email = emailController1.text;
                                    password = passController1.text;

                                    _isLogged = await signIn(email, password);

                                    if (_isLogged) {
                                      myRouter.pushToDashboard(context);
                                    } else {
                                      showSnackBar(context, 'Login Failed.!');
                                    }
                                  }
                                },
                                icon: const Icon(Icons.navigate_next, size: 30),
                                label: const Text('Sign In'),
                              ),
                            ),

                            //----------------- Sign Up Text
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 40),
                              child: GestureDetector(
                                onTap: () {
                                  myRouter.pushToSignUp(context);
                                },
                                child: const Text(
                                  "Dont have an account? Create Now",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 2, 38, 68),
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
