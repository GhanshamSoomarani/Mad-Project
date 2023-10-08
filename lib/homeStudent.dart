import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad/authService.dart';

import 'package:mad/loginform.dart';
import 'package:mad/monitorAbsent.dart';
import 'package:mad/notification.dart';
import 'package:mad/schedulecheck.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeStudent(),
    );
  }
}

class HomeStudent extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeStudent>
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
                    accountEmail: Text('20sw081@students.muet.edu.pk'),
                    currentAccountPicture: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
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
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Check Classes Schedule'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScheduleStudens()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Help'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.arrow_drop_down),
              title: const Text('Show Account'),
              onTap: () {},
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: CustomButton(
                imageAsset: 'assets/images/Attendance.png',
                headingText: 'Attendance',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendanceUpdateScreen(),
                    ),
                  );
                },
              ), // Add margin for spacing
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: CustomButton(
                imageAsset: 'assets/images/Questions.png',
                headingText: 'Notifications',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Notifications()));
                },
              ), // Add margin for spacing
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: CustomButton(
                imageAsset: 'assets/images/Add User Male.png',
                headingText: 'Your Chats',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GroupTab()));
                },
              ), // Add margin for spacing
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String imageAsset;
  final String headingText;
  final VoidCallback? onPressed;

  CustomButton({
    required this.imageAsset,
    required this.headingText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 140.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imageAsset,
              width: 64, // Adjust image size as needed
              height: 64,
            ),
            SizedBox(height: 6), // Add spacing between image and text
            Text(
              headingText,
              style: const TextStyle(
                color: Colors.white, // Text color is white
                fontSize: 14, // Adjust font size as needed
                fontWeight: FontWeight.bold, // Add font weight if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceUpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Update'),
      ),
      body: const Center(
        child: Text('Attendance Update Screen Content'),
      ),
    );
  }
}

//Notification Tab

class GroupTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeStudent()));
        },
        icon: Icon(Icons.arrow_back_ios),
        //replace with our own icon data.
      )),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          final itemNumber = (index + 1).toString().padLeft(3, '0');
          return ListTile(
            leading: Icon(Icons.male), // Replace with your desired icon
            title: Text('20sw$itemNumber'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
