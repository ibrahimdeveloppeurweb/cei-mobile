import 'package:cei_mobile/common_widgets/indicator_dot.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';

class IdentityStep5ScanCustomerScreen extends StatefulWidget {
  const IdentityStep5ScanCustomerScreen({super.key});

  @override
  State<IdentityStep5ScanCustomerScreen> createState() => _IdentityStep5ScanCustomerScreenState();
}

class _IdentityStep5ScanCustomerScreenState extends State<IdentityStep5ScanCustomerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _secondPhoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();


  // Sample countries
  final List<String> countries = [
    'Côte d\'Ivoire',
    'Burkina Faso',
    'Ghana',
    'Mali',
    'Sénégal',
    'Guinée',
    'Autres'
  ];

  // Map of cities and communes (same as in Step 5)
  final Map<String, List<String>> citiesAndCommunes = {
    'Abidjan': ['Abobo', 'Adjamé', 'Attécoubé', 'Cocody', 'Koumassi', 'Marcory', 'Plateau', 'Port-Bouët', 'Treichville', 'Yopougon'],
    'Bouaké': ['Bouaké-Centre', 'Belleville', 'Dar-es-Salam', 'Koko'],
    'Yamoussoukro': ['Yamoussoukro-Centre', 'Assabou', 'Morofé', 'N\'Zuessi'],
    'San-Pedro': ['San-Pedro-Centre', 'Bardo', 'Séwéké', 'Zone Industrielle'],
    'Daloa': ['Daloa-Centre', 'Gbokora', 'Lobia', 'Tazibouo'],
  };

  // Sample list of quarters
  final Map<String, Map<String, List<String>>> quartersMap = {
    'Abidjan': {
      'Cocody': ['Angré', 'Deux Plateaux', 'Riviera', 'Ambassade', 'Palmeraie'],
      'Yopougon': ['Ananeraie', 'Port Bouet 2', 'Niangon', 'Selmer', 'Maroc'],
      'Plateau': ['Commerce', 'Cité Administrative', 'Rue des Banques', 'Indénié'],
    },
    'Bouaké': {
      'Bouaké-Centre': ['Commerce', 'Air France', 'Koko', 'Belleville'],
    },
  };


  @override
  void initState() {
    super.initState();
    // Initialize with any existing data from the store
    if (scanCustomerStore.phoneNumber != null) {
      _phoneController.text = scanCustomerStore.phoneNumber!;
    }
    if (scanCustomerStore.secondPhoneNumber != null) {
      _secondPhoneController.text = scanCustomerStore.secondPhoneNumber!;
    }
    if (scanCustomerStore.email != null) {
      _emailController.text = scanCustomerStore.email!;
    }
    if (scanCustomerStore.profession != null) {
      _professionController.text = scanCustomerStore.profession!;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _secondPhoneController.dispose();
    _emailController.dispose();
    _professionController.dispose();
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
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const IndicatorDot(
                        currentPage: 4,
                        totalItems: 6,
                        selectedDotWidth: 45,
                        unselectedDotWidth: 45,
                      ),
                      30.height,
                      Text("Personne",
                          style: boldTextStyle(
                              size: 36, letterSpacing: 2, color: Colors.black)),
                      Text("à contacter",
                          style: boldTextStyle(
                            size: 36,
                            letterSpacing: 2,
                            color: Colors.black,
                          )),
                      50.height,

                      // Profession
                      const Text(
                        'Nom & prénom',
                        style: AppTextStyles.body2,
                      ),
                      AppTextField(
                        controller: _professionController,
                        textFieldType: TextFieldType.NAME,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ex: Kone mariam',
                        ),
                        validator: (value) {
                          // if (value == null || value.isEmpty) {
                          //   return 'Veuillez entrer votre profession';
                          // }
                          return null;
                        },
                      ),
                      16.height,
                      // Numéro de téléphone
                      const Text(
                        'Numéro de téléphone',
                        style: AppTextStyles.body2,
                      ),
                      AppTextField(
                        controller: _phoneController,
                        textFieldType: TextFieldType.PHONE,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ex: 0700000000',
                        ),
                        validator: (value) {
                          // if (value == null || value.isEmpty) {
                          //   return 'Veuillez entrer votre numéro de téléphone';
                          // }
                          return null;
                        },
                      ),
                      16.height,

                      // Second numéro de téléphone (optionnel)
                      const Text(
                        'Second numéro de téléphone (optionnel)',
                        style: AppTextStyles.body2,
                      ),
                      AppTextField(
                        controller: _secondPhoneController,
                        textFieldType: TextFieldType.PHONE,
                        isValidationRequired: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ex: 0700000000',
                        ),
                      ),
                      16.height,

                      // Email
                      const Text(
                        'Email',
                        style: AppTextStyles.body2,
                      ),
                      AppTextField(
                        controller: _emailController,
                        textFieldType: TextFieldType.EMAIL,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ex: example@email.com',
                        ),
                        validator: (value) {
                          // if (value == null || value.isEmpty) {
                          //   return 'Veuillez entrer votre adresse email';
                          // }
                          // if (!value.contains('@') || !value.contains('.')) {
                          //   return 'Veuillez entrer une adresse email valide';
                          // }
                          return null;
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
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
                      shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                      onTap: () {
                        // Validate form
                        // if (_formKey.currentState!.validate()) {
                        //   // Save data to store
                        //   scanCustomerStore.setStep7Data(
                        //     phoneNumber: _phoneController.text,
                        //     secondPhoneNumber: _secondPhoneController.text.isNotEmpty
                        //         ? _secondPhoneController.text
                        //         : null,
                        //     email: _emailController.text,
                        //     profession: _professionController.text,
                        //   );
                        //   scanCustomerStore.nextStep();
                        // } else {
                        //   toast('Veuillez remplir tous les champs obligatoires');
                        // }
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