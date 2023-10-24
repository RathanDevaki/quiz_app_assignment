import 'package:flutter/material.dart';
import 'package:quiz_app_assignment/Components/constants.dart';
import 'package:quiz_app_assignment/Domain/authFunctions.dart';
import '../Components/controllers.dart';
import '../Components/router.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  MyRouter myRouter = MyRouter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //-----------------Heading
                Container(
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
                  child: Form(
                    key: _formkey,
                    child: Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //----------------- Header Text
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Text("Create Account",
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w800,
                                      color: ThemeColor)),
                            ),
                            //----------------- Name field
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Enter your Name",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Name';
                                  }
                                },
                                controller: nameController,
                              ),
                            ),
                            //----------------- Email field
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
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
                                controller: emailController,
                              ),
                            ),
                            //-----------------Password field
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: TextFormField(
                                obscureText: !_isPasswordVisible,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: "Enter your Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                controller: passController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Password';
                                  }
                                },
                              ),
                            ),
                            //-----------------Confirm password field
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8.0),
                              child: TextFormField(
                                obscureText: !_isPasswordVisible,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  hintText: "Enter Confirm Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                ),
                                controller: confirmPassController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Password';
                                  } else if (value != passController.text) {
                                    return 'Password doesn\'t match';
                                  }
                                },
                              ),
                            ),
                            //----------------- Show / hide password
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _isPasswordVisible,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _isPasswordVisible = value!;
                                        },
                                      );
                                    },
                                  ),
                                  const Text('Show Password'),
                                ],
                              ),
                            ),

                            //-----------------Sign Up button
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    username = nameController.text;
                                    email = emailController.text;
                                    password = passController.text;

                                    signUp(username, email, password);
                                    showSnackBar(
                                        context, 'Registered Succesfully');
                                    await Future.delayed(
                                      const Duration(milliseconds: 2000),
                                    );

                                    myRouter.pushToSignIn(context);
                                  }
                                },
                                icon: const Icon(Icons.navigate_next, size: 30),
                                label: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                      color: ThemeColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            //----------------- Move to sign In
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 20),
                              child: GestureDetector(
                                onTap: () {
                                  myRouter.pushToSignIn(context);
                                },
                                child: const Text(
                                  "Already Registred? Login Now",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
