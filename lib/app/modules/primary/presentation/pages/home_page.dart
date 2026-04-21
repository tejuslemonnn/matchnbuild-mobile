import 'package:flutter/material.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/home_content.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/message_content.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/profile_content.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/project_content.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/pages/search_content.dart';
import 'package:mnb_mobile/app/modules/primary/presentation/widgets/message_content_widgets.dart';
import 'package:mnb_mobile/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  static const _activeNavigationColor = ChakraColors.yellow500;
  static const _inboxItems = [
    MessageChatItemData(
      name: 'Studio Karsa',
      time: '09:41',
      message: 'Halo, revisi layout ruang tamu sudah kami kirim ya.',
      isUnread: true,
    ),
    MessageChatItemData(
      name: 'Nirmana House',
      time: 'Kemarin',
      message: 'Baik, kami jadwalkan meeting lanjutan untuk bahas material.',
      isUnread: false,
    ),
    MessageChatItemData(
      name: 'Atelier Ruang',
      time: 'Senin',
      message: 'Mohon cek invoice terbaru untuk tahap pengembangan desain.',
      isUnread: true,
    ),
  ];

  final List<Widget> _pages = const [
    HomeContent(),
    SearchContent(),
    ProjectContent(),
    MessageContent(),
    ProfileContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: ChakraColors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/png/logo-app.png', height: 36),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: _inboxItems.length,
                    itemBuilder: (context, index) =>
                        MessageChatRow(data: _inboxItems[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: Image.asset('assets/png/logo-app.png'),
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openEndDrawer(),
              child: const Icon(Icons.inbox),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: ChakraColors.white,
        selectedItemColor: _activeNavigationColor,
        unselectedItemColor: AppColors.disabledColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home, color: _activeNavigationColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search, color: _activeNavigationColor),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            activeIcon: Icon(Icons.work, color: _activeNavigationColor),
            label: 'Project',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.message, color: _activeNavigationColor),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person, color: _activeNavigationColor),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
