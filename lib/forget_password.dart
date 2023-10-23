import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
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
          ElevatedButton(
            onPressed: () async {
              await forgetPassword(emailController.text.trim());
            },
            child: Text('Send Email'),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Back'),
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> forgetPassword(email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // إذا تم إرسال البريد الإلكتروني بنجاح، يمكنك عرض رسالة نجاح
      Fluttertoast.showToast(
        msg: "تم إرسال رسالة إعادة تعيين كلمة المرور إلى البريد الإلكتروني الخاص بك",
      );
    }on FirebaseAuthException catch (e) {
      // إذا حدث خطأ أثناء إرسال البريد الإلكتروني، يمكنك عرض رسالة خطأ
      Fluttertoast.showToast(
        msg: "حدث خطأ أثناء إرسال البريد الإلكتروني: $e",
      );
    }
  }
}
