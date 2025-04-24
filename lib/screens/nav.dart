import 'package:experiment/extentions.dart';

class Nav extends StatefulWidget {
  Nav({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  int selectedIndex;
  final ValueChanged<int> onIndexChanged;

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const CartScreen(),
    ChatListScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}









