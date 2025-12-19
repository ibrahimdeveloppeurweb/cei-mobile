import 'package:cei_mobile/common_widgets/app_logo.dart';
import 'package:cei_mobile/common_widgets/loading_indicator.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/screens/splash/providers/first_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      final firstTimeProvider = Provider.of<FirstTimeProvider>(context, listen: false);
      firstTimeProvider.checkFirstTime().then((_) {
        firstTimeProvider.isFirstTime?
        context.go(AppRoutes.homePath):context.go(AppRoutes.homePath);
        firstTimeProvider.setFirstTimeComplete();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Logo animé
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: ScaleTransition(
                scale: _animation,
                child: AppLogo(),
              ),
            ),
          ),

          const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: LoadingIndicator()
            ),
          ),
        ],
      ),
    );
  }
}