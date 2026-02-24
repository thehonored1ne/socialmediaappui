import 'package:flutter/material.dart';

class ReelItem extends StatelessWidget {
  final int index;
  const ReelItem({super.key, required this.index});

  // A list of random dev-focused captions
  static const List<String> _captions = [
    'Finally got this Flutter multi-persona chatbot working. 🤖 #FlutterDev #AI',
    'Debugging this IoT soil monitoring sensor... send help. 🪴 #CapstoneProject #Hardware',
    'Building out the REST API logic today. JSON everywhere. 🌐 #Backend #WebDev',
    'Taking a break from Laravel to draw some pixel art assets. 🎨 #Krita #GameDev',
    'Optimizing my setup so I can push rank in Valorant later. 🖥️ #Hardware #Gaming',
    'Just another late night fighting with CSS and discrete math. ☕ #WebDev #StudentLife',
    'Building smooth Flutter animations today. Notice how the gradient makes this text pop? 🚀 #Flutter #UI',
  ];

  @override
  Widget build(BuildContext context) {
    // Selects a caption based on the index, looping back to the start if needed
    final String currentCaption = _captions[index % _captions.length];

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://loremflickr.com/1080/1920/programming,developer?random=${index + 200}',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(color: const Color(0xFF141414));
          },
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.8),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildAction(Icons.favorite, '342k', Colors.redAccent),
              const SizedBox(height: 24),
              _buildAction(Icons.chat_bubble_outline, '1,204', Colors.white),
              const SizedBox(height: 24),
              _buildAction(Icons.send_rounded, 'Share', Colors.white),
              const SizedBox(height: 24),
              const Icon(Icons.more_horiz, color: Colors.white, size: 32),
            ],
          ),
        ),
        Positioned(
          left: 16,
          bottom: 110,
          right: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage('https://loremflickr.com/100/100/pixelart,avatar'),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'dion.El65',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('Follow', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                currentCaption, // Using the dynamic caption here
                style: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.music_note, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text('Original Audio - dion.El65', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAction(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 36),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }
}