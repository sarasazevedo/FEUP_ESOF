import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetEventInfo extends StatelessWidget {
  final String docID;
  final String info;
  final FontWeight bold;
  final double size;

  const GetEventInfo({
    super.key,
    required this.docID,
    required this.info,
    required this.bold,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('events');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(docID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (info != "start-time") {
            return Text(
              data[info],
              style: TextStyle(
                fontWeight: bold,
                fontSize: size,
              ),
            );
          } else {
            Timestamp t = data[info];
            return Text(
              DateFormat.yMMMd().add_jm().format(t.toDate()).toString(),
              style: TextStyle(
                fontWeight: bold,
                fontSize: size,
              ),
            );
          }
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
