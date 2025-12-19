import 'package:cei_mobile/common_widgets/button_widget.dart';
import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/constants/app_constants.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return  ScaffoldBgWidget(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( "Akwaba".toUpperCase(), style: boldTextStyle(size: 48,  color: Colors.white)),
                RichTextWidget(
                  list: [
                    TextSpan( text: "sur ".toUpperCase(), style: boldTextStyle(size: 48,  color: Colors.white)),
                    TextSpan(text: AppConstants.appName.toUpperCase(), style: boldTextStyle(size: 48,   color: AppColors.secondary)),
                  ],
                ),
                10.height,
                const Text( "Votre CEI à portée de main sans vous déplacer", style: TextStyle(color: Colors.white, fontSize: 24)),
              ],
            ),
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  AppButton(
                    width: context.width(),
                    shapeBorder:
                    RoundedRectangleBorder(borderRadius: radius()),
                    onTap: () {
                      context.go(AppRoutes.loginPath);
                    },
                    elevation: 0.0,
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Text('Se connecter',
                        style: boldTextStyle(color: AppColors.primary)),
                  ),
                  10.height,
                  AppButton(
                    width: context.width(),
                    shapeBorder:
                    RoundedRectangleBorder(borderRadius: radius()),
                    onTap: () {

                    },
                    elevation: 0.0,
                    color: AppColors.secondary,
                    padding: EdgeInsets.all(16),
                    child: Text("Liste électorale provisoire 2025",
                        style: boldTextStyle(color: Colors.white)),
                  ),
                ],
              )
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
