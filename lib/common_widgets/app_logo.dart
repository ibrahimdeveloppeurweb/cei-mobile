import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  double? size;
  AppLogo({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetConstants.logo,
      width: 200,
      height: size??100,
    );
  }
}
