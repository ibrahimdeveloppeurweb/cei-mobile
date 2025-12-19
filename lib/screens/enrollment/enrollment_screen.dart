import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_recap_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_step6_screen.dart';
import 'package:cei_mobile/screens/enrollment/enrollment_step7_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'enrollment_step1_screen.dart';
import 'enrollment_step2_screen.dart';
import 'enrollment_step3_screen.dart';
import 'enrollment_step4_screen.dart';
import 'enrollment_step5_screen.dart';

class EnrollmentScreen extends StatefulWidget {
  const EnrollmentScreen({Key? key}) : super(key: key);

  @override
  _EnrollmentScreenState createState() => _EnrollmentScreenState();
}

class _EnrollmentScreenState extends State<EnrollmentScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    enrollmentStore.loadSavedEnrollmentData().then((_) {
      _pageController.jumpToPage(enrollmentStore.currentStep);
      setState(() {

      });
    });

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            GoRouter.of(context).pop(true);
          },
        ),
        title: const Text('Je m\'enrôle'),
      ),
      body: Observer(
        builder: (BuildContext context) {
          if (_pageController.hasClients &&
              _pageController.page?.round() != enrollmentStore.currentStep) {
            _pageController.animateToPage(
              enrollmentStore.currentStep,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }

          return PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Disable swiping
            onPageChanged: (index) {
              enrollmentStore.goToStep(index);
            },
            children: const [
              EnrollmentStep1Screen(),
              EnrollmentStep2Screen(),
              EnrollmentStep3Screen(),
              EnrollmentStep4Screen(),
              EnrollmentStep5Screen(),
              EnrollmentStep6Screen(),
              EnrollmentStep7Screen(),
              EnrollmentRecapScreen()
            ],
          );
        },
      ),
    );
  }
}