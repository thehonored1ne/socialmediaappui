import 'package:flutter/material.dart';
import 'video_player_placeholder.dart';

class PostCard extends StatefulWidget {
  final bool isVideo;
  final int index;
  const PostCard({super.key, required this.isVideo, required this.index});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with SingleTickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _controller;
  late Animation<double> _scale;

  static const List<String> _users = [
    'dion.El65',
    'pixel.coder',
    'flutter.dev',
    'byte.builder',
    'logic_gate',
    'ui.ninja',
  ];

  static const List<String> _captions = [
    'Integrating the Gemini API into my new multi-persona Flutter chatbot. 🤖 #FlutterDev #AI',
    'Wiring up the sensors for my IoT soil monitoring capstone project. 🪴 #Hardware #IoT',
    'Styling my new portfolio site. Windows 98 aesthetic all the way! 🪟 #CSS #WebDev',
    'Testing out some new REST API endpoints today. 🌐 #Backend',
    'Taking a break to draw some pixel art assets in Krita. 🎨 #GameDev',
    'Building something sleek with Flutter today. Drop your thoughts below. 🚀 #FlutterDev #UI',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() async {
    await _controller.forward();
    setState(() => isLiked = !isLiked);
    _controller.reverse();
  }

  // The new bottom sheet function
  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to take up more screen space
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75, // Takes up 75% of the screen
          decoration: BoxDecoration(
            color: const Color(0xFF141414),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: [
              // Drag Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Text('Comments', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const Divider(color: Colors.white10, height: 24),

              // Comments List
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage('https://loremflickr.com/100/100/pixelart,avatar?random=${index + 20}'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('dev_user_$index', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                                    const SizedBox(width: 8),
                                    const Text('1h', style: TextStyle(color: Colors.white54, fontSize: 12)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'This UI is looking so clean! Drop the GitHub repo when you are done. 🚀',
                                  style: TextStyle(color: Colors.white, fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                const Text('Reply', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          const Icon(Icons.favorite_border, color: Colors.white54, size: 16),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Sticky Input Field
              Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16, // Adjusts for the keyboard
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
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage('https://loremflickr.com/100/100/pixelart,avatar'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                        child: const TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String currentCaption = _captions[widget.index % _captions.length];
    final String currentUser = _users[widget.index % _users.length];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  backgroundImage: NetworkImage('https://loremflickr.com/100/100/pixelart,avatar?random=${widget.index}'),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentUser, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    const Text('2 hours ago', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_horiz, color: Colors.white54),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: widget.isVideo
                ? const VideoPlayerPlaceholder()
                : Image.network(
              'https://loremflickr.com/500/500/technology,computer?random=${widget.index + 5000}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 350,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(height: 350, color: const Color(0xFF141414));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _toggleLike,
                  child: ScaleTransition(
                    scale: _scale,
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.redAccent : Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Wrapped the comment icon to open the bottom sheet
                GestureDetector(
                  onTap: () => _showCommentsBottomSheet(context),
                  child: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.send_rounded, color: Colors.white, size: 26),
                const Spacer(),
                const Icon(Icons.bookmark_border, color: Colors.white, size: 28),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                children: [
                  TextSpan(text: '$currentUser ', style: const TextStyle(fontWeight: FontWeight.w700)),
                  TextSpan(text: currentCaption),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}