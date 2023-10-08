import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mad/authService.dart';
import 'package:mad/chat.dart';
import 'package:mad/loginform.dart';
import 'package:mad/monitorAbsent.dart';

import 'package:mad/schedule.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeTeacher(),
    );
  }
}

class HomeTeacher extends StatefulWidget {
  @override
  _HomeTeacher createState() => _HomeTeacher();
}

class _HomeTeacher extends State<HomeTeacher>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  AuthService service = AuthService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/muet.png',
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 16),
            const Text(
              'Mehran University',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement your search functionality here
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.group)),
            Tab(icon: Icon(Icons.notifications)),
            Tab(icon: Icon(Icons.messenger)),
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const UserAccountsDrawerHeader(
                    accountName: Text('Ghansham'),
                    accountEmail: Text(""),
                    currentAccountPicture: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.verified_user),
                    title: const Text('Get Absent'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AttendanceMarker()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.save),
                    title: const Text('Saved messages'),
                    onTap: () {
                      // Handle drawer item tap for Saved Messages
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_view_month),
                    title: const Text('Check Attendance'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AttendanceUpdateScreen()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_view_day_rounded),
                    title: const Text('Mark Attendance'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AttendanceMark()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Class Schedule'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScheduleClass()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      // Handle drawer item tap for Settings
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help'),
                    onTap: () {
                      // Handle drawer item tap for Help
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.arrow_drop_down),
              title: const Text('Show Account'),
              onTap: () {
                // Handle "Show Account" tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Account'),
              onTap: () async {
                await service.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(
                        builder: (context) => new LoginForm()),
                    (route) => true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Log Out'),
              onTap: () async {
                await service.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    new MaterialPageRoute(
                        builder: (context) => new LoginForm()),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Image(
            image: AssetImage("assets/images/muet.png"),
            width: 200.0,
            height: 200.0,
          ),
          ListViewTabScreen(),
          Text("Messenger Tab Content"),
          Text("Messenger Tab Content"),
        ],
      ),
    );
  }
}

class ListViewTabScreen extends StatelessWidget {
  const ListViewTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        final itemNumber = (index + 1).toString().padLeft(3, '0');
        return ListTile(
          leading: Icon(Icons.person_2), // Replace with your "abc" icon
          title: Text('20sw$itemNumber'),

          onTap: () {
            // Navigate to the ChatWithMe class when tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatWithMe(
                        data: itemNumber,
                      )),
            );
          },
        );
      },
    );
  }
}

class AttendanceMark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Table',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AttendanceTable(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AttendanceTable extends StatefulWidget {
  @override
  _AttendanceTableState createState() => _AttendanceTableState();
}

class _AttendanceTableState extends State<AttendanceTable> {
  List<Student> students = [
    Student("20sw01", false),
    Student("20sw03", false),
    Student("20sw05", false),

    Student("20sw07", false),
    Student("20sw09", false),
    Student("20sw13", false),

    Student("20sw15", false),
    Student("20sw19", false),
    Student("20sw23", false),

    Student("20sw25", false),
    Student("20sw27", false),
    Student("20sw31", false),

    Student("20sw33", false),
    Student("20sw35", false),
    Student("20sw37", false),

    Student("20sw39", false),
    Student("20sw41", false),
    Student("20sw43", false),

    Student("20sw45", false),
    Student("20sw47", false),
    Student("20sw49", false),
    // Add more students as needed
  ];
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final topicController = TextEditingController();
  final subjectController = TextEditingController();

  @override
  void initState() {
    dateController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int totalStudents = students.length;
    int presentCount = students.where((student) => student.isPresent).length;
    int absentCount = totalStudents - presentCount;

    return Scaffold(
      appBar: AppBar(title: Text('Attendance Table')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: "Date",
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
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
              decoration: const InputDecoration(
                labelText: 'Time',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                TimeOfDay? selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedTime != null) {
                  String formattedTime =
                      selectedTime.format(context); // Format the selected time
                  setState(() {
                    timeController.text = formattedTime;
                  });
                }
              },
            ),
            TextField(
              controller: topicController,
              decoration: const InputDecoration(
                labelText: 'Topic',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            DataTable(
              columns: const [
                DataColumn(
                    label: Text('Roll Number',
                        style: TextStyle(fontSize: 18, color: Colors.white))),
                DataColumn(
                    label: Text('Present',
                        style: TextStyle(fontSize: 18, color: Colors.white))),
                DataColumn(
                    label: Text('Absent',
                        style: TextStyle(fontSize: 18, color: Colors.white))),
              ],
              rows: students.map((student) {
                return DataRow(
                  color: MaterialStateColor.resolveWith((states) {
                    if (student.isPresent) {
                      return Colors.green;
                    }
                    return Colors.red;
                  }),
                  cells: [
                    DataCell(
                      Text(student.rollNumber,
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                    DataCell(Checkbox(
                      value: student.isPresent,
                      onChanged: (value) {
                        setState(() {
                          student.isPresent = value!;
                        });
                      },
                    )),
                    DataCell(Checkbox(
                      value: !student.isPresent,
                      onChanged: (value) {
                        setState(() {
                          student.isPresent = !value!;
                        });
                      },
                    )),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 35),
            Text('Total Students: $totalStudents',
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 0, 0, 0))),
            Text('Present: $presentCount',
                style: TextStyle(
                    fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0))),
            Text('Absent: $absentCount',
                style: TextStyle(
                    fontSize: 20, color: const Color.fromARGB(255, 4, 4, 4))),
          ],
        ),
      ),
    );
  }
}

class Student {
  final String rollNumber;
  bool isPresent;

  Student(this.rollNumber, this.isPresent);
}

class AttendanceUpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Update'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AttendanceMark()));
        },
        child: const Icon(Icons.edit),
      ),
      body: const Center(
        child: Text('Attendance Update Screen Content'),
      ),
    );
  }
}
