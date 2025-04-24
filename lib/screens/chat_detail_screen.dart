import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Sample chat messages
  final List<ChatMessage> _messages = [
    ChatMessage(
      sender: 'Stevano Clover',
      text: 'Just to order',
      time: '00:00',
      isMe: false,
    ),
    ChatMessage(
      sender: 'Stevano Clover',
      text: 'Okay, Wait a minute!🙏',
      time: '00:00',
      isMe: false,
    ),
  ];

  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Function to send a new message
  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          sender: 'You', // The user is sending the message
          text: _textController.text,
          time: _formatTime(DateTime.now()),
          isMe: true,
        ));
        _textController.clear();
        // Scroll to the bottom after sending the message
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  // Function to format time
  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Stevano Clover', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.grey,),
            onPressed: () {
              // Handle call
            },
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.grey,),
            onPressed: () {
              // Handle video call
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey,),
            onPressed: () {
              //more options
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 70.0), //leave space for input
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _buildMessageInput(),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment:
        message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: message.isMe ? Colors.orange : Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7, // Limit width
            ),
            child: Column(
              crossAxisAlignment: message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message.sender,
                  style: TextStyle(
                    fontSize: 12,
                    color: message.isMe ? Colors.white : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.text,
                  style: TextStyle(
                    fontSize: 16,
                    color: message.isMe ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 10,
                    color: message.isMe ? Colors.white70 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2), // Add shadow to the top
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type something...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none, // Remove border
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              textInputAction: TextInputAction.send, //show send button on keyboard
              onSubmitted: (_) {
                _sendMessage();
              },
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.orange,
            radius: 24,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                _sendMessage();
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.grey,),
            onPressed: () {
              // Handle voice message
            },
          ),
        ],
      ),
    );
  }
}

// Chat message data model
class ChatMessage {
  String sender;
  String text;
  String time;
  bool isMe;

  ChatMessage({
    required this.sender,
    required this.text,
    required this.time,
    required this.isMe,
  });
}
