import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';

class Industrychatbot extends StatefulWidget {
  const Industrychatbot({
    super.key,
  });

  @override
  State<Industrychatbot> createState() => _IndustrychatbotState();
}

class _IndustrychatbotState extends State<Industrychatbot> {
  final paddingval = 20.0;

  // Hardcoded list of messages for the chatbot
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'What\'s the current PM2.5 level at the coke oven section?',
      'isUser': true, // Message from the user
    },
    {
      'text':
          'The current PM2.5 reading at the coke oven section is 78 µg/m³, which is categorized as Unhealthy. Please ensure workers in the area wear respiratory protection.',
      'isUser': false, // Message from the bot
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(paddingval),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Industryappbar(showBackButton: true),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: paddingval),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return MessageBubble(
                  text: message['text'],
                  isUser: message['isUser'],
                );
              },
            ),
          ),
          // Chat input area
          Padding(
            padding: EdgeInsets.all(paddingval),
            child: Row(
              children: [
                // Attachment icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.attach_file, color: Colors.grey),
                ),
                const SizedBox(width: 10),
                // Text input field
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'I have something to ask...',
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Microphone icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        const Color(0xFF4CAF50), // Green color for microphone
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.mic, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Industrynavbar(),
    );
  }
}

// Custom widget for displaying chat messages
class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isUser
              ? const Color(0xFFD4EDDA)
              : Colors.grey[200], // Green for user, grey for bot
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft:
                isUser ? const Radius.circular(15) : const Radius.circular(0),
            bottomRight:
                isUser ? const Radius.circular(0) : const Radius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.black87 : Colors.black87,
          ),
        ),
      ),
    );
  }
}
