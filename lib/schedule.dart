import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Class {
  final String date;
  final String time;
  final String topic;
  final String subject;

  Class(this.date, this.time, this.topic, this.subject);
}

class ScheduleClass extends StatefulWidget {
  const ScheduleClass({Key? key}) : super(key: key);

  @override
  State<ScheduleClass> createState() => _ScheduleClassState();
}

class _ScheduleClassState extends State<ScheduleClass> {
  CollectionReference classes =
      FirebaseFirestore.instance.collection('classes');

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  String? editingItemId; // Stores the ID of the item being edited

  addItem(String subject, String topic, String time, String date) async {
    try {
      await classes.add(
          {"subject": subject, "topic": topic, "date": date, "time": time});
    } catch (e) {
      print('Error adding item: $e');
    }
  }

  editItem(
      String id, String subject, String topic, String time, String date) async {
    try {
      await classes.doc(id).update(
          {"subject": subject, "topic": topic, "date": date, "time": time});
    } catch (e) {
      print('Error editing item: $e');
    }
  }

  void _showAddClassDialog(BuildContext context, {String? buttonText}) {
    if (buttonText != null) {
      // If buttonText is provided, set the text controllers with existing data
      final item = classes.doc(buttonText);
      item.get().then((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          subjectController.text = data['subject'];
          topicController.text = data['topic'];
          dateController.text = data['date'];
          timeController.text = data['time'];
        }
      });
    } else {
      // If buttonText is null, reset text controllers for adding a new item
      subjectController.clear();
      topicController.clear();
      dateController.clear();
      timeController.clear();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(buttonText != null ? 'Edit Class' : 'Add Class'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Date",
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      String formattedDateWithDay =
                          DateFormat('EEEE, MMMM d, y').format(pickedDate);
                      setState(() {
                        dateController.text = formattedDateWithDay;
                      });
                    }
                  },
                ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (selectedTime != null) {
                      String formattedTime = selectedTime.format(context);
                      setState(() {
                        timeController.text = formattedTime;
                      });
                    }
                  },
                ),
                TextField(
                  controller: topicController,
                  decoration: InputDecoration(labelText: 'Topic'),
                ),
                TextField(
                  controller: subjectController,
                  decoration: InputDecoration(labelText: 'Subject'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (buttonText != null) {
                  // If buttonText is provided, it's an edit action
                  editItem(
                    buttonText,
                    subjectController.text,
                    topicController.text,
                    dateController.text,
                    timeController.text,
                  );
                } else {
                  // If buttonText is null, it's an add action
                  addItem(
                    subjectController.text,
                    topicController.text,
                    dateController.text,
                    timeController.text,
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text(buttonText != null ? 'Save Changes' : 'Add Class'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Classes Schedule"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _showAddClassDialog(context);
              },
              child: Text('Add Class'),
            ),
            Expanded(
              child: StreamBuilder(
                stream: classes.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  final itemlist =
                      (snapshot.data as QuerySnapshot).docs.reversed.toList();
                  return ListView.builder(
                    itemCount: itemlist.length,
                    itemBuilder: (context, index) {
                      final topic = itemlist[index]["topic"];
                      final subject = itemlist[index]["subject"];
                      final date = itemlist[index]["date"];
                      final time = itemlist[index]["time"];
                      final itemId = itemlist[index].id;
                      return ListTile(
                        title: Text("Subject: $subject",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 253, 0, 0))),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Topic: $topic",
                            ),
                            Text("Time: $time",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 253, 0, 236))),
                            Text("Day: $date")
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                _showAddClassDialog(context,
                                    buttonText: itemId);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteItem(itemId);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
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
    );
  }

  deleteItem(String id) async {
    try {
      await classes.doc(id).delete();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }
}
