import 'package:facebook/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final fireStore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  

  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();

  }
  bool obsecure = true;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessenger(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Register'),
          ),
          body: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  maxLength: 11,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller: passwordController,
                    obscureText: obsecure,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obsecure = !obsecure;
                          setState(() {});
                        },
                        icon: Icon(
                            obsecure ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        String email=emailController.text;
                        String password = passwordController.text;

                        createAccount(email, password);
                      },
                      child: Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createAccount(String email, String password) async {
    // FirebaseAuth.instance.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // ).then((value) {
    //   Fluttertoast.showToast(msg: "AccountCreated!");
    //   Navigator.pop(context);
    // })
    // .catchError((error){
    //   Fluttertoast.showToast(msg: error.toString());
    // });

    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      onRegisterSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void onRegisterSuccess() {
    saveUserData();
    Fluttertoast.showToast(msg: "AccountCreated!");
    Navigator.pop(context);
  }

  void saveUserData() {
    final userId = auth.currentUser!.uid;

    fireStore.collection('users').doc(userId).set({
      'userId': userId,
      'name' : nameController.text,
      'phone' : phoneController.text,
      'email' : emailController.text,
      'imageUrl' : '',
    });
  }

  // void createAccount(String email,String password )async{
  //   try {
  //     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     Fluttertoast.showToast(msg: 'account created');
  //     Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       Fluttertoast.showToast(msg: 'The password provided is too weak.');
  //     }
  //     else if (e.code == 'email-already-in-use') {
  //       Fluttertoast.showToast(msg: 'The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // void login() {
  //   if (!formKey.currentState!.validate()) {
  //     return;
  //   }
  //
  //   String email = emailController.text;
  //   String password = passwordController.text;
  //
  //   if (email == 'raed@gmail.com' && password == '123456') {
  //     Navigator.pushReplacement(context, MaterialPageRoute(
  //       builder: (context) {
  //         return Login();
  //       },
  //     ));
  //   } else {
  //     // return snackBar();
  //     return displayToast();
  //   }
  // }

  // void snackBar() {
  //   showTopSnackBar(
  //     Overlay.of(context),
  //     CustomSnackBar.success(
  //       message: "email or password is false",
  //     ),
  //   );
  // }

  // void displayToast() {
  //   Fluttertoast.cancel();
  //   Fluttertoast.showToast(
  //       msg: "email or password is false",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }
}
