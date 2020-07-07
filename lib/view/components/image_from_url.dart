import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';

class ImageFromUrl extends StatelessWidget {
  final String imageUrl;
  const ImageFromUrl({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Icon(Icons.broken_image);
    } else {
      return TransitionToImage(
        image: AdvancedNetworkImage(
            imageUrl, useDiskCache: true),
        placeholder: const Icon(Icons.cloud_queue),
        fit: BoxFit.cover,
      );
    }
  }
}
