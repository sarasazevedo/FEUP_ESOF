import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventfully/pages/add_event_page.dart';
import 'package:eventfully/pages/edit_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventfully/components/get_user_info.dart';
import 'package:eventfully/tabs/added_events_view.dart';
import 'package:eventfully/tabs/fav_events_view.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final ScrollController scrollController = ScrollController();

  List<dynamic> docIDs = [];
  List<dynamic> docAddedIDs = [];

  Future getUserEvents() async {
    final users = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (users.exists) {
      Map<String, dynamic> data = users.data() as Map<String, dynamic>;
      docIDs = data['favevents'];
      docAddedIDs = data['addevents'];
    }
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final List<Widget> tabs = const [
    Tab(
      icon: Icon(
        Icons.star,
        color: Colors.black,
      ),
    ),
    Tab(
      icon: Icon(
        Icons.inbox,
        color: Colors.black,
      ),
    ),
  ];

  final List<Widget> tabBarViews = const [
    FavEventsView(),
    AddedEventsView(),
  ];

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
    getUserEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: [
              Column(
                key: UniqueKey(),
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: Image.asset(
                          'lib/icons/temp2.png',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          GetUserInfo(
                            uid: user.uid,
                            info: 'username',
                            bold: FontWeight.bold,
                            size: 18,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          GetUserInfo(
                            uid: user.uid,
                            info: 'university',
                            bold: FontWeight.normal,
                            size: 12,
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const EditProfilePage();
                                  },
                                ),
                              ).then((_) {
                                setState(() {});
                              });
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              fixedSize: const Size(90, 20),
                              padding: const EdgeInsets.all(0),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              backgroundColor:
                                  const Color.fromARGB(255, 228, 228, 228),
                            ),
                            child: const Text("Edit Profile"),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  TabBar(
                    tabs: tabs,
                  ),
                  SizedBox(
                    height: 10000,
                    child: TabBarView(
                      children: tabBarViews,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFAFA),
          titleSpacing: 30,
          title: const Text(
            'Eventfully.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEventPage(),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.add_box_outlined),
            ),
            IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout_rounded),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(
                scrollController.position.minScrollExtent,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn);
          },
          child: const Icon(
            Icons.keyboard_arrow_up_rounded,
            size: 38,
          ),
        ),
      ),
    );
  }
}
