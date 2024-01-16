import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eventfully/components/get_event_info.dart';
import 'event_page.dart';
import 'filter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  String filteritem = "";
  String filter = "";

  List<String> docIDs = [];

  Future getAllEvents() async {
    if (filteritem != "") {
      await FirebaseFirestore.instance
          .collection('events')
          .where(filteritem, isEqualTo: filter)
          .orderBy("start-time")
          .get()
          .then(
            (snapshot) => snapshot.docs.forEach(
              (doc) {
                docIDs.add(doc.reference.id);
              },
            ),
          );
    } else {
      await FirebaseFirestore.instance
          .collection('events')
          .orderBy("start-time")
          .get()
          .then(
            (snapshot) => snapshot.docs.forEach(
              (doc) {
                docIDs.add(doc.reference.id);
              },
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          controller: scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, __) => [
            SliverAppBar(
              backgroundColor: const Color(0xFFFAFAFA),
              titleSpacing: 30,
              title: const Text(
                'Eventfully.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              snap: true,
              floating: true,
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      filteritem = "";
                      filter = "";
                    });
                  },
                  icon: const Icon(Icons.refresh),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FilterPage(),
                      ),
                    ).then((value) {
                      docIDs.clear();
                      setState(() {
                        if (value[0] != null && value[1] != null) {
                          filteritem = value[0];
                          filter = value[1].toString();
                        } else if (value[0] != null) {
                          filteritem = value[0];
                          filter = "";
                        } else {
                          filteritem = "";
                          filter = "";
                        }
                      });
                    });
                  },
                  icon: const Icon(Icons.filter_alt_rounded),
                ),
              ],
            ),
          ],
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: getAllEvents(),
                  builder: (context, snapshot) {
                    return ListView.builder(
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
                                    docIDs.clear();
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        child: Text(
                                            "Click for more information",
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollController.animateTo(scrollController.position.minScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn);
        },
        child: const Icon(
          Icons.keyboard_arrow_up_rounded,
          size: 38,
        ),
      ),
    );
  }
}
