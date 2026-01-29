import 'dart:convert';
import 'package:flutter/material.dart';

class FullScreenImageViewer extends StatelessWidget {
  final String imageBase64;
  final String tag;

  const FullScreenImageViewer({
    super.key, 
    required this.imageBase64, 
    this.tag = 'image_hero'
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Hero(
            tag: tag,
            child: Image.memory(
              base64Decode(imageBase64),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
