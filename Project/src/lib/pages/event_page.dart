import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/get_event_info.dart';

class EventPage extends StatefulWidget {
  final String doc;
  const EventPage({
    super.key,
    required this.doc,
  });

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final user = FirebaseAuth.instance.currentUser;
  List<dynamic> userevents = [];
  List<dynamic> useraddevents = [];
  Icon fav = const Icon(Icons.more_horiz_rounded);

  Future getData() async {
    final users = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    if (users.exists) {
      Map<String, dynamic> data = users.data() as Map<String, dynamic>;
      userevents = data['favevents'];
      useraddevents = data['addevents'];
      setState(() {
        if (useraddevents.contains(widget.doc)) {
          fav = const Icon(Icons.delete_outline_rounded);
        } else if (userevents.contains(widget.doc)) {
          fav = const Icon(Icons.indeterminate_check_box_outlined);
        } else {
          fav = const Icon(Icons.add_box_outlined);
        }
      });
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
        centerTitle: true,
        backgroundColor: const Color(0xFFFAFAFA),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GetEventInfo(
                        bold: FontWeight.bold,
                        docID: widget.doc,
                        info: "title",
                        size: 18,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.person),
                          Text(
                            "Organizer:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GetEventInfo(
                              bold: FontWeight.normal,
                              docID: widget.doc,
                              info: "organizer",
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.location_pin),
                          Text(
                            "Location:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GetEventInfo(
                              bold: FontWeight.normal,
                              docID: widget.doc,
                              info: "location",
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.access_time_filled_rounded),
                          Text(
                            "Date & Time:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GetEventInfo(
                              bold: FontWeight.normal,
                              docID: widget.doc,
                              info: "start-time",
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.event_rounded),
                          Text(
                            "Event type:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GetEventInfo(
                              bold: FontWeight.normal,
                              docID: widget.doc,
                              info: "type",
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(Icons.description_rounded),
                          Text(
                            "Description:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GetEventInfo(
                              bold: FontWeight.normal,
                              docID: widget.doc,
                              info: "description",
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (user == null) {
            errorMessage("Can't favorite events if not logged in!");
          } else {
            if (useraddevents.contains(widget.doc)) {
              useraddevents.remove(widget.doc);
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .update({'addevents': useraddevents});
              await FirebaseFirestore.instance
                  .collection('events')
                  .doc(widget.doc)
                  .delete();
              Navigator.pop(context);
            } else if (userevents.contains(widget.doc)) {
              userevents.remove(widget.doc);
              setState(() {
                fav = const Icon(Icons.add_box_outlined);
              });
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .update({'favevents': userevents});
              errorMessage("Event deleted from your favorites!");
            } else {
              userevents.add(widget.doc);
              setState(() {
                fav = const Icon(Icons.indeterminate_check_box_outlined);
              });
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .update({'favevents': userevents});
              errorMessage("Event added to your favorites!");
            }
          }
        },
        child: fav,
      ),
    );
  }
}
