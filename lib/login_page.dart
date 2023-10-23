import 'package:facebook/forget_password.dart';
import 'package:facebook/register.dart';
import 'package:facebook/display_home.dart';
import 'package:facebook/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // bool obscure = true;

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoggedIn();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                      height: 222,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVJzqJGCeXLi6A8C6FPQt5hYZGheKJV1ZoqA&usqp=CAU'),
                  const SizedBox(
                    height: 18,
                  ),
                  EmailTextFormField(emailController: emailController),
                  PasswordTextFormField(passwordController: passwordController),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                            ),
                            child: const Text('log In'),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ForgetWidget(),
                        const SizedBox(
                          height: 7,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                  thickness: 1,
                                  color: Colors.black45,
                                  indent: 120),
                            ),
                            Text('or'),
                            Expanded(
                              child: Divider(
                                  thickness: 1,
                                  color: Colors.black45,
                                  endIndent: 120),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Register();
                                },
                              ),
                            );
                          },
                          child: const Text("Create New Facebook Account"),
                        ),
                      ],
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

  void login() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    String email = emailController.text;
    String password = passwordController.text;

    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then(
      (value) {
        saveLoggedIn();

        // isLoggedIn();

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return DisplayHome();
          },
        ), (route) => false);
      },
    ).catchError((error) {
      if (error.code == 'user-not-found') {
        displayToast('No user found for that email.');
      } else if (error.code == 'wrong-password') {
        displayToast('Wrong password provided for that user.');
      }
      Fluttertoast.showToast(msg: error.toString());
    });

  }

  void isLoggedIn()async {
    final loggedIn = PreferenceUtils.getBool('loggedIn');
    print("loggedIn => $loggedIn");
  }
  void saveLoggedIn()
  async{
    PreferenceUtils.setBool('loggedIn', true);
  }


  void displayToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

}

class ForgetWidget extends StatelessWidget {
  const ForgetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ForgetPassword();
              },
            ),
          );
        },
        child: const Text(
          "Forgotten Password?",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.passwordController,
  });

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 7) {
            return 'please enter valid password';
          }
          return null;
        },
        controller: passwordController,
        // obscureText: obscure,
        decoration: const InputDecoration(
          hintText: "Password",
        ),
      ),
    );
  }
}

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your email';
          }
          // not contain
          if (!value.contains('@') || !value.contains('.')) {
            return 'please enter valid email';
          }
          return null;
        },
        controller: emailController,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: "Phone number or email address",
        ),
      ),
    );
  }
}
