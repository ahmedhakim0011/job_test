import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_service.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SignUp> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController rePasswordTextController = TextEditingController();

  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'TutorialKart',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: rePasswordTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Retype Password',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text(
                    'Forgot Password',
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        final result =
                            await context.read<AuthenticationService>().signUp(
                                  email: emailTextController.text.trim(),
                                  password: passwordTextController.text.trim(),
                                );

                        showSnackbar(context, result);

                        if (result == "Signed up") {
                          Navigator.popUntil(
                              context, ModalRoute.withName('/auth'));
                        }

                        print(emailTextController.text);
                        print(passwordTextController.text);
                      },
                    )),
                Row(
                  // ignore: sort_child_properties_last
                  children: [
                    Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/signin');
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )));
  }

  showSnackbar(BuildContext context, String? result) {
    return SnackBar(
      content: const Text('Yay! A SnackBar!'),
    );
  }
}
