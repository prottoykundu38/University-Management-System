import 'package:flutter/material.dart';
import 'package:univarsity_management_system/Screens/homeScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  List<Map<String, String>> favoriteEvents = [];

  void _toggleFavorite(Map<String, String> event) {
    setState(() {
      if (favoriteEvents.contains(event)) {
        favoriteEvents.remove(event);
      } else {
        favoriteEvents.add(event);
      }
    });
  }

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomePage(favoriteEvents: favoriteEvents, toggleFavorite: _toggleFavorite),
      FavoriteScreen(favoriteEvents: favoriteEvents),
      // FilterScreen(),
      AddEventPage(),
      NotificationScreen(),
      ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Stack(
          children: [
            // Background with curve
            ClipPath(
              clipper: BottomNavClipper(),
              child: Container(
                height: 70,
                color: const Color(0xFFD1A170),
              ),
            ),
            // Buttons layered on top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_outlined, Icons.home_rounded, 0, 24),
                _buildNavItem(Icons.event_outlined, Icons.event_rounded, 1, 24),
                _buildMiddleButton(Icons.add_circle_outline, Icons.add_circle, 2),
                _buildNavItem(Icons.notifications_outlined, Icons.notifications_rounded, 3, 24),
                _buildNavItem(Icons.person_outline, Icons.person_rounded, 4, 24),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData inactiveIcon, IconData activeIcon, int index, double size) {
    bool isSelected = _selectedIndex == index;
    return IconButton(
      icon: Icon(
        isSelected ? activeIcon : inactiveIcon,
        size: size,
        color: isSelected ? const Color.fromARGB(255, 63, 43, 1) : const Color.fromARGB(255, 253, 198, 144),
      ),
      onPressed: () => _onItemTapped(index),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
      splashRadius: 24,
    );
  }

  Widget _buildMiddleButton(IconData inactiveIcon, IconData activeIcon, int index) {
    bool isSelected = _selectedIndex == index;
    return Material(
      elevation: 4,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => _onItemTapped(index),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? const Color.fromARGB(255, 63, 43, 1) : Colors.grey[200],
          ),
          child: Icon(
            isSelected ? activeIcon : inactiveIcon,
            size: 32,
            color: isSelected ? Colors.white : Color(0xFFD1A170),
          ),
        ),
      ),
    );
  }
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double curveHeight = 20; // Depth of the downward curve
    double curveWidth = 60; // Width of the curve

    Path path = Path();
    path.moveTo(0, 0); // Top-left
    path.lineTo(width / 2 - curveWidth / 2, 0); // Left edge of curve
    path.quadraticBezierTo(
      width / 2, curveHeight, // Downward curve
      width / 2 + curveWidth / 2, 0, // Right edge of curve
    );
    path.lineTo(width, 0); // Top-right
    path.lineTo(width, height); // Bottom-right
    path.lineTo(0, height); // Bottom-left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}