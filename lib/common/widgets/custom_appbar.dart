import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../features/search/screens/search_screen.dart';

class CustomAppBar extends StatelessWidget {
  final bool backButton;
  final bool? searchBar;
  final Widget? trailing;
  final String? searchHint;

  const CustomAppBar({
    Key? key,
    required this.backButton,
    this.searchBar = true,
    this.trailing,
    this.searchHint = 'Search Amazon.eg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToSearchScreen(String searchQuery) {
      Navigator.pushNamed(
        context,
        SearchScreen.routeName,
        arguments: searchQuery,
      );
    }

    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.appBarGradient,
        ),
      ),
      titleSpacing: 0.0,
      toolbarHeight: 68,
      leadingWidth: backButton ? 60 : 20,
      leading: Visibility(
        visible: backButton,
        child: const BackButton(),
      ),
      title: Visibility(
        visible: searchBar!,
        child: SizedBox(
          width: backButton ? 320 : 362,
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(8),
            child: TextFormField(
              onFieldSubmitted: navigateToSearchScreen,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                  borderSide: BorderSide(
                    color: Colors.black38,
                    width: 1.0,
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
                hintText: searchHint!,
                hintStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ),
      actions: [if (trailing != null) trailing!],
    );
  }
}
