import 'package:cei_mobile/common_widgets/indicator_dot.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/core/utils/common.dart' show citiesAndCommunes;
import 'package:cei_mobile/main.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class IdentityStep3ScanCustomerScreen extends StatefulWidget {
  const IdentityStep3ScanCustomerScreen({super.key});

  @override
  State<IdentityStep3ScanCustomerScreen> createState() => _IdentityStep3ScanCustomerScreenState();
}

class _IdentityStep3ScanCustomerScreenState extends State<IdentityStep3ScanCustomerScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController lastNameCont;
  late TextEditingController firstNameCont;
  late TextEditingController birthplaceCont;
  late TextEditingController quarterCont;

  String? selectedGender;
  String? selectedCity;
  String? selectedCommune;

  // Date of birth selection
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;

  FocusNode lastNameFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode birthplaceFocus = FocusNode();
  FocusNode quarterFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data or extract from ID document
    lastNameCont = TextEditingController(
        text: scanCustomerStore.lastName
    );

    firstNameCont = TextEditingController(
        text: scanCustomerStore.firstName
    );

    birthplaceCont = TextEditingController(text: scanCustomerStore.dob);
    quarterCont = TextEditingController(text: scanCustomerStore.quarter);

    // Set gender from document if available
    selectedGender = scanCustomerStore.gender ;
    selectedCity = scanCustomerStore.city;
    selectedCommune = scanCustomerStore.commune;

    // Parse birth date if available
    if(scanCustomerStore.dob.isNotEmpty){
      try {
        final parts = scanCustomerStore.dob.split('/');
        if (parts.length == 3) {
          selectedDay = int.tryParse(parts[0])?.toString() ?? '';
          selectedMonth = int.tryParse(parts[1])?.toString() ?? '';
          selectedYear = parts[2];
        }
      } catch (e) {
        print('Error parsing birthdate: $e');
      }
    }
  }

  List<String> get cities => citiesAndCommunes.keys.toList();
  List<String> get communes => selectedCity != null
      ? citiesAndCommunes[selectedCity] ?? []
      : [];

  @override
  void dispose() {
    lastNameCont.dispose();
    firstNameCont.dispose();
    birthplaceCont.dispose();
    quarterCont.dispose();
    lastNameFocus.dispose();
    firstNameFocus.dispose();
    birthplaceFocus.dispose();
    quarterFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IndicatorDot(
                      currentPage: 2,
                      totalItems: 6,
                      selectedDotWidth: 45,
                      unselectedDotWidth: 45,
                    ),
                    30.height,
                    Text("État civil ",
                        style: boldTextStyle(
                          size: 36, letterSpacing: 2, )),

                    50.height,
                    const Text(
                      'Nom',
                      style: AppTextStyles.body2,
                    ),
                    AppTextField(
                      controller: lastNameCont,
                      focus: lastNameFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => firstNameFocus.requestFocus(),
                      decoration: const InputDecoration(
                        enabled: false,
                        border: OutlineInputBorder(),
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                    16.height,
                    const Text(
                      'Prénom(s)',
                      style: AppTextStyles.body2,
                    ),
                    AppTextField(
                      controller: firstNameCont,
                      focus: firstNameFocus,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        enabled: false,
                        border: OutlineInputBorder(),
                      ),
                      textFieldType: TextFieldType.NAME,
                    ),
                    16.height,
                    const Text(
                      'Genre',
                      style: AppTextStyles.body2,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      decoration: const InputDecoration(
                        enabled: false,
                        border: OutlineInputBorder(),
                      ),
                      items: ['M', 'F']
                          .map((gender) => DropdownMenuItem<String>(
                        value: gender,
                        enabled: false,
                        child: Text(gender),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                    16.height,
                    const Text(
                      'Date de naissance',
                      style: AppTextStyles.body2,
                    ),
                    4.height,
                    // Fixed the overflow issue by using Flexible instead of Expanded
                    // and reducing spacing between dropdowns
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              enabled: false,
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            ),
                            hint: const Text('- Jour -', style: TextStyle(fontSize: 12)),
                            value: selectedDay,
                            items: List.generate(31, (index) => index + 1)
                                .map((day) => DropdownMenuItem(
                              enabled: false,
                              value: day.toString(),
                              child: Text(day.toString(), style: const TextStyle(fontSize: 12)),
                            ))
                                .toList(),
                            onChanged: null,
                            enableFeedback: false,
                          ),
                        ),
                        2.width, // Reduced spacing
                        Flexible(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              enabled: false,
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            ),
                            hint: const Text('- Mois -', style: TextStyle(fontSize: 12)),
                            value: selectedMonth,
                            items: List.generate(12, (index) => index + 1)
                                .map((month) => DropdownMenuItem(
                              enabled: false,
                              value: month.toString(),
                              child: Text(month.toString(), style: const TextStyle(fontSize: 12)),
                            ))
                                .toList(),
                            onChanged: null,
                          ),
                        ),
                        2.width, // Reduced spacing
                        Flexible(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              enabled: false,
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            ),
                            hint: const Text('- Année -', style: TextStyle(fontSize: 12)),
                            value: selectedYear,
                            items: List.generate(100, (index) => 2007 - index)
                                .map((year) => DropdownMenuItem(
                              enabled: false,
                              value: year.toString(),
                              child: Text(year.toString(), style: const TextStyle(fontSize: 12)),
                            ))
                                .toList(),
                            onChanged: null,
                          ),
                        ),
                      ],
                    ),
                    16.height,
                    const Text(
                      'Ville de naissance',
                      style: AppTextStyles.body2,
                    ),
                    DropdownSearch<String>(
                      items:(f,n)=> cities,
                      selectedItem: selectedCity,
                      compareFn: (item1, item2) => item1 == item2,
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                        searchFieldProps: const TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Rechercher...",
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          ),
                        ),
                        searchDelay: const Duration(milliseconds: 0),
                        itemBuilder: (context, item, _,isSelected) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Text(
                              item,
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                      filterFn: (item, filter) {
                        return item.toLowerCase().contains(filter.toLowerCase());
                      },
                      validator: (value) {
                        if (value == null)
                          return "Le type est requis";
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedCity = value;
                          selectedCommune = null; // Reset commune when city changes
                        });
                      },
                    ),
                    16.height,
                    const Text(
                      'Commune de naissance',
                      style: AppTextStyles.body2,
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedCommune,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Sélectionnez une commune',
                      ),
                      items: communes
                          .map((commune) => DropdownMenuItem<String>(
                        value: commune,
                        child: Text(commune),
                      ))
                          .toList(),
                      onChanged: selectedCity == null
                          ? null
                          : (value) {
                        setState(() {
                          selectedCommune = value;
                        });
                      },
                    ),
                    // 16.height,
                    // const Text(
                    //   'Quartier de naissance',
                    //   style: AppTextStyles.body2,
                    // ),
                    // AppTextField(
                    //   controller: quarterCont,
                    //   focus: quarterFocus,
                    //   textInputAction: TextInputAction.done,
                    //   decoration: const InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     hintText: 'Entrez votre quartier',
                    //   ),
                    //   textFieldType: TextFieldType.NAME,
                    // ),
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
                        scanCustomerStore.previousStep();
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
                        // Format birth date as yyyy-MM-dd if all parts are selected
                        String? birthDate;
                        if (selectedYear != null && selectedMonth != null && selectedDay != null) {
                          birthDate = '$selectedYear-${selectedMonth!.padLeft(2, '0')}-${selectedDay!.padLeft(2, '0')}';
                        }

                        // Validate form fields
                        // if (lastNameCont.text.isEmpty) {
                        //   toast('Veuillez saisir votre nom');
                        //   return;
                        // }
                        // if (firstNameCont.text.isEmpty) {
                        //   toast('Veuillez saisir votre prénom');
                        //   return;
                        // }
                        // if (selectedGender == null) {
                        //   toast('Veuillez sélectionner votre genre');
                        //   return;
                        // }
                        // if (birthDate == null) {
                        //   toast('Veuillez sélectionner votre date de naissance complète');
                        //   return;
                        // }
                        // if (selectedCity == null) {
                        //   toast('Veuillez sélectionner votre ville de naissance');
                        //   return;
                        // }
                        // if (quarterCont.text.isEmpty) {
                        //   toast('Veuillez saisir votre quartier de naissance');
                        //   return;
                        // }

                        scanCustomerStore.setStep3Data(
                          city: selectedCity,
                          commune: selectedCommune,
                          quarter: quarterCont.text.validate(),
                        );
                        scanCustomerStore.nextStep();
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