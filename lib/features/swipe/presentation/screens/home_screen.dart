import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/features/swipe/presentation/screens/main_swipe.dart';
import 'package:metin/features/user/messages/presentation/screens/messages_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOutQuad);
        },
        unselectedItemColor: const Color(0xffadafba),
        selectedItemColor: primaryColor,
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Transform.rotate(
                  angle: 30,
                  child: const Icon(
                    Icons.rectangle_rounded,
                  ),
                ),
                Positioned(
                  right: 5,
                  child: Transform.rotate(
                    angle: 180,
                    child: const Icon(
                      Icons.rectangle_rounded,
                    ),
                  ),
                ),
              ],
            ),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.briefcase,
            ),
            label: "Suite case",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.solidMessage,
            ),
            label: "Messages",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.gear,
            ),
            label: "Settings",
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          MainSwipeScreen(),
          Container(
            color: Colors.blue,
          ),
          const MessagesScreen(),
          Container(
            color: Colors.green,
          )
        ],
      ),
    );
  }
}
