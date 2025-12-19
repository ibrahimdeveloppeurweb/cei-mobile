import 'dart:convert';

import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/utils/common.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/repository/verification_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class EnrollmentVerificationScreen extends StatefulWidget {
  final bool isAddLocation;

  const EnrollmentVerificationScreen({super.key, required this.isAddLocation});

  @override
  State<EnrollmentVerificationScreen> createState() =>
      _EnrollmentVerificationScreenState();
}

class _EnrollmentVerificationScreenState
    extends State<EnrollmentVerificationScreen> {
  TextEditingController formNumberController = TextEditingController();
  TextEditingController voterNumberController = TextEditingController();
  TextEditingController familyNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();

  // Date of birth selection
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;

  // Tab selection
  int currentTab = 0;

  // Loading state
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isAddLocation
            ? const Text('Enregistrer mon centre d\'enrolement')
            : const Text('Liste Électorale Provisoire 2025'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with orange border
                if (!widget.isAddLocation)
                  Text(
                    'Liste Électorale Provisoire 2025',
                    style: boldTextStyle(size: 22),
                  ),
                20.height,
                if (widget.isAddLocation)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.shade300),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.orange),
                        12.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vérifiez votre inscription sur la liste électorale, puis enregistrez votre centre d\'enrolement.',
                                style: primaryTextStyle(size: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                20.height,
                Text(
                  'Vous vous êtes faits enrôler et souhaitez vérifier votre inscription sur la liste électorale provisoire 2025 ?',
                  style: primaryTextStyle(size: 14),
                ),
                12.height,
                Text(
                  'La Commission Électorale Indépendante vous permet de vérifier votre présence sur la liste électorale provisoire 2025 sans avoir à vous déplacer dans un centre de recensement.',
                  style: primaryTextStyle(size: 14),
                ),
                20.height,
                Text(
                  'CHOISISSEZ ENTRE LES TROIS MODES DE RECHERCHE :',
                  style: boldTextStyle(size: 14),
                ),
                20.height,
                buildTabs(),
                20.height,
                buildTabContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabs() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => setState(() => currentTab = 0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: currentTab == 0
                        ? AppColors.primary
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                '1. Soit avec votre numéro de formulaire',
                style: TextStyle(
                  fontWeight:
                      currentTab == 0 ? FontWeight.bold : FontWeight.normal,
                  color: currentTab == 0 ? AppColors.primary : Colors.black,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => setState(() => currentTab = 1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: currentTab == 1
                        ? AppColors.primary
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                '2. Soit avec votre numéro d\'électeur',
                style: TextStyle(
                  fontWeight:
                      currentTab == 1 ? FontWeight.bold : FontWeight.normal,
                  color: currentTab == 1 ? AppColors.primary : Colors.black,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => setState(() => currentTab = 2),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: currentTab == 2
                        ? AppColors.primary
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                '3. Soit avec vos Nom et Prénom(s)',
                style: TextStyle(
                  fontWeight:
                      currentTab == 2 ? FontWeight.bold : FontWeight.normal,
                  color: currentTab == 2 ? AppColors.primary : Colors.black,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTabContent() {
    if (currentTab == 0) {
      return buildFormNumberSearch();
    } else if (currentTab == 1) {
      return buildVoterNumberSearch();
    } else {
      return buildNameSearch();
    }
  }

  Widget buildFormNumberSearch() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1 - RECHERCHER PAR LE NUMÉRO FORMULAIRE',
            style: boldTextStyle(size: 14),
          ),
          16.height,
          Text(
            'NUMÉRO FORMULAIRE 2025',
            style: primaryTextStyle(size: 12),
          ),
          8.height,
          AppTextField(
            controller: formNumberController,
            textFieldType: TextFieldType.NUMBER,
            maxLength: 10,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '0000000000',
            ),
          ),
          16.height,
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : AppButton(
                  width: 180,
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                  elevation: 0.0,
                  color: AppColors.primary,
                  onTap: () {
                    performFormNumberSearch();
                  },
                  child: Text('Lancer la recherche',
                      style: boldTextStyle(color: Colors.white)),
                ),
        ],
      ),
    );
  }

  Widget buildVoterNumberSearch() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2 - RECHERCHER PAR LE NUMÉRO D\'ÉLECTEUR',
            style: boldTextStyle(size: 14),
          ),
          16.height,
          Text(
            'NUMÉRO D\'ÉLECTEUR',
            style: primaryTextStyle(size: 12),
          ),
          8.height,
          AppTextField(
            controller: voterNumberController,
            textFieldType: TextFieldType.NAME,
            inputFormatters: [VoterIDInputFormatter()],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'V 0000 0000 00',
            ),
          ),
          16.height,
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : AppButton(
                  width: 180,
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                  elevation: 0.0,
                  color: AppColors.primary,
                  onTap: () {
                    performVoterIdSearch();
                  },
                  child: Text('Lancer la recherche',
                      style: boldTextStyle(color: Colors.white)),
                ),
        ],
      ),
    );
  }

  Widget buildNameSearch() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '3 - RECHERCHER PAR NOM, PRÉNOM(S) ET DATE DE NAISSANCE',
            style: boldTextStyle(size: 14),
          ),
          16.height,
          Text(
            'NOM DE FAMILLE OU NOM DE JEUNE FILLE (COMPLET OU PARTIEL)',
            style: primaryTextStyle(size: 12),
          ),
          8.height,
          AppTextField(
            controller: familyNameController,
            textFieldType: TextFieldType.NAME,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  'Nom de famille ou nom de jeune fille (complet ou partiel)',
            ),
          ),
          16.height,
          Text(
            'PRÉNOM(S) (COMPLET OU PARTIEL)',
            style: primaryTextStyle(size: 12),
          ),
          8.height,
          AppTextField(
            controller: firstNameController,
            textFieldType: TextFieldType.NAME,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Vos prénoms (complet ou partiel)',
            ),
          ),
          16.height,
          Text(
            'DATE DE NAISSANCE',
            style: primaryTextStyle(size: 12),
          ),
          4.height,
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text('- Jour -'),
                  value: selectedDay,
                  items: List.generate(31, (index) => index + 1)
                      .map((day) => DropdownMenuItem(
                            value: day.toString(),
                            child: Text(day.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDay = value;
                    });
                  },
                ),
              ),
              4.width,
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text('- Mois -'),
                  value: selectedMonth,
                  items: List.generate(12, (index) => index + 1)
                      .map((month) => DropdownMenuItem(
                            value: month.toString(),
                            child: Text(month.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                  },
                ),
              ),
              4.width,
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text('- Année -'),
                  value: selectedYear,
                  items: List.generate(100, (index) => 2025 - index)
                      .map((year) => DropdownMenuItem(
                            value: year.toString(),
                            child: Text(year.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                ),
              ),
            ],
          ),
          16.height,
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : AppButton(
                  width: 180,
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                  elevation: 0.0,
                  color: AppColors.primary,
                  onTap: () {
                    performNameSearch();
                  },
                  child: Text('Lancer la recherche',
                      style: boldTextStyle(color: Colors.white)),
                ),
        ],
      ),
    );
  }

  // Form number search
  void performFormNumberSearch() async {
    // Validate input
    if (formNumberController.text.isEmpty) {
      toast('Veuillez saisir un numéro de formulaire.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await verifyEnrolmentForm({
        'form': 'NUM_FORM',
        'formNumber': formNumberController.text.trim(),
      });

      setState(() {
        isLoading = false;
      });

      context.pushNamed(
        AppRoutes.enrollmentVerificationResult,
        extra: EnrollmentData.fromJson(result['data']),
      );
    } catch (e) {
      showSearchFailedDialog('$e');
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  // Voter ID search
  void performVoterIdSearch() async {
    // Validate input
    if (voterNumberController.text.isEmpty) {
      toast('Veuillez saisir un numéro d\'électeur.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final result = await verifyEnrolmentUniqId({
        'form': 'NUM_ELECTOR',
        'uniqueRegistrationNumber':  voterNumberController.text.removeAllWhiteSpace(),
      });
      setState(() {
        isLoading = false;
      });

      context.pushNamed(
        AppRoutes.enrollmentVerificationResult,
        extra: EnrollmentData.fromJson(result['data']),
      );
    } catch (e) {
      showSearchFailedDialog('$e');
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  // Name and birthdate search
  void performNameSearch() async {
    // Validate inputs
    if (familyNameController.text.isEmpty) {
      toast('Veuillez saisir un nom de famille.');
      return;
    }

    if (firstNameController.text.isEmpty) {
      toast('Veuillez saisir un prénom.');
      return;
    }

    if (selectedDay == null || selectedMonth == null || selectedYear == null) {
      toast('Veuillez saisir une date de naissance complète.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Format birth date as yyyy-MM-dd
      final birthdate =
          '$selectedYear-${selectedMonth!.padLeft(2, '0')}-${selectedDay!.padLeft(2, '0')}';

      final result = await verifyEnrolmentName({
        'form': 'NAME_AND_BIRTHDATE',
        'firstname':  firstNameController.text.trim(),
        'lastname':familyNameController.text.trim(),
        'birthdate': birthdate,
      });

      setState(() {
        isLoading = false;
      });
      print(result['data']);
      context.pushNamed(
        AppRoutes.enrollmentVerificationResult,
        extra: EnrollmentData.fromJson(result['data']),
      );
    } catch (e) {
      showSearchFailedDialog('$e');
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  void showSearchFailedDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recherche échouée', style: boldTextStyle()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 50,
              ),
              16.height,
              Text(
                message,
                style: primaryTextStyle(),
              ),
              8.height,
              Text(
                'Veuillez vérifier vos informations et réessayer.',
                style: secondaryTextStyle(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('OK', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        );
      },
    );
  }
}
