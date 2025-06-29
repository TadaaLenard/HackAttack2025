import 'package:flutter/material.dart';
import 'package:hackattack2025/components/appbar.dart';
import 'package:hackattack2025/components/navbar.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert'; // Import for JSON encoding/decoding

class Industrychatbot extends StatefulWidget {
  const Industrychatbot({
    super.key,
  });

  @override
  State<Industrychatbot> createState() => _IndustrychatbotState();
}

class _IndustrychatbotState extends State<Industrychatbot> {
  final paddingval = 20.0;
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Initialize with an empty list, messages will be fetched from backend or added
  final List<Map<String, dynamic>> _messages = [];

  // State variable to manage loading indicator
  bool _isLoading = false; // --- NEW STATE VARIABLE ---

  // Base URL of your Node.js backend
  final String _baseUrl =
      'http://10.0.2.2:3000/api/chat'; // Example for Android emulator

  @override
  void initState() {
    super.initState();
    _fetchChatHistory(); // Fetch existing chat history when the widget initializes
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // --- API Calls ---

  Future<void> _fetchChatHistory() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> fetchedMessages = json.decode(response.body);
        setState(() {
          _messages.clear(); // Clear existing messages
          // Convert fetched messages to the format your UI expects
          for (var msg in fetchedMessages) {
            _messages.add({
              'text': msg['message'],
              'isUser': msg['sender'] == 'user',
            });
          }
        });
        _scrollToBottom();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to load chat history: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching chat history: $e')),
      );
      print('Error fetching chat history: $e');
    }
  }

  Future<void> _sendMessage() async {
    print('DEBUG: Send button tapped, _sendMessage called!');
    final text = _textEditingController.text.trim();
    if (text.isEmpty) {
      print('DEBUG: Message is empty, not sending.');
      return;
    }

    // Add user message to UI immediately
    setState(() {
      _messages.add({
        'text': text,
        'isUser': true,
      });
      _isLoading = true; // --- SET LOADING TO TRUE ---
    });
    _textEditingController.clear(); // Clear input field
    _scrollToBottom(); // Scroll to show the new message

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': text}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final botMessageText = responseData['botMessage']['message'];

        // Add bot message to UI after receiving response
        setState(() {
          _messages.add({
            'text': botMessageText,
            'isUser': false,
          });
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to send message: ${response.statusCode}')),
        );
        // Optionally, remove the user message if sending failed
        setState(() {
          _messages.removeLast();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending message: $e')),
      );
      print('Error sending message: $e');
      // Optionally, remove the user message if sending failed
      setState(() {
        _messages.removeLast();
      });
    } finally {
      setState(() {
        _isLoading = false; // --- SET LOADING TO FALSE IN FINALLY BLOCK ---
      });
      _scrollToBottom(); // Scroll again after bot response or error
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

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
              controller: _scrollController, // Assign scroll controller
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
                // Attachment icon (no functionality yet)
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
                    controller: _textEditingController, // Assign controller
                    decoration: InputDecoration(
                      hintText: '', // --- CHANGED THIS LINE ---
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                    ),
                    onSubmitted: _isLoading
                        ? null // Disable submit when loading
                        : (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                // Send icon or Loading Indicator
                _isLoading
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const SizedBox(
                          width: 24, // Match icon size
                          height: 24, // Match icon size
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: _sendMessage, // Call sendMessage on tap
                        behavior:
                            HitTestBehavior.opaque, // Ensure tap detection
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50), // Green color
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.send,
                              color: Colors.white), // Changed to send icon
                        ),
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

// MessageBubble remains the same
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
