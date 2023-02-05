import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }

  List<String> categories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashions",
  ];

  String selectedCategory = "Select category";

  List<File> images = [];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
        context: context,
        name: _productNameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        quantity: double.parse(_quantityController.text),
        category: selectedCategory,
        images: images,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.appBarGradient,
            ),
          ),
          title: const Text(
            "Add Product",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isNotEmpty
                    ? CarouselSlider(
                  items: images
                      .map(
                        (i) =>
                        Builder(
                          builder: (context) =>
                              Image.file(
                                i,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                        ),
                  )
                      .toList(),
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    height: 200.0,
                  ),
                )
                    : GestureDetector(
                  onTap: selectImages,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(20),
                    dashPattern: const [10, 4],
                    strokeCap: StrokeCap.round,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.folder_open,
                            size: 40.0,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Select Product Images',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _productNameController,
                  hintText: "Product Name",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: "Description",
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _priceController,
                  hintText: "Price",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _quantityController,
                  hintText: "Quantity",
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: selectedCategory,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: categories
                        .map(
                          (String item) =>
                          DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ),
                    )
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(text: "Sell", onPressed: () {
                  sellProduct();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
