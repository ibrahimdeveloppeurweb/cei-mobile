import 'dart:convert';

import 'package:cei_mobile/common_widgets/moke_search_widget.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/model/user/user_model.dart';
import 'package:cei_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class CandidatureVerificationScreen extends StatefulWidget {
  const CandidatureVerificationScreen({super.key});

  @override
  _CandidatureVerificationScreenState createState() =>
      _CandidatureVerificationScreenState();
}

class _CandidatureVerificationScreenState
    extends State<CandidatureVerificationScreen> {
  UserModel? verificationResult;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() {
    // Check if user was previously verified
    final hasVerifiedUser =
    getBoolAsync('has_verified_user', defaultValue: false);

    if (hasVerifiedUser) {
      // Create a user model from saved data
      final dateOfBirth = getStringAsync('verified_user_dob', defaultValue: '');
      DateTime? dob;
      try {
        if (dateOfBirth.isNotEmpty) {
          // Parse ISO date format (yyyy-MM-dd)
          final parts = dateOfBirth.split('-');
          dob = DateTime(
              int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
        }
      } catch (e) {
        print('Error parsing date: $e');
      }

      setState(() {
        verificationResult = UserModel(
          firstName:
          getStringAsync('verified_user_firstName', defaultValue: ''),
          lastName: getStringAsync('verified_user_lastName', defaultValue: ''),
          uniqueRegistrationNumber: getStringAsync(
              'verified_user_uniqueRegistrationNumber',
              defaultValue: ''),
          gender: getStringAsync('verified_user_gender', defaultValue: ''),
          dateOfBirth: dob,
          profession:
          getStringAsync('verified_user_profession', defaultValue: ''),
        );
      });

      // If verification already done, move to next step
      Future.delayed(const Duration(milliseconds: 500), () {
        candidatureStore.nextStep();
      });
    }
  }

  void _saveVerificationResult(UserModel user) {
    // Mark that we have a verified user
    setValue('has_verified_user', true);

    // Save user data
    setValue('verified_user_id', user.id.validate());
    setValue('verified_user_firstName', user.firstName.validate());
    setValue('verified_user_lastName', user.lastName.validate());
    setValue('verified_user_uniqueRegistrationNumber',
        user.uniqueRegistrationNumber.validate());
    setValue('verified_user_gender', user.gender.validate());

    if (user.dateOfBirth != null) {
      final dob =
          '${user.dateOfBirth!.year}-${user.dateOfBirth!.month.toString().padLeft(2, '0')}-${user.dateOfBirth!.day.toString().padLeft(2, '0')}';
      setValue('verified_user_dob', dob);
    }

    setValue('verified_user_profession', user.profession.validate());

    if (user.pollingStation != null) {
      setValue('verified_user_pollingStation',
          user.pollingStation!.numero.validate());

      if (user.pollingStation!.centre != null) {
        setValue('verified_user_centre',
            user.pollingStation!.centre!.name.validate());
      }
    }

    // Pre-fill some candidature data if not already set
    if (candidatureStore.nom.isEmpty) {
      // candidatureStore.setStep1Data(
      //   nom: user.lastName.validate(),
      //   prenoms: user.firstName.validate(),
      //   dateNaissance: user.dateOfBirth,
      //   lieuNaissance: '', // Will be filled by user later
      //   nationalite: 'Ivoirienne',
      //   profession: user.profession.validate(),
      //   adresse: '', // Will be filled by user later
      //   genre: user.gender.validate(),
      //   emailContact: '', // Will be filled by user later
      //   telephoneContact: '', // Will be filled by user later
      // );

      // Save the data to persistent storage
      candidatureStore.saveCandidatureData();
    }

    // Move to next step using the store
    candidatureStore.nextStep();
  }

  void _resetVerification() {
    setState(() {
      verificationResult = null;
    });

    // Clear saved verification data
    setValue('has_verified_user', false);
    setValue('verified_user_id', '');
    setValue('verified_user_firstName', '');
    setValue('verified_user_lastName', '');
    setValue('verified_user_uniqueRegistrationNumber', '');
    setValue('verified_user_gender', '');
    setValue('verified_user_dob', '');
    setValue('verified_user_profession', '');
    setValue('verified_user_pollingStation', '');
    setValue('verified_user_centre', '');

    toast('État de vérification réinitialisé', gravity: ToastGravity.BOTTOM);
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
                // Title header
                Text(
                  'Vérification',
                  style: boldTextStyle(
                      size: 36, letterSpacing: 2, color: Colors.black),
                ),
                Text(
                  'enrôlement',
                  style: boldTextStyle(
                      size: 36, letterSpacing: 2, color: Colors.black),
                ),
                30.height,

                // If verification result already exists, show result, otherwise show search form
                MockSearchForm(
                  selectedType: 'Candidature',
                  onContinue: (personFound, user) {
                    if (personFound && user != null) {
                      setState(() {
                        verificationResult = user;
                      });
                      _saveVerificationResult(user);
                    } else {
                      toast(
                          'Vous devez être enrôlé pour poser votre candidature.');
                    }
                  },
                  onBack: () {
                    // Navigate back
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildStepperIndicator() {
    const int totalSteps = 8; // Total steps in the candidature process
    const int currentStep = 0; // This is the first step (index 0)

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final bool isActive = index <= currentStep;
        final bool isCurrent = index == currentStep;

        return Row(
          children: [
            // Step indicator dot
            Container(
              width: isCurrent ? 28 : 20,
              height: isCurrent ? 28 : 20,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.grey.shade300,
                shape: BoxShape.circle,
                border: isCurrent
                    ? Border.all(
                    color: AppColors.primary.withOpacity(0.3), width: 4)
                    : null,
              ),
              child: isCurrent
                  ? Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              )
                  : index < currentStep
                  ? const Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),

            // Connector line (except for last item)
            if (index < totalSteps - 1)
              Container(
                width: 20,
                height: 2,
                color: index < currentStep
                    ? AppColors.primary
                    : Colors.grey.shade300,
              ),
          ],
        );
      }),
    );
  }
}