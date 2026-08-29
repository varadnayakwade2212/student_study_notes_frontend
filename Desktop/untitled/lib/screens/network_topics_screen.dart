import 'package:flutter/material.dart';
import 'notes_screen.dart';

class NetworkTopicsScreen extends StatelessWidget {
  const NetworkTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      'Introduction to Computer Networks',
      'Network Topologies',
      'OSI Model',
      'TCP/IP Model',
      'Transmission Media',
      'Twisted Pair',
      'Fiber Optic',
      'Satellite Communication',
      'Multiplexing',
      'TDM and FDM',
      'Packet Switching',
      'Circuit Switching',
      'Wireless LAN 802.11',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Computer Networks'),
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