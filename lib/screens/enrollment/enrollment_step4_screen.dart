import 'package:cei_mobile/common_widgets/app_logo.dart';
import 'package:cei_mobile/common_widgets/indicator_dot.dart';
import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/core/utils/common.dart' show citiesAndCommunes;
import 'package:cei_mobile/main.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class EnrollmentStep4Screen extends StatefulWidget {
  const EnrollmentStep4Screen({super.key});

  @override
  State<EnrollmentStep4Screen> createState() => _EnrollmentStep4ScreenState();
}

class _EnrollmentStep4ScreenState extends State<EnrollmentStep4Screen> {
  GlobalKey<FormState> formKey = GlobalKey();

  // Father's information controllers
  TextEditingController lastNameFatherCont = TextEditingController(text: enrollmentStore.lastNameFather);
  TextEditingController firstNameFatherCont = TextEditingController(text: enrollmentStore.firstNameFather);
  TextEditingController birthplaceFatherCont = TextEditingController(text: enrollmentStore.birthplaceFather);

  // Mother's information controllers
  TextEditingController lastNameMotherCont = TextEditingController(text: enrollmentStore.lastNameMother);
  TextEditingController firstNameMotherCont = TextEditingController(text: enrollmentStore.firstNameMother);
  TextEditingController birthplaceMotherCont = TextEditingController(text: enrollmentStore.birthplaceMother);

  // Father's date of birth
  String? selectedDayFather;
  String? selectedMonthFather;
  String? selectedYearFather;

  // Mother's date of birth
  String? selectedDayMother;
  String? selectedMonthMother;
  String? selectedYearMother;

  FocusNode lastNameFatherFocus = FocusNode();
  FocusNode firstNameFatherFocus = FocusNode();
  FocusNode birthplaceFatherFocus = FocusNode();
  FocusNode lastNameMotherFocus = FocusNode();
  FocusNode firstNameMotherFocus = FocusNode();
  FocusNode birthplaceMotherFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    // Parse father's birthdate if available
    if (enrollmentStore.birthdateFather.isNotEmpty) {
      try {
        final parts = enrollmentStore.birthdateFather.split('-');
        if (parts.length == 3) {
          selectedYearFather = parts[0];
          selectedMonthFather = parts[1].replaceFirst(RegExp('^0'), ''); // Remove leading zero
          selectedDayFather = parts[2].replaceFirst(RegExp('^0'), ''); // Remove leading zero
        }
      } catch (e) {
        print('Error parsing father birthdate: $e');
      }
    }

