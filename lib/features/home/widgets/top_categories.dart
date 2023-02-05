import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/category_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({Key? key}) : super(key: key);

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  void navigateToCategoryScreen(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoryScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVariables.categoryImages.length,
        itemExtent: 80.0,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            navigateToCategoryScreen(
                context, GlobalVariables.categoryImages[index]["title"]!);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset(
                    GlobalVariables.categoryImages[index]["image"]!,
                    fit: BoxFit.cover,
                    height: 55,
                    width: 55,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                GlobalVariables.categoryImages[index]["title"]!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
