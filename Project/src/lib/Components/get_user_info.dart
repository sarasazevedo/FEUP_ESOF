import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserInfo extends StatelessWidget {
  final String uid;
  final String info;
  final FontWeight bold;
  final double size;

  const GetUserInfo({
    super.key,
    required this.uid,
    required this.info,
    required this.bold,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            data[info],
            style: TextStyle(
              fontWeight: bold,
              fontSize: size,
            ),
          );
        }
        return Text(
          'loading...',
          style: TextStyle(
            fontWeight: bold,
            fontSize: size,
          ),
        );
      }),
    );
  }
}
