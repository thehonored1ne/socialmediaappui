import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/sticky_tab_delegate.dart';
import 'settings_screen.dart'; // Import your new screen

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              // Added SliverAppBar for the username and settings menu
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: false, // Scrolls away as you swipe up
                title: const Text('DevNotes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),
              const SliverToBoxAdapter(
                child: ProfileHeader(),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabDelegate(
                  const TabBar(
                    indicatorColor: Colors.white,
                    indicatorWeight: 1,
                    dividerColor: Colors.white10,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white38,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_on_rounded)),
                      Tab(icon: Icon(Icons.video_library_outlined)),
                      Tab(icon: Icon(Icons.bookmark_outline)),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildPostGrid(false),
              _buildPostGrid(true),
              _buildPostGrid(false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostGrid(bool isVideo) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 2, bottom: 100), // Clears the floating nav bar
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 1,
      ),
      itemCount: 24,
      itemBuilder: (context, index) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://loremflickr.com/300/300/technology,programming?random=${index + (isVideo ? 100 : 0)}',
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
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.4),
                  ],
                ),
              ),
            ),
            if (isVideo)
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 24),
              ),
          ],
        );
      },
    );
  }
}