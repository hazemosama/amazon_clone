import 'package:amazon_clone/common/widgets/custom_bottom_navbar.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = '/layout';

  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  List<Widget> screens = <Widget>[
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
    const Center(
      child: Text('Menu Screen'),
    ),
  ];


  final PageController _pageController = PageController();
  int _currentPage = 0;

  changePage(int page) {
    _pageController.jumpToPage(page);
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartLength = context.watch<UserProvider>().user.cart!.length;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: screens,
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentPage: _currentPage,
          onTap: changePage,
          tab1Icon: CupertinoIcons.home,
          tab2Icon: CupertinoIcons.person,
          tab3Icon: CupertinoIcons.shopping_cart,
          tab4Icon: Icons.menu,
          userCartLen: cartLength,
        ),
      ),
    );
  }
}
