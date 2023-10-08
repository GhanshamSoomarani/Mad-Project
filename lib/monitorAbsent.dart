import 'package:mad/students.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(ClassScheduleApp());

class ClassScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AttendanceMarker(),
    );
  }
}

class AttendanceMarker extends StatefulWidget {
  @override
  _AttendanceMarkerState createState() => _AttendanceMarkerState();
}

class _AttendanceMarkerState extends State<AttendanceMarker> {
  TextEditingController _controller = new TextEditingController();
  DateTime now = DateTime.now();
  String? formattedDate;

  void setDate() {
    formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
  }

  List<Students> students = [
    Students(rollno: "01"),
    Students(rollno: "03"),
    Students(rollno: "05"),
    Students(rollno: "07"),
    Students(rollno: "09"),
    Students(rollno: "13"),
    Students(rollno: "15"),
    Students(rollno: "19"),
    Students(rollno: "23"),
    Students(rollno: "25"),
    Students(rollno: "27"),
    Students(rollno: "31"),
    Students(rollno: "33"),
    Students(rollno: "35"),
    Students(rollno: "37"),
    Students(rollno: "39"),
    Students(rollno: "41"),
    Students(rollno: "43"),
    Students(rollno: "45"),
    Students(rollno: "47"),
    Students(rollno: "49"),
    Students(rollno: "51"),
    Students(rollno: "53"),
    Students(rollno: "55"),
    Students(rollno: "57"),
    Students(rollno: "61"),
    Students(rollno: "63"),
    Students(rollno: "65"),
    Students(rollno: "67"),
    Students(rollno: "69"),
    Students(rollno: "71"),
    Students(rollno: "73"),
    Students(rollno: "75"),
    Students(rollno: "77"),
    Students(rollno: "79"),
    Students(rollno: "81"),
    Students(rollno: "83"),
  ];

  List<String> selectedStudents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('20SW-Section-1'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${students[index].rollno!} '),
                  trailing: Checkbox(
                    value: selectedStudents.contains(students[index].rollno),
                    onChanged: (value) {
                      setState(() {
                        if (value!) {
                          selectedStudents.add(students[index].rollno!);
                        } else {
                          selectedStudents.remove(students[index].rollno!);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Elevated Button'),
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 0, 157, 255),
              textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontStyle: FontStyle.normal),
            ),
            onPressed: () {
              setState(() {
                _controller.text =
                    '20SW-1 \n ${formattedDate!}\nAbsent Students:\n ${selectedStudents.join(', ')}';
              });
            },
          ),
          TextField(
            // controller: textarea,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            controller: _controller,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black))),
          ),
        ],
      ),
    );
  }
}
