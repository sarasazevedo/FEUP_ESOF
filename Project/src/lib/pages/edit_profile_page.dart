import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final usernameController = TextEditingController(text: "...");
  final universityController = TextEditingController(text: "...");

  Future getData() async {
    final users = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (users.exists) {
      Map<String, dynamic> data = users.data() as Map<String, dynamic>;
      usernameController.text = data['username'];
      universityController.text = data['university'];
    }
  }

  Future updateUserDetails(String username, String university) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'username': username,
      'university': university,
    });
  }

  void submitUserDetails() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (usernameController.text.trim() != "") {
        updateUserDetails(
          usernameController.text.trim(),
          universityController.text.trim(),
        );
        if (mounted) Navigator.pop(context);
        errorMessage('Profile updated!');
      } else {
        Navigator.pop(context);
        errorMessage("Username must not be empty!");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorMessage(e.message.toString());
    }
  }

  void errorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFAFAFA),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    //intro text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: const [
                          Text(
                            'Let\'s Edit your Profile',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 90,
                      child: Image.asset(
                        'lib/icons/temp2.png',
                      ),
                    ),
                    const SizedBox(height: 20),
                    //username input box
                    LoginTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      obscureText: false,
                      max: 1,
                    ),
                    const SizedBox(height: 10),
                    //university input box
                    LoginTextField(
                      controller: universityController,
                      hintText: 'University',
                      obscureText: false,
                      max: 1,
                    ),
                    const SizedBox(height: 30),
                    //sign in button
                    GestureDetector(
                      onTap: submitUserDetails,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