    // Parse mother's birthdate if available
    if (enrollmentStore.birthdateMother.isNotEmpty) {
      try {
        final parts = enrollmentStore.birthdateMother.split('-');
        if (parts.length == 3) {
          selectedYearMother = parts[0];
          selectedMonthMother = parts[1].replaceFirst(RegExp('^0'), ''); // Remove leading zero
          selectedDayMother = parts[2].replaceFirst(RegExp('^0'), ''); // Remove leading zero
        }
      } catch (e) {
        print('Error parsing mother birthdate: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IndicatorDot(
                      currentPage: 3,
                      totalItems: 7,
                      selectedDotWidth: 45,
                      unselectedDotWidth: 45,
                    ),
                    30.height,
                    Text("Informations des parents",
                        style: boldTextStyle(
                          size: 36, letterSpacing: 2, )),

                    50.height,

                    // FATHER'S INFORMATION SECTION
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            color: AppColors.primary,
                            size: 24,
                          ),
                          12.width,
                          Expanded(
                            child: Text(
                              'Informations du père',
                              style: boldTextStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.height,

                    const Text(
                      'Nom du père',
                      style: AppTextStyles.body2,
                    ),
                    AppTextField(
                      controller: lastNameFatherCont,
                      focus: lastNameFatherFocus,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                    16.height,
                    const Text(
                      'Prénom(s) du père',
                      style: AppTextStyles.body2,
                    ),
                    AppTextField(
                      controller: firstNameFatherCont,
                      focus: firstNameFatherFocus,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                    16.height,
                    const Text(
                      'Date de naissance du père',
                      style: AppTextStyles.body2,
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
                            value: selectedDayFather,
                            items: List.generate(31, (index) => index + 1)
                                .map((day) => DropdownMenuItem(
                              value: day.toString(),
                              child: Text(day.toString()),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedDayFather = value;
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
                            value: selectedMonthFather,
                            items: List.generate(12, (index) => index + 1)
                                .map((month) => DropdownMenuItem(
                              value: month.toString(),
                              child: Text(month.toString()),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedMonthFather = value;
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
                            value: selectedYearFather,
                            items: List.generate(100, (index) => 1970 - index)
                                .map((year) => DropdownMenuItem(
                              value: year.toString(),
                              child: Text(year.toString()),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedYearFather = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    16.height,
                    const Text(
                      'Lieu de naissance du père',
                      style: AppTextStyles.body2,
                    ),
                    AppTextField(
                      controller: birthplaceFatherCont,
                      focus: birthplaceFatherFocus,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ex: Abidjan, Bouaké, etc.',
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                    30.height,

                    // MOTHER'S INFORMATION SECTION
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            color: AppColors.secondary,
                            size: 24,
                          ),
                          12.width,
                          Expanded(
                            child: Text(
                              'Informations de la mère',
                              style: boldTextStyle(color: AppColors.secondary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.height,

                    const Text(
                      'Nom de la mère',
                      style: AppTextStyles.body2,
                    ),
                    AppTextField(
                      controller: lastNameMotherCont,
                      focus: lastNameMotherFocus,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                    16.height,
                    const Text(
                      'Prénom(s) de la mère',
                      style: AppTextStyles.body2,
                    ),
                    AppTextField(
                      controller: firstNameMotherCont,
                      focus: firstNameMotherFocus,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                    16.height,
                    const Text(
                      'Date de naissance de la mère',
                      style: AppTextStyles.body2,
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
                            value: selectedDayMother,
                            items: List.generate(31, (index) => index + 1)
                                .map((day) => DropdownMenuItem(
                              value: day.toString(),
                              child: Text(day.toString()),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedDayMother = value;
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
                            value: selectedMonthMother,
                            items: List.generate(12, (index) => index + 1)
                                .map((month) => DropdownMenuItem(
                              value: month.toString(),
                              child: Text(month.toString()),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedMonthMother = value;
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
                            value: selectedYearMother,
                            items: List.generate(100, (index) => 1970 - index)
                                .map((year) => DropdownMenuItem(
                              value: year.toString(),
                              child: Text(year.toString()),
                            ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedYearMother = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    16.height,
                    const Text(
                      'Lieu de naissance de la mère',
                      style: AppTextStyles.body2,
                    ),
                    AppTextField(
                      controller: birthplaceMotherCont,
                      focus: birthplaceMotherFocus,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ex: Abidjan, Bouaké, etc.',
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      onTap: () {
                        enrollmentStore.previousStep();
                      },
                      elevation: 0.0,
                      color: Colors.grey[300],
                      child: Text('Précédent',
                          style: boldTextStyle(color: Colors.black)),
                    ),
                  ),
                  8.width,
                  Expanded(
                    child: AppButton(
                      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      onTap: () {
                        // Validate form fields
                        if (lastNameFatherCont.text.isEmpty) {
                          toast('Veuillez saisir le nom du père');
                          return;
                        }
                        if (firstNameFatherCont.text.isEmpty) {
                          toast('Veuillez saisir le prénom du père');
                          return;
                        }
                        if (selectedDayFather == null || selectedMonthFather == null || selectedYearFather == null) {
                          toast('Veuillez sélectionner la date de naissance complète du père');
                          return;
                        }
                        if (birthplaceFatherCont.text.isEmpty) {
                          toast('Veuillez saisir le lieu de naissance du père');
                          return;
                        }
                        if (lastNameMotherCont.text.isEmpty) {
                          toast('Veuillez saisir le nom de la mère');
                          return;
                        }
                        if (firstNameMotherCont.text.isEmpty) {
                          toast('Veuillez saisir le prénom de la mère');
                          return;
                        }
                        if (selectedDayMother == null || selectedMonthMother == null || selectedYearMother == null) {
                          toast('Veuillez sélectionner la date de naissance complète de la mère');
                          return;
                        }
                        if (birthplaceMotherCont.text.isEmpty) {
                          toast('Veuillez saisir le lieu de naissance de la mère');
                          return;
                        }

                        // Format birth dates as yyyy-MM-dd
                        String birthdateFather = '$selectedYearFather-${selectedMonthFather!.padLeft(2, '0')}-${selectedDayFather!.padLeft(2, '0')}';
                        String birthdateMother = '$selectedYearMother-${selectedMonthMother!.padLeft(2, '0')}-${selectedDayMother!.padLeft(2, '0')}';

                        // Save data to store
                        enrollmentStore.setStep4Data(
                          lastNameFather: lastNameFatherCont.text,
                          firstNameFather: firstNameFatherCont.text,
                          birthdateFather: birthdateFather,
                          birthplaceFather: birthplaceFatherCont.text,
                          lastNameMother: lastNameMotherCont.text,
                          firstNameMother: firstNameMotherCont.text,
                          birthdateMother: birthdateMother,
                          birthplaceMother: birthplaceMotherCont.text,
                        );

                        // Move to next step
                        enrollmentStore.nextStep();
                      },
                      elevation: 0.0,
                      color: AppColors.primary,
                      child: Text('Suivant',
                          style: boldTextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}