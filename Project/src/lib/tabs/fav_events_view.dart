import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Pages/event_page.dart';
import '../components/get_event_info.dart';

class FavEventsView extends StatefulWidget {
  const FavEventsView({super.key});

  @override
  State<FavEventsView> createState() => _FavEventsViewState();
}

class _FavEventsViewState extends State<FavEventsView> {
  List<dynamic> docIDs = [];
  final user = FirebaseAuth.instance.currentUser!;

  Future getUserEvents() async {
    final users = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (users.exists) {
      Map<String, dynamic> data = users.data() as Map<String, dynamic>;
      docIDs = data['favevents'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getUserEvents(),
          builder: (context, snapshot) {
            if (docIDs.isNotEmpty) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventPage(
                                  doc: docIDs[index],
                                ),
                              ),
                            ).then((_) {
                              setState(() {});
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                GetEventInfo(
                                  bold: FontWeight.bold,
                                  docID: docIDs[index],
                                  info: "title",
                                  size: 18,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.person),
                                    Expanded(
                                      child: GetEventInfo(
                                        bold: FontWeight.normal,
                                        docID: docIDs[index],
                                        info: "organizer",
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_pin),
                                    Expanded(
                                      child: GetEventInfo(
                                        bold: FontWeight.normal,
                                        docID: docIDs[index],
                                        info: "location",
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                        Icons.access_time_filled_rounded),
                                    Expanded(
                                      child: GetEventInfo(
                                        bold: FontWeight.normal,
                                        docID: docIDs[index],
                                        info: "start-time",
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Center(
                                  child: Text("Click for more information",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  const Text("You haven't favorited any event."),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("To favorite an event click on the"),
                      Icon(Icons.add_box_outlined),
                      Text("in an event"),
                    ],
                  ),
                  const Text("in your home page!"),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
