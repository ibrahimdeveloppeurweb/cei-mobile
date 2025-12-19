// // lib/features/enrollment/screens/enrollment_step5_screen.dart
//
// import 'package:cei_mobile/common_widgets/file_picker_widget.dart';
// import 'package:cei_mobile/common_widgets/indicator_dot.dart';
// import 'package:cei_mobile/core/theme/app_colors.dart';
// import 'package:cei_mobile/core/theme/app_text_styles.dart';
// import 'package:cei_mobile/core/utils/common.dart';
// import 'package:cei_mobile/main.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
//
// class EnrollmentStep5Screen extends StatefulWidget {
//   const EnrollmentStep5Screen({super.key});
//
//   @override
//   State<EnrollmentStep5Screen> createState() => _EnrollmentStep5ScreenState();
// }
//
// class _EnrollmentStep5ScreenState extends State<EnrollmentStep5Screen> {
//   GlobalKey<FormState> formKey = GlobalKey();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController quarterCont = TextEditingController();
//
//   String? selectedCity;
//   String? selectedCommune;
//   bool isCIEselected = false;
//   bool isSODECIselected = false;
//   final List<PlatformFile> _selectedFilesCIE = [];
//   final List<PlatformFile> _selectedFilesCertificat = [];
//
//   // Get communes based on selected city
//   List<String> get communes => selectedCity != null
//       ? citiesAndCommunes[selectedCity] ?? []
//       : [];
//
//   @override
//   void initState() {
//     super.initState();
//     _setDefaultValues();
//   }
//
//   void _setDefaultValues() {
//     // Set default values from enrollmentStore if they exist
//     final store = enrollmentStore;
//
//     setState(() {
//       selectedCity = store.addressCity;
//       selectedCommune = store.addressCommune;
//       quarterCont.text = store.addressQuarter ?? '';
//       addressController.text = store.address;
//       isCIEselected = store.isCIESelected;
//       isSODECIselected = store.isSODECISelected;
//
//       // Clear and re-add files from store (if any)
//       _selectedFilesCIE.clear();
//       _selectedFilesCertificat.clear();
//
//       if (store.step5FilesCIE.isNotEmpty) {
//         _selectedFilesCIE.addAll(store.step5FilesCIE);
//       }
//
//       if (store.step5FilesCertificat.isNotEmpty) {
//         _selectedFilesCertificat.addAll(store.step5FilesCertificat);
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     addressController.dispose();
//     quarterCont.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     IndicatorDot(
//                       currentPage: 4,
//                       totalItems: 6,
//                       selectedDotWidth: 45,
//                       unselectedDotWidth: 45,
//                     ),
//                     30.height,
//                     Text("Lieu de",
//                         style: boldTextStyle(
//                             size: 36, letterSpacing: 2, color: Colors.black)),
//                     Text("résidence",
//                         style: boldTextStyle(
//                           size: 36,
//                           letterSpacing: 2,
//                           color: Colors.black,
//                         )),
//                     50.height,
//
//                     // Ville
//                     const Text(
//                       'Ville de résidence',
//                       style: AppTextStyles.body2,
//                     ),
//                     DropdownSearch<String>(
//                       items: (f, cs) => citiesAndCommunes.keys.toList(),
//                       selectedItem: selectedCity,
//                       compareFn: (item1, item2) => item1 == item2,
//                       popupProps: PopupProps.menu(
//                         showSearchBox: true,
//                         showSelectedItems: true,
//                         searchFieldProps: const TextFieldProps(
//                           decoration: InputDecoration(
//                             hintText: "Rechercher...",
//                             contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                           ),
//                         ),
//                         searchDelay: const Duration(milliseconds: 0),
//                         itemBuilder: (context,item, _, isSelected) {
//                           return Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                             child: Text(
//                               item,
//                               style: TextStyle(
//                                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       filterFn: (item, filter) {
//                         return item.toLowerCase().contains(filter.toLowerCase());
//                       },
//                       validator: (value) {
//                         if (value == null)
//                           return "La ville est requise";
//                         return null;
//                       },
//                       onChanged: (value) {
//                         setState(() {
//                           selectedCity = value;
//                           selectedCommune = null; // Reset commune when city changes
//                         });
//                       },
//                     ),
//                     16.height,
//
//                     // Commune
//                     const Text(
//                       'Commune de résidence',
//                       style: AppTextStyles.body2,
//                     ),
//                     DropdownButtonFormField<String>(
//                       value: selectedCommune,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Sélectionnez une commune',
//                       ),
//                       items: communes
//                           .map((commune) => DropdownMenuItem<String>(
//                         value: commune,
//                         child: Text(commune),
//                       ))
//                           .toList(),
//                       onChanged: selectedCity == null
//                           ? null
//                           : (value) {
//                         setState(() {
//                           selectedCommune = value;
//                         });
//                       },
//                     ),
//                     16.height,
//
//                     // Quartier
//                     const Text(
//                       'Quartier de résidence',
//                       style: AppTextStyles.body2,
//                     ),
//
//                     AppTextField(
//                       controller: quarterCont,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Entrez votre quartier',
//                       ),
//                       textFieldType: TextFieldType.NAME,
//                     ),
//                     16.height,
//
//                     // Adresse précise
//                     const Text(
//                       'Adresse précise',
//                       style: AppTextStyles.body2,
//                     ),
//                     AppTextField(
//                       controller: addressController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Ex: Cité XXX, Lot 123, Immeuble Y, Appartement Z',
//                       ),
//                       textFieldType: TextFieldType.MULTILINE,
//                       minLines: 2,
//                       maxLines: 3,
//                     ),
//                     16.height,
//                     const Text(
//                       'Certificat de residence',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     FilePickerWidget(
//                       // Required parameters
//                       selectedFiles: _selectedFilesCertificat,
//                       onFilesSelected: (files) {
//                         setState(() {
//                           _selectedFilesCertificat.addAll(files);
//                           isSODECIselected = _selectedFilesCertificat.isNotEmpty;
//                         });
//                       },
//                       onFileRemoved: (file) {
//                         setState(() {
//                           _selectedFilesCertificat.remove(file);
//                           isSODECIselected = _selectedFilesCertificat.isNotEmpty;
//                         });
//                       },
//                       // Optional parameters
//                       buttonText: 'Sélectionner un ficher',
//                       infoText: '',
//                       allowedExtensions: const ['pdf', 'jpg', 'png'],
//                       maxFileSize: 5, // 5MB limit
//                       allowMultiple: true,
//                       showFilesList: true,
//                       filesListTitle: 'Certificat',
//                     ),
//                     16.height,
//                     const Text(
//                       'Facture CIE/SODECI',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     FilePickerWidget(
//                       // Required parameters
//                       selectedFiles: _selectedFilesCIE,
//                       onFilesSelected: (files) {
//                         setState(() {
//                           _selectedFilesCIE.addAll(files);
//                           isCIEselected = _selectedFilesCIE.isNotEmpty;
//                         });
//                       },
//                       onFileRemoved: (file) {
//                         setState(() {
//                           _selectedFilesCIE.remove(file);
//                           isCIEselected = _selectedFilesCIE.isNotEmpty;
//                         });
//                       },
//                       // Optional parameters
//                       buttonText: 'Sélectionner un ficher',
//                       infoText: '',
//                       allowedExtensions: const ['pdf', 'jpg', 'png'],
//                       maxFileSize: 5, // 5MB limit
//                       allowMultiple: true,
//                       showFilesList: true,
//                       filesListTitle: 'Facture',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             _buildNavigationButtons(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavigationButtons() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, -3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: AppButton(
//               shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               onTap: () {
//                 enrollmentStore.previousStep();
//               },
//               elevation: 0.0,
//               color: Colors.grey[300],
//               child: Text('Précédent',
//                   style: boldTextStyle(color: Colors.black)),
//             ),
//           ),
//           8.width,
//           Expanded(
//             child: AppButton(
//               shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               onTap: () {
//                 // Validate form fields
//                 if (selectedCity == null) {
//                   toast('Veuillez sélectionner une ville');
//                   return;
//                 }
//                 if (selectedCommune == null) {
//                   toast('Veuillez sélectionner une commune');
//                   return;
//                 }
//                 if (quarterCont.text.isEmpty) {
//                   toast('Veuillez entrer votre quartier');
//                   return;
//                 }
//                 if (addressController.text.isEmpty) {
//                   toast('Veuillez entrer votre adresse précise');
//                   return;
//                 }
//                 if (_selectedFilesCertificat.isEmpty) {
//                   toast('Veuillez sélectionner un fichier pour le certificat de résidence');
//                   return;
//                 }
//                 if (_selectedFilesCIE.isEmpty) {
//                   toast('Veuillez sélectionner un fichier pour la facture CIE/SODECI');
//                   return;
//                 }
//
//                 // Save data to store
//                 enrollmentStore.setStep5Data(
//                   address: addressController.text,
//                   city: selectedCity,
//                   commune: selectedCommune,
//                   quarter: quarterCont.text,
//                   isCIESelected: isCIEselected,
//                   isSODECISelected: isSODECIselected,
//                   filesCIE: _selectedFilesCIE,
//                   filesCertificat: _selectedFilesCertificat,
//                 );
//
//                 // Proceed to next step
//                 enrollmentStore.nextStep();
//               },
//               elevation: 0.0,
//               color: AppColors.primary,
//               child: Text('Suivant',
//                   style: boldTextStyle(color: Colors.white)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }