import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImages extends StatelessWidget {
  final double height;
  final List<String> images;
  final BoxFit fit;
  const CarouselImages({Key? key, required this.height, required this.images, required this.fit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images
          .map(
            (i) => Builder(
              builder: (context) => Image.network(
                i,
                height: height,
                fit: fit,
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        viewportFraction: 1.0,
        height: height,
      ),
    );
  }
}
