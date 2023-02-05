import 'package:amazon_clone/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_bottom_navbar.dart';
import '../../../constants/app_colors.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  changePage(int page) {
    _pageController.jumpToPage(page);
    setState(() {
      _currentPage = page;
    });
  }

  List<Widget> screens = <Widget>[
    const PostsScreen(),
    const Center(
      child: Text('Analytics Screen'),
    ),
    const Center(
      child: Text('Cart Screen'),
    ),
    const Center(
      child: Text('Menu Screen'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 2.0),
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/amazon_in.png',
                    width: 105,
                    height: 37,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Admin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: screens,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentPage: _currentPage,
          onTap: changePage,
          tab1Icon: Icons.home_outlined,
          tab2Icon: Icons.analytics_outlined,
          tab3Icon: Icons.all_inbox_outlined,
          tab4Icon: Icons.menu,
        ),
      ),
    );
  }
}
