import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String userName;
  final int index;

  const ChatDetailScreen({super.key, required this.userName, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage('https://loremflickr.com/100/100/pixelart,avatar?random=${index + 100}'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const Text('Active now', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.normal)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.videocam_outlined, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Chat Bubbles
          Expanded(
            child: ListView.builder(
              reverse: true, // Flips the list so new messages appear at the bottom
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: 12,
              itemBuilder: (context, i) {
                // Mocking alternating messages
                bool isMe = i % 2 == 0;
                return _buildMessageBubble(isMe, i);
              },
            ),
          ),

          // Message Input Field
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 12,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF0A0A0A),
              border: Border(top: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(color: Color(0xFF141414), shape: BoxShape.circle),
                  child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFF141414),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: const TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Message...',
                        hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.mic_none_outlined, color: Colors.white, size: 26),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(bool isMe, int i) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12), // FIXED: Removed maxLines: 1
        constraints: const BoxConstraints(maxWidth: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: isMe
              ? const LinearGradient(colors: [Color(0xFF8A2387), Color(0xFFE94057)])
              : null,
          color: isMe ? null : const Color(0xFF141414),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 20),
          ),
        ),
        child: Text(
          isMe ? 'Are we still using the Gemini API for the capstone? 🤖' : 'Yeah, I already built out the REST endpoints for it.',
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}