import 'package:flutter/material.dart';
import 'caption_screen.dart';

class PostScreen extends StatefulWidget {
  final VoidCallback onClose; // 1. Add this callback

  const PostScreen({super.key, required this.onClose}); // 2. Require it in the constructor

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String _selectedImageUrl = 'https://loremflickr.com/800/800/technology,computer?random=500';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: widget.onClose, // 3. Trigger the callback when tapped
        ),
        title: const Text('New Post', style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CaptionScreen(imageUrl: _selectedImageUrl),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Next', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // 1. The Viewfinder
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Image.network(
                  _selectedImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(color: const Color(0xFF141414));
                  },
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.aspect_ratio_rounded, color: Colors.white, size: 20),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.layers_outlined, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),

          // 2. The Control Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFF0A0A0A),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text('Recents', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.grey[900], shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.grey[900], shape: BoxShape.circle),
                      child: const Icon(Icons.copy_rounded, color: Colors.white, size: 18),
                    ),
                  ],
                )
              ],
            ),
          ),

          // 3. The Gallery Grid
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemCount: 40,
              itemBuilder: (context, index) {
                final String currentGridImageUrl = 'https://loremflickr.com/800/800/technology,computer?random=${index + 500}';
                final bool isSelected = _selectedImageUrl == currentGridImageUrl;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageUrl = currentGridImageUrl;
                    });
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        currentGridImageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(color: const Color(0xFF141414));
                        },
                      ),
                      if (isSelected)
                        Container(
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}