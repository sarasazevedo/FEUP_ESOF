import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/components.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  List<dynamic> useraddevents = [];
  final user = FirebaseAuth.instance.currentUser!;

  String? itemValue;
  String name = "";

  bool check = true;

  DateTime? date;

  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  void addEvent() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (titleController.text.trim() != "") {
        if (locationController.text.trim() != "") {
          if (date != null) {
            if (itemValue != null) {
              if (descriptionController.text.trim() != "") {
                await addEventDetails(
                  titleController.text.trim(),
                  locationController.text.trim(),
                  descriptionController.text.trim(),
                );
                if (mounted) Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                errorMessage("Description must not be empty!");
              }
            } else {
              Navigator.pop(context);
              errorMessage("Event type must not be empty!");
            }
          } else {
            Navigator.pop(context);
            errorMessage("Date & Time must not be empty!");
          }
        } else {
          Navigator.pop(context);
          errorMessage("Location must not be empty!");
        }
      } else {
        Navigator.pop(context);
        errorMessage("Title must not be empty!");
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

  Future getName() async {
    final users = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (users.exists) {
      Map<String, dynamic> data = users.data() as Map<String, dynamic>;
      name = data['username'];
      useraddevents = data['addevents'];
    }
  }

  Future addEventDetails(
      String title, String location, String description) async {
    await FirebaseFirestore.instance.collection('events').add({
      'title': title,
      'organizer': name,
      'location': location,
      'start-time': Timestamp.fromDate(date!),
      'type': itemValue!,
      'description': description,
    }).then((DocumentReference event) async {
      useraddevents.add(event.id);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'addevents': useraddevents});
    });
  }

  Future pickDateTime() async {
    DateTime? d = await pickDate();
    if (d == null) return;
    TimeOfDay? t = await pickTime();
    if (t == null) return;
    final dateTime = DateTime(
      d.year,
      d.month,
      d.day,
      t.hour,
      t.minute,
    );
    check = false;
    setState(() => date = dateTime);
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: DateTime.now().hour,
          minute: DateTime.now().minute,
        ),
      );

  @override
  void initState() {
    getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFFAFAFA),
        title: const Text(
          'Add Event',
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
                    const SizedBox(height: 20),
                    LoginTextField(
                      controller: titleController,
                      hintText: 'Title',
                      obscureText: false,
                      max: 1,
                    ),
                    const SizedBox(height: 10),
                    LoginTextField(
                      controller: locationController,
                      hintText: 'Location',
                      obscureText: false,
                      max: 1,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ElevatedButton(
                        onPressed: pickDateTime,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(left: 16),
                          alignment: Alignment.centerLeft,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          minimumSize: const Size.fromHeight(58),
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.grey[700],
                          elevation: 0,
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: (check)
                            ? const Text("Date & Time",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal))
                            : Text(
                                DateFormat.yMMMd()
                                    .add_jm()
                                    .format(date!)
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            underline: Container(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(7),
                            isExpanded: true,
                            elevation: 4,
                            hint: const Text("Event type"),
                            value: itemValue,
                            onChanged: (newValue) {
                              setState(() {
                                itemValue = newValue!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: "Music & Festivals",
                                child: Text("Music & Festivals"),
                              ),
                              DropdownMenuItem(
                                value: "Workshops",
                                child: Text("Workshops"),
                              ),
                              DropdownMenuItem(
                                value: "Fairs",
                                child: Text("Fairs"),
                              ),
                              DropdownMenuItem(
                                value: "Social Gatherings & parties",
                                child: Text("Social Gatherings"),
                              ),
                              DropdownMenuItem(
                                value: "Others",
                                child: Text("Others"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    LoginTextField(
                      controller: descriptionController,
                      hintText: 'Description',
                      obscureText: false,
                      max: 10,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: addEvent,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Text(
                            'Add',
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
