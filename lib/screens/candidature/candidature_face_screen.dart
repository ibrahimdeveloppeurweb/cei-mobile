import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/main.dart';

class CandidatureFaceScreen extends StatefulWidget {
  const CandidatureFaceScreen({Key? key}) : super(key: key);

  @override
  _CandidatureFaceScreenState createState() => _CandidatureFaceScreenState();
}

class _CandidatureFaceScreenState extends State<CandidatureFaceScreen> {
  bool _isVerifying = false;
  bool _isVerified = false;
  File? _capturedImage;

  @override
  void initState() {
    super.initState();
    _checkExistingVerification();
  }

  Future<void> _checkExistingVerification() async {
    // Check if face verification was already completed
    final completed = getBoolAsync('face_verification_completed', defaultValue: false);

    if (completed) {
      setState(() {
        _isVerified = true;
      });

      // If already verified, move to next step after a short delay
      Future.delayed(Duration(milliseconds: 500), () {
        // Use the store to move to the next step
        candidatureStore.nextStep();
      });
    }
  }

  Future<void> _captureAndVerify() async {
    setState(() {
      _isVerifying = true;
    });

    try {
      // Simulate capturing and verification
      await Future.delayed(const Duration(seconds: 2));

      // Mark as verified and save to preferences
      setState(() {
        _isVerified = true;
        _isVerifying = false;
      });

      setValue('face_verification_completed', true);

      // Move to next step using the store
      candidatureStore.nextStep();
    } catch (e) {
      setState(() {
        _isVerifying = false;
      });
      toast('Erreur lors de la vérification faciale. Veuillez réessayer.',
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Vérification',
                  style: boldTextStyle(
                      size: 36, letterSpacing: 2, color: Colors.black),
                ),
                Text(
                  'd\'identité',
                  style: boldTextStyle(
                      size: 36, letterSpacing: 2, color: Colors.black),
                ),
                30.height,

                // Instructions
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Instructions', style: boldTextStyle()),
                      10.height,
                      Text(
                        '1. Placez votre visage dans le cadre\n'
                            '2. Assurez-vous d\'être dans un endroit bien éclairé\n'
                            '3. Regardez directement l\'appareil photo\n'
                            '4. Ne portez pas de lunettes de soleil ou chapeau',
                        style: secondaryTextStyle(),
                      ),
                    ],
                  ),
                ),
                30.height,

                // Camera preview or verification status
                Center(
                  child: Container(
                    width: 280,
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _isVerified
                            ? Colors.green
                            : AppColors.primary,
                        width: 2,
                      ),
                    ),
                    child: _isVerified
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 80,
                          ),
                          10.height,
                          Text(
                            'Vérification complétée',
                            style: boldTextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    )
                        : Center(
                      child: Icon(
                        Icons.face,
                        size: 120,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
                30.height,

                // Action button
                Center(
                  child: _isVerifying
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _isVerified ? null : _captureAndVerify,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      _isVerified
                          ? 'Vérifié'
                          : 'Vérifier mon identité',
                      style: boldTextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}