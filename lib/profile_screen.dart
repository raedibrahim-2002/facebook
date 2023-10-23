import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool obscureText = true;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final fireStore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;

  String imageUrl = '';
  bool loading = false;

  @override
  void initState() {
    getUserDataInLocalDataSource();
    getUserData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (imageUrl.isEmpty)
                InkWell(
                  onTap: () => pickImage(),
                  borderRadius: BorderRadius.circular(25),
                  child: const CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      size: 45,
                    ),
                  ),
                )
              else
                Stack(
                  alignment: Alignment.center,
                  children: [
                    InkWell(
                      onTap: () => pickImage(),
                      borderRadius: BorderRadius.circular(25),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                    ),
                    Visibility(
                      visible: loading,
                      child: const CircularProgressIndicator(),
                    ),
                  ],
                ),
              const SizedBox(height: 15),
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
                controller: phoneController,
                maxLength: 11,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => saveUserData(),
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveUserData() {
    final userId = auth.currentUser!.uid;

    fireStore.collection('users').doc(userId).update({
      'name': nameController.text,
      'phone': phoneController.text,
    });
  }

  void getUserData() {
    final userId = auth.currentUser!.uid;

    fireStore.collection('users').doc(userId).get().then((value) {
      saveUserDataInLocalDataSource(value.data()!);
// here we can let using that method because we will store data after it come علطوووول
//       updateUi(value.data()!);
    }).catchError((error) {});
  }

// in Json we can convert from one type to other and reverse in the same time...ex(map => string , string => map)
  void saveUserDataInLocalDataSource(Map<String, dynamic> map)
  async {
    final json = jsonEncode(map);
    //here we stored map in userData but in String style ضحكنا عليه
    PreferenceUtils.setString('userData', json);
  }

  getUserDataInLocalDataSource()
 async {
  final json = PreferenceUtils.getString('userData');
 final userData = jsonDecode(json!);
 updateUi(userData);
  }

  void updateUi(Map<String, dynamic> map) {
    setState(() {
    nameController.text = map['name'];
    phoneController.text = map['phone'];
    emailController.text = map['email'];

      imageUrl = map['imageUrl'];
    });
  }

  //1- Pick image from gallery
  // 2-Upload image to FirebaseStorage
  // 3-Get image url from FirebaseStorage
  // 4-Save image url to FirebaseFirestore Database

  // to select image from gallery
  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    // file = the image you choose
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );

// image = the path of the file in the form of flutter file "XFile"
    final image = File(file!.path);

    uploadImage(image);
  }

  // upload image to store
  void uploadImage(File image) {
    setState(() {
      loading = true;
    });
    final userId = auth.currentUser!.uid;

    // profileImage = the name of the folder ,,,,,,putFile = the insert the image in the storage
    storage.ref('profileImages/$userId').putFile(image).then((value) {
      print('uploadImage => SUCCESS');
      getImageUrl();
    }).catchError((error) {
      setState(() {
        loading = false;
      });
      print('uploadImage => $error');
    });
  }

  // to get the image you uploaded in the store by the userId
  void getImageUrl() {
    final userId = auth.currentUser!.uid;

    // imageUrl = the link of the image in the fireStore
    storage.ref('profileImages/$userId').getDownloadURL().then((imageUrl) {
      print(imageUrl);
      setState(() {
        this.imageUrl = imageUrl;
        loading = false;
      });
      saveImageUrl(imageUrl);
    }).catchError((error) {
      Fluttertoast.showToast(msg: error);
    });
  }

  void saveImageUrl(String imageUrl) {
    final userId = auth.currentUser!.uid;

    fireStore.collection('users').doc(userId).update({
      'imageUrl': imageUrl,
    });
  }
}
