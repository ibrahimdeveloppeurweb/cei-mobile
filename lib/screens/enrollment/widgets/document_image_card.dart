import 'dart:io';
import 'package:cei_mobile/core/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DocumentImageCard extends StatelessWidget {
  final String title;
  final File? image;

  const DocumentImageCard({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != null)
                Image.file(
                  image!,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  title,
                  style: boldTextStyle(size: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    ).onTap(() {
      if (image != null) {
        openFile(image!.path);
      }
    });
  }
}
