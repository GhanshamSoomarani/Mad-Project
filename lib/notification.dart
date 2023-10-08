import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications extends StatelessWidget {
  final CollectionReference classes =
      FirebaseFirestore.instance.collection('classes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notifications"),
      ),
      body: StreamBuilder(
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
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No classes available.'),
            );
          }
          final classList = (snapshot.data as QuerySnapshot).docs;

          return ListView.builder(
            itemCount: classList.length,
            itemBuilder: (context, index) {
              final subject = classList[index]["subject"];
              final date = classList[index]["date"];

              return ListTile(
                title: Text('Class: $subject',
                    style: TextStyle(
                        fontSize: 25, color: Color.fromARGB(255, 253, 0, 0))),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date: $date',
                      style: TextStyle(
                          fontSize: 15, color: Color.fromARGB(255, 1, 62, 9)),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: Notifications()));
}
