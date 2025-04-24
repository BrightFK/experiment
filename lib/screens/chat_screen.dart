import 'package:experiment/screens/chat_detail_screen.dart';
import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  ChatListScreen({super.key});

  // Sample chat list data
  final List<Map<String, String>> _chatList = [
    {
      'name': 'Geopart Endsie',
      'message': 'Your Order Just Arrived!',
      'time': '13:47',
      'imageUrl': 'assets/images/people/deb.png', // Replace
    },
    {
      'name': 'Stevano Clover',
      'message': 'Your Order Just Arrived!',
      'time': '11:23',
      'imageUrl': 'assets/images/people/deb7.jpeg', // Replace
    },
    {
      'name': 'Elisia Justin',
      'message': 'Your Order Just Arrived!',
      'time': '11:23',
      'imageUrl': 'assets/images/people/deb2.jpeg', // Replace
    },
    {
      'name': 'Geopart Endsie',
      'message': 'Your Order Just Arrived!',
      'time': '12:47',
      'imageUrl': 'assets/images/people/deb3.jpeg', // Replace
    },
    {
      'name': 'Stevano Clover',
      'message': 'Your Order Just Arrived!',
      'time': '11:23',
      'imageUrl': 'assets/images/people/deb4.jpeg', // Replace
    },
    {
      'name': 'Elisia Justin',
      'message': 'Your Order Just Arrived!',
      'time': '11:23',
      'imageUrl': 'assets/images/people/deb5.jpeg', // Replace
    },
    {
      'name': 'Elisia Justin',
      'message': 'Your Order Just Arrived!',
      'time': '11:23',
      'imageUrl': 'assets/images/people/deb6.jpeg', // Replace
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Chat List', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'All Message',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _chatList.length,
                itemBuilder: (context, index) {
                  final chat = _chatList[index];
                  return _buildChatItem(context, chat);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, Map<String, String> chat) {
    return GestureDetector(
      onTap: () {
        // Navigate to the chat detail screen.  You'll need to create a ChatDetailScreen widget.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatScreen(), // Replace with your chat detail screen
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(chat['imageUrl']!),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    chat['name']!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat['message']!,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              chat['time']!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
