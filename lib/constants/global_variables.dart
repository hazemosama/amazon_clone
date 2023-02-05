import 'package:flutter/material.dart';

const String uri = 'http://192.168.1.7:3000';

class GlobalVariables {
  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://www.linkpicture.com/q/Screenshot-2023-01-13-145725.png',
    'https://www.linkpicture.com/q/Screenshot-2023-01-13-145752.png',
    'https://www.linkpicture.com/q/Screenshot-2023-01-13-145806.png',
    'https://www.linkpicture.com/q/Screenshot-2023-01-13-145818.png',
    'https://www.linkpicture.com/q/Screenshot-2023-01-13-145832.png',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];

  static const List<Map<String, String>> dummyOffers = [
    {
      'title': 'Up to 15% off Kitchen essentials',
      'image': 'https://i.ibb.co/8bZC91r/1.png',
    },
    {
      'title': 'Headphones Up to 20% off',
      'image': 'https://i.ibb.co/9VFkg3K/2.png',
    },
    {
      'title': 'Makeup New arrivals',
      'image': 'https://i.ibb.co/RcTbqTt/3.png',
    },
    {
      'title': 'Up to 15% off Blankets & Quilts',
      'image': 'https://i.ibb.co/4pTqMy2/4.png',
    },
    {
      'title': 'Up to 40% off Watches',
      'image': 'https://i.ibb.co/Stgwcb6/5.png',
    },

  ];
}