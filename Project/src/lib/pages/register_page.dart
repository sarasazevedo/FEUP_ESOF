import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventfully/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final universityController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (passwordController.text.trim() ==
          confirmPasswordController.text.trim()) {
        if (usernameController.text.trim() != "") {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          addUserDetails(
            usernameController.text.trim(),
            emailController.text.trim(),
            universityController.text.trim(),
          );
          if (mounted) Navigator.pop(context);
        } else {
          Navigator.pop(context);
          errorMessage("Username must not be empty!");
        }
      } else {
        Navigator.pop(context);
        errorMessage("Passwords don't match!");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorMessage(e.message.toString());
    }
  }

  Future addUserDetails(
      String username, String email, String university) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'username': username,
      'email': email,
      'university': university,
      'favevents': [],
      'addevents': [],
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        titleSpacing: 30,
        title: const Text(
          'Eventfully.',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //intro text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        children: const [
                          Text(
                            'Let\'s Register an Account',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    //profile icon
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
                    //email input box
                    LoginTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                      max: 1,
                    ),
                    const SizedBox(height: 10),
                    //password input box
                    LoginTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      max: 1,
                    ),
                    const SizedBox(height: 10),
                    //confirm password input box
                    LoginTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
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
                      onTap: signUserUp,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          '',
                        ),
                      ),
                    ),
                    //register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login Now',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
