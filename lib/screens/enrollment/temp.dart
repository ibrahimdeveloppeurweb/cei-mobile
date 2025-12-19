// import 'package:cei_mobile/common_widgets/indicator_dot.dart';
// import 'package:cei_mobile/core/routes/app_router.dart';
// import 'package:cei_mobile/core/theme/app_colors.dart';
// import 'package:cei_mobile/core/theme/app_text_styles.dart';
// import 'package:cei_mobile/main.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:dropdown_search/dropdown_search.dart';
//
// class EnrollmentStep6Screen extends StatefulWidget {
//   const EnrollmentStep6Screen({super.key});
//
//   @override
//   State<EnrollmentStep6Screen> createState() => _EnrollmentStep6ScreenState();
// }
//
// class _EnrollmentStep6ScreenState extends State<EnrollmentStep6Screen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _secondPhoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _professionController = TextEditingController();
//
//
//   // Sample countries
//   final List<String> countries = [
//     'Côte d\'Ivoire',
//     'Burkina Faso',
//     'Ghana',
//     'Mali',
//     'Sénégal',
//     'Guinée',
//     'Autres'
//   ];
//
//   // Map of cities and communes (same as in Step 5)
//   final Map<String, List<String>> citiesAndCommunes = {
//     'Abidjan': ['Abobo', 'Adjamé', 'Attécoubé', 'Cocody', 'Koumassi', 'Marcory', 'Plateau', 'Port-Bouët', 'Treichville', 'Yopougon'],
//     'Bouaké': ['Bouaké-Centre', 'Belleville', 'Dar-es-Salam', 'Koko'],
//     'Yamoussoukro': ['Yamoussoukro-Centre', 'Assabou', 'Morofé', 'N\'Zuessi'],
//     'San-Pedro': ['San-Pedro-Centre', 'Bardo', 'Séwéké', 'Zone Industrielle'],
//     'Daloa': ['Daloa-Centre', 'Gbokora', 'Lobia', 'Tazibouo'],
//   };
//
//   // Sample list of quarters
//   final Map<String, Map<String, List<String>>> quartersMap = {
//     'Abidjan': {
//       'Cocody': ['Angré', 'Deux Plateaux', 'Riviera', 'Ambassade', 'Palmeraie'],
//       'Yopougon': ['Ananeraie', 'Port Bouet 2', 'Niangon', 'Selmer', 'Maroc'],
//       'Plateau': ['Commerce', 'Cité Administrative', 'Rue des Banques', 'Indénié'],
//     },
//     'Bouaké': {
//       'Bouaké-Centre': ['Commerce', 'Air France', 'Koko', 'Belleville'],
//     },
//   };
//
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize with any existing data from the store
//     if (enrollmentStore.phoneNumber != null) {
//       _phoneController.text = enrollmentStore.phoneNumber!;
//     }
//     if (enrollmentStore.secondPhoneNumber != null) {
//       _secondPhoneController.text = enrollmentStore.secondPhoneNumber!;
//     }
//     if (enrollmentStore.email != null) {
//       _emailController.text = enrollmentStore.email!;
//     }
//     if (enrollmentStore.profession != null) {
//       _professionController.text = enrollmentStore.profession!;
//     }
//   }
//
//   @override
//   void dispose() {
//     _phoneController.dispose();
//     _secondPhoneController.dispose();
//     _emailController.dispose();
//     _professionController.dispose();
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
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       IndicatorDot(
//                         currentPage: 5,
//                         totalItems: 6,
//                         selectedDotWidth: 45,
//                         unselectedDotWidth: 45,
//                       ),
//                       30.height,
//                       Text("Coordonnées",
//                           style: boldTextStyle(
//                               size: 36, letterSpacing: 2, color: Colors.black)),
//                       Text("personnelles",
//                           style: boldTextStyle(
//                             size: 36,
//                             letterSpacing: 2,
//                             color: Colors.black,
//                           )),
//                       50.height,
//
//                       // Numéro de téléphone
//                       const Text(
//                         'Numéro de téléphone',
//                         style: AppTextStyles.body2,
//                       ),
//                       AppTextField(
//                         controller: _phoneController,
//                         textFieldType: TextFieldType.PHONE,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Ex: 0700000000',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Veuillez entrer votre numéro de téléphone';
//                           }
//                           return null;
//                         },
//                       ),
//                       16.height,
//
//                       // Second numéro de téléphone (optionnel)
//                       const Text(
//                         'Second numéro de téléphone (optionnel)',
//                         style: AppTextStyles.body2,
//                       ),
//                       AppTextField(
//                         controller: _secondPhoneController,
//                         textFieldType: TextFieldType.PHONE,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Ex: 0700000000',
//                         ),
//                       ),
//                       16.height,
//
//                       // Email
//                       const Text(
//                         'Email',
//                         style: AppTextStyles.body2,
//                       ),
//                       AppTextField(
//                         controller: _emailController,
//                         textFieldType: TextFieldType.EMAIL,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Ex: example@email.com',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Veuillez entrer votre adresse email';
//                           }
//                           if (!value.contains('@') || !value.contains('.')) {
//                             return 'Veuillez entrer une adresse email valide';
//                           }
//                           return null;
//                         },
//                       ),
//                       16.height,
//
//                       // Profession
//                       const Text(
//                         'Profession',
//                         style: AppTextStyles.body2,
//                       ),
//                       AppTextField(
//                         controller: _professionController,
//                         textFieldType: TextFieldType.NAME,
//                         decoration: const InputDecoration(
//                           border: OutlineInputBorder(),
//                           hintText: 'Ex: Entrepreneur',
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Veuillez entrer votre profession';
//                           }
//                           return null;
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: AppButton(
//                       shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
//                       onTap: () {
//                         enrollmentStore.previousStep();
//                       },
//                       elevation: 0.0,
//                       color: Colors.grey[300],
//                       child: Text('Précédent',
//                           style: boldTextStyle(color: Colors.black)),
//                     ),
//                   ),
//                   8.width,
//                   Expanded(
//                     child: AppButton(
//                       shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
//                       onTap: () {
//                         // Validate form
//                         if (_formKey.currentState!.validate()) {
//                           // Save data to store
//                           enrollmentStore.setStep6Data(
//                             phoneNumber: _phoneController.text,
//                             secondPhoneNumber: _secondPhoneController.text.isNotEmpty
//                                 ? _secondPhoneController.text
//                                 : null,
//                             email: _emailController.text,
//                             profession: _professionController.text, domicileCountry: '',
//                           );
//                           enrollmentStore.nextStep();
//                         } else {
//                           toast('Veuillez remplir tous les champs obligatoires');
//                         }
//
//                       },
//                       elevation: 0.0,
//                       color: AppColors.primary,
//                       child: Text('Suivant',
//                           style: boldTextStyle(color: Colors.white)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }