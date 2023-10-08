import 'package:flutter/material.dart';

class ChatWithMe extends StatelessWidget {
  String data;

  ChatWithMe({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("20sw$data"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.view_sidebar))
          ],
          bottom: const TabBar(tabs: [
            Tab(child: Text("Chats")),
            Tab(child: Text("Files")),
          ]),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Text('Chat Content Goes Here'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      // Add your camera functionality here
                    },
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Type your message',
                        hintText: 'Type your message',
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Documents') {
                      } else if (value == 'Upload from this device') {
                        // Handle "Upload from this device" option
                      } else if (value == 'Drive') {
                        // Handle "Drive" option
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Documents',
                          child: Text('Documents'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Upload from this device',
                          child: Text('Upload from this device'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Drive',
                          child: Text('Drive'),
                        ),
                      ];
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () {
                      // Add your speech functionality here
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Color.fromARGB(255, 0, 132, 155),
                      size: 18,
                    ),
                    onPressed: () {
                      // Add your camera functionality here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
