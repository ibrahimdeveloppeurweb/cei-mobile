// import 'package:cei_mobile/common_widgets/app_logo.dart';
// import 'package:cei_mobile/common_widgets/indicator_dot.dart';
// import 'package:cei_mobile/core/constants/assets_constants.dart';
// import 'package:cei_mobile/core/theme/app_colors.dart';
// import 'package:cei_mobile/core/theme/app_text_styles.dart';
// import 'package:cei_mobile/core/utils/common.dart' show citiesAndCommunes;
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
//
// class EnrollmentModal {
//   // Show the enrollment modal
//   static Future<void> showEnrollmentModal(BuildContext context) async {
//     // Controllers for Step 1
//     final lastNameCont = TextEditingController();
//     final firstNameCont = TextEditingController();
//     final quarterCont = TextEditingController();
//     String? selectedGender;
//     String? selectedCity;
//     String? selectedCommune;
//     String? selectedDay;
//     String? selectedMonth;
//     String? selectedYear;
//
//     // Controllers for other steps would be defined here
//
//     // Enrollment data model to store data across steps
//     final enrollmentData = EnrollmentData();
//
//     // Create pageController for WoltModalSheet
//     WoltModalController controller = WoltModalController();
//
//     final theme = Theme.of(context);
//     final modalConfig = WoltModalSheetConfig(
//       pageViewPhysics: const AlwaysScrollableScrollPhysics(),
//       isRoundedTop: true,
//       barrierDismissible: true,
//       maxPageWidth: 640,
//       pinDragToMaxHeight: true,
//       minPageHeight: 0.5,
//       maxPageHeight: 0.95,
//     );
//
//     final modalPages = [
//       // Step 1: Personal Information Page
//       createPersonalInfoPage(
//         context: context,
//         lastNameCont: lastNameCont,
//         firstNameCont: firstNameCont,
//         quarterCont: quarterCont,
//         onGenderChanged: (value) => selectedGender = value,
//         onCityChanged: (value) => selectedCity = value,
//         onCommuneChanged: (value) => selectedCommune = value,
//         onDayChanged: (value) => selectedDay = value,
//         onMonthChanged: (value) => selectedMonth = value,
//         onYearChanged: (value) => selectedYear = value,
//         onNext: () {
//           // Save data from step 1
//           enrollmentData.lastName = lastNameCont.text;
//           enrollmentData.firstName = firstNameCont.text;
//           enrollmentData.gender = selectedGender;
//           enrollmentData.birthDate =
//           '$selectedYear-${selectedMonth?.padLeft(2, '0')}-${selectedDay
//               ?.padLeft(2, '0')}';
//           enrollmentData.birthCity = selectedCity;
//           enrollmentData.birthCommune = selectedCommune;
//           enrollmentData.birthQuarter = quarterCont.text;
//
//           // Validate fields
//           if (enrollmentData.lastName.isEmpty) {
//             toast('Veuillez saisir votre nom');
//             return;
//           }
//           if (enrollmentData.firstName.isEmpty) {
//             toast('Veuillez saisir votre prénom');
//             return;
//           }
//           if (enrollmentData.gender == null) {
//             toast('Veuillez sélectionner votre genre');
//             return;
//           }
//           if (selectedYear == null || selectedMonth == null ||
//               selectedDay == null) {
//             toast('Veuillez sélectionner votre date de naissance complète');
//             return;
//           }
//           if (enrollmentData.birthCity == null) {
//             toast('Veuillez sélectionner votre ville de naissance');
//             return;
//           }
//
//           // Move to next step
//           controller.next();
//         },
//       ),
//
//       // Step 2: Registration Location
//       createRegistrationLocationPage(
//         context: context,
//         onPrevious: () => controller.previous(),
//         onNext: () => controller.next(),
//       ),
//
//       // Step 3: ID Photo
//       createIDPhotoPage(
//         context: context,
//         onPrevious: () => controller.previous(),
//         onNext: () => controller.next(),
//       ),
//
//       // Step 4: Document Upload
//       createDocumentUploadPage(
//         context: context,
//         onPrevious: () => controller.previous(),
//         onNext: () => controller.next(),
//       ),
//
//
//     ];
//
//     await WoltModalSheet.show(
//       context: context,
//       modalTypeBuilder: (_) =>
//           WoltModalType.bottomSheet(
//
//           ),
//       pageListBuilder: (context) => modalPages,
//       onModalDismissedWithBarrierTap: () {
//         Navigator.of(context).pop();
//       },
//     );
//   }
//
//   // Step 1: Personal Information Page
//   static WoltModalSheetPage createPersonalInfoPage({
//     required BuildContext context,
//     required TextEditingController lastNameCont,
//     required TextEditingController firstNameCont,
//     required TextEditingController quarterCont,
//     required Function(String?) onGenderChanged,
//     required Function(String?) onCityChanged,
//     required Function(String?) onCommuneChanged,
//     required Function(String?) onDayChanged,
//     required Function(String?) onMonthChanged,
//     required Function(String?) onYearChanged,
//     required VoidCallback onNext,
//   }) {
//     String? selectedGender;
//     String? selectedCity;
//     String? selectedCommune;
//     String? selectedDay;
//     String? selectedMonth;
//     String? selectedYear;
//
//     // Cities and communes data
//     List<String> cities = citiesAndCommunes.keys.toList();
//     List<String> communes = selectedCity != null
//         ? citiesAndCommunes[selectedCity] ?? []
//         : [];
//
//     return WoltModalSheetPage(
//       child: StatefulBuilder(
//           builder: (context, setState) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.close),
//                             onPressed: () => Navigator.pop(context),
//                           ),
//                           Text('Je m\'enrôle',
//                               style: boldTextStyle(size: 18)
//                           ),
//                           const SizedBox(width: 40),
//                         ],
//                       ),
//                       16.height,
//                       IndicatorDot(
//                         currentPage: 0,
//                         totalItems: 5,
//                         selectedDotWidth: 45,
//                         unselectedDotWidth: 45,
//                       ),
//                       30.height,
//                       Text("Informations",
//                           style: boldTextStyle(
//                               size: 36, letterSpacing: 2, color: Colors.black)),
//                       Text("Personnelles",
//                           style: boldTextStyle(
//                             size: 36,
//                             letterSpacing: 2,
//                             color: Colors.black,
//                           )),
//                     ],
//                   ),
//                 ),
//
//                 // Form Fields
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('Nom', style: AppTextStyles.body2),
//                         AppTextField(
//                           controller: lastNameCont,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                           ),
//                           textFieldType: TextFieldType.NAME,
//                         ),
//                         16.height,
//                         const Text('Prénom(s)', style: AppTextStyles.body2),
//                         AppTextField(
//                           controller: firstNameCont,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                           ),
//                           textFieldType: TextFieldType.NAME,
//                         ),
//                         16.height,
//                         const Text('Genre', style: AppTextStyles.body2),
//                         DropdownButtonFormField<String>(
//                           value: selectedGender,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                           ),
//                           items: ['M', 'F']
//                               .map((gender) =>
//                               DropdownMenuItem<String>(
//                                 value: gender,
//                                 child: Text(gender),
//                               ))
//                               .toList(),
//                           onChanged: (value) {
//                             setState(() {
//                               selectedGender = value;
//                               onGenderChanged(value);
//                             });
//                           },
//                         ),
//                         16.height,
//                         const Text(
//                             'Date de naissance', style: AppTextStyles.body2),
//                         4.height,
//                         Row(
//                           children: [
//                             Expanded(
//                               child: DropdownButtonFormField<String>(
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 hint: const Text('- Jour -'),
//                                 value: selectedDay,
//                                 items: List.generate(31, (index) => index + 1)
//                                     .map((day) =>
//                                     DropdownMenuItem(
//                                       value: day.toString(),
//                                       child: Text(day.toString()),
//                                     ))
//                                     .toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedDay = value;
//                                     onDayChanged(value);
//                                   });
//                                 },
//                               ),
//                             ),
//                             4.width,
//                             Expanded(
//                               child: DropdownButtonFormField<String>(
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 hint: const Text('- Mois -'),
//                                 value: selectedMonth,
//                                 items: List.generate(12, (index) => index + 1)
//                                     .map((month) =>
//                                     DropdownMenuItem(
//                                       value: month.toString(),
//                                       child: Text(month.toString()),
//                                     ))
//                                     .toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedMonth = value;
//                                     onMonthChanged(value);
//                                   });
//                                 },
//                               ),
//                             ),
//                             4.width,
//                             Expanded(
//                               child: DropdownButtonFormField<String>(
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 hint: const Text('- Année -'),
//                                 value: selectedYear,
//                                 items: List.generate(
//                                     100, (index) => 2025 - index)
//                                     .map((year) =>
//                                     DropdownMenuItem(
//                                       value: year.toString(),
//                                       child: Text(year.toString()),
//                                     ))
//                                     .toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     selectedYear = value;
//                                     onYearChanged(value);
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         16.height,
//                         const Text(
//                             'Ville de naissance', style: AppTextStyles.body2),
//                         DropdownSearch<String>(
//                           items: (f, cs) => cities,
//                           selectedItem: selectedCity,
//                           compareFn: (item1, item2) => item1 == item2,
//                           popupProps: PopupProps.menu(
//                             showSearchBox: true,
//                             showSelectedItems: true,
//                             searchFieldProps: const TextFieldProps(
//                               decoration: InputDecoration(
//                                 hintText: "Rechercher...",
//                                 contentPadding: EdgeInsets.symmetric(
//                                     vertical: 8, horizontal: 12),
//                               ),
//                             ),
//                             searchDelay: const Duration(milliseconds: 0),
//                             itemBuilder: (context, item, _, isSelected) {
//                               return Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16, vertical: 12),
//                                 child: Text(
//                                   item,
//                                   style: TextStyle(
//                                     fontWeight: isSelected
//                                         ? FontWeight.bold
//                                         : FontWeight.normal,
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                           filterFn: (item, filter) {
//                             return item.toLowerCase().contains(
//                                 filter.toLowerCase());
//                           },
//                           validator: (value) {
//                             if (value == null)
//                               return "Le type est requis";
//                             return null;
//                           },
//                           onChanged: (value) {
//                             setState(() {
//                               selectedCity = value;
//                               selectedCommune = null;
//                               onCityChanged(value);
//                             });
//                           },
//                         ),
//                         16.height,
//                         const Text(
//                             'Commune de naissance', style: AppTextStyles.body2),
//                         DropdownButtonFormField<String>(
//                           value: selectedCommune,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: 'Sélectionnez une commune',
//                           ),
//                           items: (selectedCity != null
//                               ? citiesAndCommunes[selectedCity] ?? []
//                               : [])
//                               .map((commune) =>
//                               DropdownMenuItem<String>(
//                                 value: commune,
//                                 child: Text(commune),
//                               ))
//                               .toList(),
//                           onChanged: selectedCity == null
//                               ? null
//                               : (value) {
//                             setState(() {
//                               selectedCommune = value;
//                               onCommuneChanged(value);
//                             });
//                           },
//                         ),
//                         16.height,
//                         const Text('Quartier de naissance',
//                             style: AppTextStyles.body2),
//                         AppTextField(
//                           controller: quarterCont,
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             hintText: 'Entrez votre quartier',
//                           ),
//                           textFieldType: TextFieldType.NAME,
//                         ),
//                         30.height,
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Footer Button
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   child: AppButton(
//                     width: context.width(),
//                     shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
//                     onTap: onNext,
//                     elevation: 0.0,
//                     color: AppColors.primary,
//                     child: Text(
//                         'Suivant', style: boldTextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ],
//             );
//           }
//       ),
//     );
//   }
//
//   // Step 2: Registration Location Page
//   static WoltModalSheetPage createRegistrationLocationPage({
//     required BuildContext context,
//     required VoidCallback onPrevious,
//     required VoidCallback onNext,
//   }) {
//     return WoltModalSheetPage(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     Text('Je m\'enrôle',
//                         style: boldTextStyle(size: 18)
//                     ),
//                     const SizedBox(width: 40),
//                   ],
//                 ),
//                 16.height,
//                 IndicatorDot(
//                   currentPage: 1,
//                   totalItems: 5,
//                   selectedDotWidth: 45,
//                   unselectedDotWidth: 45,
//                 ),
//                 30.height,
//                 Text("Données",
//                     style: boldTextStyle(
//                         size: 36, letterSpacing: 2, color: Colors.black)),
//                 Text("d'inscription",
//                     style: boldTextStyle(
//                       size: 36,
//                       letterSpacing: 2,
//                       color: Colors.black,
//                     )),
//               ],
//             ),
//           ),
//
//           // Form Fields
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Add fields for:
//                   // - Country
//                   // - Registration center
//                   const Text('Pays', style: AppTextStyles.body2),
//                   DropdownButtonFormField<String>(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                     ),
//                     value: 'Côte d\'Ivoire',
//                     items: ['Côte d\'Ivoire']
//                         .map((country) =>
//                         DropdownMenuItem<String>(
//                           value: country,
//                           child: Text(country),
//                         ))
//                         .toList(),
//                     onChanged: (value) {},
//                   ),
//                   16.height,
//
//                   const Text(
//                       'Centre d\'enrôlement', style: AppTextStyles.body2),
//                   DropdownButtonFormField<String>(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Sélectionnez un centre',
//                     ),
//                     items: ['Centre 1', 'Centre 2', 'Centre 3']
//                         .map((center) =>
//                         DropdownMenuItem<String>(
//                           value: center,
//                           child: Text(center),
//                         ))
//                         .toList(),
//                     onChanged: (value) {},
//                   ),
//                   30.height,
//                 ],
//               ),
//             ),
//           ),
//
//           // Footer Buttons
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: AppButton(
//                     shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
//                     onTap: onPrevious,
//                     elevation: 0.0,
//                     color: Colors.grey.shade200,
//                     child: Text(
//                         'Précédent', style: boldTextStyle(color: Colors.black)),
//                   ),
//                 ),
//                 16.width,
//                 Expanded(
//                   child: AppButton(
//                     shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
//                     onTap: onNext,
//                     elevation: 0.0,
//                     color: AppColors.primary,
//                     child: Text(
//                         'Suivant', style: boldTextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Step 3: ID Photo Page
//   static WoltModalSheetPage createIDPhotoPage({
//     required BuildContext context,
//     required VoidCallback onPrevious,
//     required VoidCallback onNext,
//   }) {
//     return WoltModalSheetPage(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     Text('Je m\'enrôle',
//                         style: boldTextStyle(size: 18)
//                     ),
//                     const SizedBox(width: 40),
//                   ],
//                 ),
//                 16.height,
//                 IndicatorDot(
//                   currentPage: 2,
//                   totalItems: 5,
//                   selectedDotWidth: 45,
//                   unselectedDotWidth: 45,
//                 ),
//                 30.height,
//                 Text("Photo",
//                     style: boldTextStyle(
//                         size: 36, letterSpacing: 2, color: Colors.black)),
//                 Text("d'identité",
//                     style: boldTextStyle(
//                       size: 36,
//                       letterSpacing: 2,
//                       color: Colors.black,
//                     )),
//               ],
//             ),
//           ),
//
//           // Form Fields
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Photo upload area
//                   Container(
//                     height: 200,
//                     width: context.width(),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                             Icons.camera_alt, size: 48, color: Colors.grey),
//                         16.height,
//                         Text('Prendre une photo', style: primaryTextStyle()),
//                         8.height,
//                         Text('(selon position simple)',
//                             style: secondaryTextStyle()),
//                       ],
//                     ),
//                   ),
//                   30.height,
//                 ],
//               ),
//             ),
//           ),
//
//           // Footer Buttons
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: AppButton(
//                     shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
//                     onTap: onPrevious,
//                     elevation: 0.0,
//                     color: Colors.grey.shade200,
//                     child: Text(
//                         'Précédent', style: boldTextStyle(color: Colors.black)),
//                   ),
//                 ),
//                 16.width,
//                 Expanded(
//                   child: AppButton(
//                     shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
//                     onTap: onNext,
//                     elevation: 0.0,
//                     color: AppColors.primary,
//                     child: Text(
//                         'Suivant', style: boldTextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Step 4: Document Upload Page
//   static WoltModalSheetPage createDocumentUploadPage({
//     required BuildContext context,
//     required VoidCallback onPrevious,
//     required VoidCallback onNext,
//   }) {
//     return WoltModalSheetPage(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.close),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     Text('Je m\'enrôle',
//                         style: boldTextStyle(size: 18)
//                     ),
//                     const SizedBox(width: 40),
//                   ],
//                 ),
//                 16.height,
//                 IndicatorDot(
//                   currentPage: 3,
//                   totalItems: 5,
//                   selectedDotWidth: 45,
//                   unselectedDotWidth: 45,
//                 ),
//                 30.height,
//                 Text("Pièces",
//                     style: boldTextStyle(
//                         size: 36, letterSpacing: 2, color: Colors.black)),
//                 Text("d'identité",
//                     style: boldTextStyle(
//                       size: 36,
//                       letterSpacing: 2,
//                       color: Colors.black,
//                     )),
//               ],
//             ),
//           ),
//
//           // Form Fields
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Document type selection
//                   const Text('Type de pièce', style: AppTextStyles.body2),
//                   DropdownButtonFormField<String>(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                     ),
//                     items: [
//                       'Carte Nationale d\'Identité',
//                       'Passeport',
//                       'Permis de conduire'
//                     ]
//                         .map((type) =>
//                         DropdownMenuItem<String>(
//                           value: type,
//                           child: Text(type),
//                         ))
//                         .toList(),
//                     onChanged: (value) {},
//                   ),
//                   16.height,
//
//                   // Document number
//                   const Text('Numéro de la pièce', style: AppTextStyles.body2),
//                   AppTextField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                     ),
//                     textFieldType: TextFieldType.NAME,
//                   ),
//                   16.height,
//
//                   // Document front and back
//                   const Text(
//                       'Photo de la pièce (Recto)', style: AppTextStyles.body2),
//                   Container(
//                     height: 100,
//                     width: context.width(),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                             Icons.camera_alt, size: 32, color: Colors.grey),
//                         8.height,
//                         Text('Ajouter photo recto',
//                             style: primaryTextStyle(size: 14)),
//                       ],
//                     ),
//                   ),
//                   16.height,
//
//                   const Text(
//                       'Photo de la pièce (Verso)', style: AppTextStyles.body2),
//                   Container(
//                     height: 100,
//                     width: context.width(),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(
//                             Icons.camera_alt, size: 32, color: Colors.grey),
//                         8.height,
//                         Text('Ajouter photo verso',
//                             style: primaryTextStyle(size: 14)),
//                       ],
//                     ),
//                   ),
//                   30.height,
//                 ],
//               ),
//             ),
//           ),
//
//           // Footer Buttons
//           Container(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: AppButton(
//                     shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
//                     onTap: onPrevious,
//                     elevation: 0.0,
//                     color: Colors.grey.shade200,
//                     child: Text(
//                         'Précédent', style: boldTextStyle(color: Colors.black)),
//                   ),
//                 ),
//                 16.width,
//                 Expanded(
//                   child: AppButton(
//                     shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
//                     onTap: onNext,
//                     elevation: 0.0,
//                     color: AppColors.primary,
//                     child: Text(
//                         'Suivant', style: boldTextStyle(color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }