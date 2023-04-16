import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/page/home_page.dart';
import 'package:my_app/reuseblewidget/reuse_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 4,
        title: Text(
          'Sign Up',
          style: TextStyle(
              color: ThemeData().scaffoldBackgroundColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LogoWidget("assets/images/img_profile.png"),
                const SizedBox(
                  height: 50,
                ),
                reusableTextField(
                  " username",
                  Icons.account_circle_rounded,
                  false,
                  _usernameController,
                ),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField(
                  " email",
                  Icons.email_rounded,
                  false,
                  _emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                reusableTextField(
                  " password",
                  Icons.lock_rounded,
                  true,
                  _passwordController,
                ),
                const SizedBox(
                  height: 10,
                ),
                signInSignUpButton(context, false, () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  }).catchError((error, stackTrace) {
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Email or password is incorrect"),
                            content: Text(error.message),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  });
                  print("Email or password is incorrect");
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
