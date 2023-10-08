import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Class {
  final String date;
  final String time;
  final String topic;
  final String subject;

  Class(this.date, this.time, this.topic, this.subject);
}

class ScheduleStudent extends StatefulWidget {
  const ScheduleStudent({Key? key}) : super(key: key);

  @override
  State<ScheduleStudent> createState() => _ScheduleStudentState();
}

class _ScheduleStudentState extends State<ScheduleStudent> {
  CollectionReference classes =
      FirebaseFirestore.instance.collection('classes');

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Items List"),
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
                        title: Text('Class: $subject'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date $date'),
                            Text('Time $time'),
                            Text('Topic $topic')
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

void main() {
  runApp(MaterialApp(home: ScheduleStudent()));
}
