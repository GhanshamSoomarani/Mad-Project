import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Class {
  final String date;
  final String time;
  final String topic;
  final String subject;

  Class(this.date, this.time, this.topic, this.subject);
}

class ScheduleStudens extends StatefulWidget {
  const ScheduleStudens({Key? key}) : super(key: key);

  @override
  State<ScheduleStudens> createState() => _ScheduleStudensState();
}

class _ScheduleStudensState extends State<ScheduleStudens> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Classes Schedule"),
      ),
      body: Center(
        child: Column(
          children: [
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

                      return ListTile(
                        title: Text("Subject: $subject",
                            style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 42, 0, 253))),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Topic: ${topic}"),
                            Text("Time: $time"),
                            Text("Date: $date")
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
