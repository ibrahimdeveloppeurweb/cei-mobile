import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:flutter/material.dart';

class ScaffoldBgWidget extends StatelessWidget {
  final Widget child;
  const ScaffoldBgWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetConstants.scaffoldBg),
            fit: BoxFit.cover,
          ),
        ),),
        child
      ],
    );
  }
}
