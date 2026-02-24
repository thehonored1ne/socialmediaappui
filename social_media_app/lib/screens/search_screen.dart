import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: const Color(0xFF0A0A0A).withOpacity(0.95),
            elevation: 0,
            title: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search creators, tags, vibes...',
                  hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.white54, size: 20),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 100),
            sliver: SliverMasonryGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childCount: 40,
              itemBuilder: (context, index) {
                // Generates random heights for the staggered effect
                double height = (index % 4 + 2) * 75.0;
                bool isVideo = index % 5 == 0;
                return _buildGridItem(height, index, isVideo);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(double height, int index, bool isVideo) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://loremflickr.com/400/600/coding,hardware?random=${index + 50}',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
            if (isVideo)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
                ),
              ),
            Positioned(
              bottom: 12,
              left: 12,
              child: Row(
                children: [
                  const Icon(Icons.favorite, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '${(index + 1) * 3}k',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}