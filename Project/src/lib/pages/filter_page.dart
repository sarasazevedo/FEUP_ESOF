import 'package:flutter/material.dart';
import '../components/components.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? itemValue;

  final textController = TextEditingController();

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
        centerTitle: true,
        backgroundColor: const Color(0xFFFAFAFA),
        title: const Text(
          'Filter events',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
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
                            value: itemValue,
                            onChanged: (newValue) {
                              setState(() {
                                itemValue = newValue;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                  child: Text(
                                "Choose option to filter",
                                style: TextStyle(color: Colors.grey[600]),
                              )),
                              const DropdownMenuItem(
                                value: "title",
                                child: Text("title"),
                              ),
                              const DropdownMenuItem(
                                value: "organizer",
                                child: Text("organizer"),
                              ),
                              const DropdownMenuItem(
                                value: "location",
                                child: Text("location"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    LoginTextField(
                      controller: textController,
                      hintText: 'Write filtering',
                      obscureText: false,
                      max: 1,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, [
                          itemValue,
                          textController.text.trim(),
                        ]);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 30.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Text(
                            'Filter',
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
