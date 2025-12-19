

import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/screens/account/identity_recap_scan_customer_screen.dart';
import 'package:cei_mobile/screens/account/identity_step1_scan_customer_screen.dart';
import 'package:cei_mobile/screens/account/identity_step2_scan_customer_screen.dart';
import 'package:cei_mobile/screens/account/identity_step3_scan_customer_screen.dart';
import 'package:cei_mobile/screens/account/identity_step4_scan_customer_screen.dart';
import 'package:cei_mobile/screens/account/identity_step5_scan_customer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class ScanInfoCustomer extends StatefulWidget {
  const ScanInfoCustomer({super.key});

  @override
  State<ScanInfoCustomer> createState() => _ScanInfoCustomerState();
}

class _ScanInfoCustomerState extends State<ScanInfoCustomer> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    scanCustomerStore.loadSavedScanCustomerData().then((_) {
      _pageController.jumpToPage(scanCustomerStore.currentStep);
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
    return ScaffoldBgWidget(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              GoRouter.of(context).pop(true);
            },
          ),
          title: const Text('Je m\' identifie'),
        ),
        body: Observer(
          builder: (BuildContext context) {
            if (_pageController.hasClients &&
                _pageController.page?.round() != scanCustomerStore.currentStep) {
                _pageController.animateToPage(
                scanCustomerStore.currentStep,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
      
            return PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swiping
              onPageChanged: (index) {
                scanCustomerStore.goToStep(index);
              },
              children: const [
      
                IdentityStep1ScanCustomerScreen(),
                IdentityStep2ScanCustomerScreen(),
                IdentityStep3ScanCustomerScreen(),
                IdentityStep4ScanCustomerScreen(),
                IdentityStep5ScanCustomerScreen(),
                IdentityRecapScreen(),
                // EnrollmentStep5Screen(),
                 //EnrollmentStep6Screen(),
                 //EnrollmentStep7Screen(),
      
              ],
            );
          },
        ),
      ),
    );
  }
}
