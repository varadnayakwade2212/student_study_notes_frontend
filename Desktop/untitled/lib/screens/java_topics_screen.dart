import 'package:flutter/material.dart';
import 'notes_screen.dart';

class JavaTopicsScreen extends StatelessWidget {
  final int unit;

  const JavaTopicsScreen({
    super.key,
    required this.unit,
  });

  List<String> getTopics() {
    switch (unit) {
      case 1:
        return [
          'Java Features',
          'Class and Object',
          'Tokens and Data Types',
          'Variables and Typecasting',
          'Operators',
          'Decision Making',
          'Loops',
          'Arrays',
          'Strings',
          'StringBuffer',
          'Constructors and Methods',
          'Overloading',
          'Garbage Collection',
          'Visibility Control',
        ];

      case 2:
        return [
          'Inheritance',
          'Single Inheritance',
          'Multilevel Inheritance',
          'Hierarchical Inheritance',
          'Method Overriding',
          'Final Keyword',
          'Abstract Class',
          'Interfaces',
          'Packages',
        ];

      case 3:
        return [
          'Errors and Exceptions',
          'try and catch',
          'throw and throws',
          'finally',
          'Built-in Exceptions',
          'User-defined Exceptions',
          'Multithreading',
          'Thread Class',
          'Runnable Interface',
          'Thread Life Cycle',
          'Thread Methods',
          'Thread Priority',
          'Synchronization',
        ];

      case 4:
        return [
          'AWT Components',
          'Containers and Frame',
          'Buttons and Labels',
          'Layout Managers',
          'FlowLayout',
          'BorderLayout',
          'GridLayout',
          'AWT vs Swing',
          'Swing Components',
          'Event Handling',
          'ActionListener',
          'MouseListener',
          'KeyListener',
        ];

      case 5:
        return [
          'Socket',
          'Client and Server',
          'Proxy Server',
          'Internet Addressing',
          'InetAddress',
          'TCP/IP Sockets',
          'Datagram Packets',
          'URL',
          'URLConnection',
        ];

      case 6:
        return [
          'JDBC',
          'Two-tier Architecture',
          'Three-tier Architecture',
          'JDBC Drivers',
          'DriverManager',
          'Connection',
          'Statement',
          'PreparedStatement',
          'ResultSet',
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final topics = getTopics();

    return Scaffold(
      appBar: AppBar(
        title: Text('Unit $unit Topics'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(topics[index]),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteScreen(
                      topic: topics[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}