import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../providers/user_provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.currentPage,
    required this.onTap,
    required this.tab1Icon,
    required this.tab2Icon,
    required this.tab3Icon,
    required this.tab4Icon,
    this.userCartLen,
  }) : super(key: key);

  final int currentPage;
  final ValueChanged<int>? onTap;
  final IconData tab1Icon;
  final IconData tab2Icon;
  final IconData tab3Icon;
  final IconData tab4Icon;
  final int? userCartLen;

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart!.length;
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black12,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        isScrollable: false,
        splashBorderRadius: const BorderRadius.all(Radius.circular(1000)),
        automaticIndicatorColorAdjustment: false,
        splashFactory: NoSplash.splashFactory,
        overlayColor:
            MaterialStateProperty.resolveWith((states) => Colors.transparent),
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
        indicatorWeight: 1,
        indicator: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 5,
              color: AppColors.teal,
            ),
          ),
        ),
        onTap: onTap,
        // flutter tab bar custom width
        tabs: [
          Tab(
            icon: Icon(
              tab1Icon,
              color: currentPage == 0 ? AppColors.teal : Colors.black,
              size: 27,
            ),
          ),
          Tab(
            icon: Icon(
              tab2Icon,
              color: currentPage == 1 ? AppColors.teal : Colors.black,
              size: 27,
            ),
          ),
          Tab(
            icon: userCartLen != null
                ? SizedBox(
                    child: Badge(
                      padding: const EdgeInsets.all(4),
                      showBadge: userCartLen != null && userCartLen != 0,
                      elevation: 0,
                      badgeContent: Text(
                        '$userCartLength',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: currentPage == 2 ? AppColors.teal : Colors.black,
                        ),
                      ),
                      badgeColor: Colors.white,
                      position: BadgePosition.topStart(start: 10, top: -8),
                      child: Icon(
                        tab3Icon,
                        color: currentPage == 2 ? AppColors.teal : Colors.black,
                        size: 27,
                      ),
                    ),
                  )
                : Icon(
                    tab3Icon,
                    color: currentPage == 2 ? AppColors.teal : Colors.black,
                    size: 27,
                  ),
          ),
          Tab(
            icon: Icon(
              tab4Icon,
              color: currentPage == 3 ? AppColors.teal : Colors.black,
              size: 27,
            ),
          ),
        ],
      ),
    );
  }
}
