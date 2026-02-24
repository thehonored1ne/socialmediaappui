import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import 'post_screen.dart';
import 'messages_screen.dart'; // 1. Import the new screen

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: Colors.black.withValues(alpha: 0.8),
            title: const Text(
              'DevNotes',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 28,
                letterSpacing: -1.2,
              ),
            ),
            actions: [
              IconButton(
                // 2. Swapped the icon to look more like a DM button
                icon: const Icon(Icons.send_rounded, color: Colors.white),
                onPressed: () {
                  // 3. Route to the Messages Inbox
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MessagesScreen(),
                    ),
                  );
                },
              )
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                bool isVideo = index % 3 == 0;
                return PostCard(isVideo: isVideo, index: index);
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}