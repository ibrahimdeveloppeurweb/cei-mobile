import 'package:cei_mobile/common_widgets/floating_bottom_action_widget.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/screens/auth/country_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';

class OperationRetraitCompte extends StatefulWidget {
  const OperationRetraitCompte({super.key});

  @override
  State<OperationRetraitCompte> createState() => _OperationRetraitCompteState();
}

class _OperationRetraitCompteState extends State<OperationRetraitCompte> {
  // Controllers
  final PageController _pageController = PageController();
  final TextEditingController _nomCompletController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _motifPrincipalController = TextEditingController();
  final TextEditingController _motifComplementaireController = TextEditingController();

  // Keys
  final GlobalKey<ExpandableFabState> _key = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // State variables
  int _currentStep = 0;
  bool _compteSelected = false;
  String _destinationChoice = '';
  String _selectedOperateur = '';
  String selectedCode = '+225';
  String selectedFlag = '🇨🇮';
  String selectedCountry = 'Côte d\'Ivoire';

  // Currency formatter
  final NumberFormat _currencyFormatter = NumberFormat.decimalPattern('fr_FR');

  // Liste des opérateurs disponibles
  final List<Map<String, String>> _operateurs = [
    {'name': 'Orange', 'code': 'ORANGE'},
    {'name': 'Wave', 'code': 'WAVE'},
    {'name': 'MTN', 'code': 'MTN'},
  ];

  @override
  void initState() {
    super.initState();
    _setupMontantController();
  }

  void _setupMontantController() {
    _montantController.addListener(() {
      final text = _montantController.text.replaceAll(' ', '');
      if (text.isNotEmpty && text != _montantController.text.replaceAll(' ', '')) {
        final value = double.tryParse(text);
        if (value != null) {
          final formatted = _currencyFormatter.format(value);
          final selection = _montantController.selection;
          _montantController.value = TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(
              offset: formatted.length,
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nomCompletController.dispose();
    _phoneController.dispose();
    _montantController.dispose();
    _motifPrincipalController.dispose();
    _motifComplementaireController.dispose();
    super.dispose();
  }

  // Validation methods
  bool _isStep1Valid() => _compteSelected;

  bool _isStep2Valid() {
    if (_destinationChoice.isEmpty) return false;
    if (_destinationChoice == 'autre_numero') {
      return _nomCompletController.text.trim().isNotEmpty &&
          _phoneController.text.trim().isNotEmpty &&
          _selectedOperateur.isNotEmpty;
    }
    return true;
  }

  bool _isStep3Valid() {
    final cleanAmount = _montantController.text.replaceAll(' ', '');
    return cleanAmount.isNotEmpty &&
        double.tryParse(cleanAmount) != null &&
        double.parse(cleanAmount) > 0;
  }

  bool _isCurrentStepValid() {
    switch (_currentStep) {
      case 0: return _isStep1Valid();
      case 1: return _isStep2Valid();
      case 2: return _isStep3Valid();
      case 3: return true;
      default: return false;
    }
  }

  // Calculation getters
  double get montantSaisi {
    final cleanAmount = _montantController.text.replaceAll(' ', '');
    return double.tryParse(cleanAmount) ?? 0.0;
  }

  double get fraisTransaction => 5.0;

  double get montantAPreleuer => montantSaisi + fraisTransaction;

  double get soldeApresVirement => 500.0 - montantAPreleuer;

  String get fullPhoneNumber => selectedCode + _phoneController.text.trim();

  String get formattedMontant => _currencyFormatter.format(montantSaisi);

  String get formattedFrais => _currencyFormatter.format(fraisTransaction);

  String get formattedMontantAPreleuer => _currencyFormatter.format(montantAPreleuer);

  // Navigation methods
  void _nextStep() {
    if (!_isCurrentStepValid()) return;

    if (_currentStep < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _openCountrySelection() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountrySelectionScreen(selectedCode: selectedCode),
      ),
    );

    if (result != null) {
      setState(() {
        selectedCode = result['code']!;
        selectedFlag = result['flag']!;
        selectedCountry = result['name']!;
      });
    }
  }

  void _showOperateurSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sélectionner l\'opérateur',
                style: AppTextStyles.bodyBold.copyWith(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              16.height,
              ..._operateurs.map((operateur) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedOperateur = operateur['code']!;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      operateur['name']!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
              16.height,
            ],
          ),
        );
      },
    );
  }

  VoidCallback? _getButtonAction() {
    if (!_isCurrentStepValid()) return null;

    if (_currentStep == 3) {
      return _confirmTransaction;
    } else {
      return _nextStep;
    }
  }

  void _confirmTransaction() {
    print('=== RÉCAPITULATIF DE LA TRANSACTION ===');
    print('Compte sélectionné: $_compteSelected');
    print('Destination: $_destinationChoice');
    if (_destinationChoice == 'autre_numero') {
      print('Nom complet: ${_nomCompletController.text}');
      print('Téléphone: $fullPhoneNumber');
      print('Opérateur: $_selectedOperateur');
    }
    print('Montant: ${montantSaisi.toInt()} XOF');
    print('Frais: ${fraisTransaction.toInt()} XOF');
    print('Montant à prélever: ${montantAPreleuer.toInt()} XOF');
    print('Motif principal: ${_motifPrincipalController.text}');
    print('Motif complémentaire: ${_motifComplementaireController.text}');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transfert confirmé avec succès !'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        key: scaffoldKey,
        appBar: _buildAppBar(),
        body: Column(
          children: [
            _buildProgressBar(),
            _buildPageView(),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _currentStep > 0
            ? _previousStep
            : () => ContextExtensions(context).pop(),
      ),
      centerTitle: false,
      title: const Text("CREDIT FEF"),
    );
  }

  Widget _buildProgressBar() {
    return SizedBox(
      height: 4,
      child: LinearProgressIndicator(
        value: (_currentStep + 1) / 4,
        backgroundColor: Colors.grey.shade200,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }

  Widget _buildPageView() {
    return Expanded(
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentStep = index;
          });
        },
        children: [
          _buildCompteSelectionStep(),
          _buildDestinationStep(),
          _buildMontantStep(),
          _buildRecapitulatifStep(),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: AppButton(
        height: 56,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onTap: _getButtonAction(),
        elevation: 0.0,
        color: _isCurrentStepValid() ? AppColors.primary : Colors.grey.shade300,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Text(
              _currentStep == 3 ? 'Confirmer le transfert' : 'Continuer',
              style: TextStyle(
                color: _isCurrentStepValid() ? Colors.white : Colors.grey.shade500,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompteSelectionStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          32.height,
          Text(
            'Depuis quel compte ?',
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          32.height,
          Text(
            'M. IBRAHIM CISSE',
            style: AppTextStyles.body1.copyWith(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          16.height,
          _buildCompteCard(),
        ],
      ),
    );
  }

  Widget _buildCompteCard() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _compteSelected = !_compteSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _compteSelected ? Colors.blue.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _compteSelected ? AppColors.primary : Colors.grey.shade300,
            width: _compteSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.account_balance_wallet,
                size: 24,
                color: Colors.grey.shade600,
              ),
            ),
            16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Compte épargne',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  4.height,
                  Text(
                    '800XXXXXXXX1',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  4.height,
                  Text(
                    'Solde : 0 XOF',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (_compteSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            32.height,
            Text(
              'Vers quel numéro ?',
              style: AppTextStyles.bodyBold.copyWith(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            32.height,
            _buildDestinationOption('mon_numero', 'Mon numéro'),
            16.height,
            _buildDestinationOption('autre_numero', 'Autre numéro'),
            if (_destinationChoice == 'autre_numero') ...[
              32.height,
              _buildAutreNumeroForm(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationOption(String value, String label) {
    final isSelected = _destinationChoice == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _destinationChoice = value;
          if (value != 'autre_numero') {
            _selectedOperateur = '';
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            _buildRadioButton(isSelected),
            16.width,
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(bool isSelected) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey,
          width: 2,
        ),
        color: isSelected ? AppColors.primary : Colors.transparent,
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : null,
    );
  }

  Widget _buildAutreNumeroForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNomCompletField(),
          16.height,
          _buildPhoneField(),
          16.height,
          _buildOperateurField(),
        ],
      ),
    );
  }

  Widget _buildNomCompletField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nom complet',
          style: AppTextStyles.bodyBold.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        8.height,
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nomCompletController,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Nom complet',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
                onChanged: (value) => setState(() {}),
              ),
            ),
            8.width,
            Container(
              width: 40,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'N° de téléphone',
          style: AppTextStyles.bodyBold.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        8.height,
        Row(
          children: [
            _buildCountrySelector(),
            8.width,
            Expanded(
              child: AppTextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintText: 'Ex: 0100045621',
                  border: OutlineInputBorder(),
                ),
                textFieldType: TextFieldType.NUMBER,
                errorThisFieldRequired: "Saisir le numéro de téléphone",
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {}),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCountrySelector() {
    return GestureDetector(
      onTap: _openCountrySelection,
      child: Container(
        width: 100,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(selectedFlag, style: const TextStyle(fontSize: 16)),
                2.width,
                Text(selectedCode, style: boldTextStyle(size: 12)),
              ],
            ),
            const Icon(Icons.keyboard_arrow_down, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOperateurField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opérateur de monnaie électronique',
          style: AppTextStyles.bodyBold.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        8.height,
        GestureDetector(
          onTap: _showOperateurSelection,
          child: Container(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedOperateur.isEmpty
                    ? Colors.grey.shade400
                    : AppColors.primary,
                width: _selectedOperateur.isEmpty ? 1 : 2,
              ),
              borderRadius: BorderRadius.circular(8),
              color: _selectedOperateur.isEmpty
                  ? Colors.white
                  : Colors.blue.shade50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedOperateur.isEmpty
                      ? 'Sélectionner l\'opérateur'
                      : _operateurs.firstWhere(
                          (op) => op['code'] == _selectedOperateur,
                      orElse: () => {'name': _selectedOperateur}
                  )['name']!,
                  style: TextStyle(
                    color: _selectedOperateur.isEmpty
                        ? Colors.grey.shade600
                        : Colors.black,
                    fontSize: 16,
                    fontWeight: _selectedOperateur.isEmpty
                        ? FontWeight.normal
                        : FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: _selectedOperateur.isEmpty
                      ? Colors.grey.shade600
                      : AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMontantStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            32.height,
            Text(
              'Quel montant ?',
              style: AppTextStyles.bodyBold.copyWith(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            32.height,
            _buildMontantInput(),
            if (montantSaisi > 0) ...[
              32.height,
              _buildCalculationDetails(),
              24.height,
              _buildSoldeAfterTransfer(),
              24.height,
              _buildMotifFields(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMontantInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _montantController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: '500',
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onChanged: (value) => setState(() {}),
          ),
        ),
        16.width,
        const Text(
          'XOF',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCalculationDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Frais de transaction : ',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '$formattedFrais XOF',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          8.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Montant à prélever : ',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '$formattedMontantAPreleuer XOF',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSoldeAfterTransfer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Solde théorique après virement',
          style: AppTextStyles.bodyBold.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        16.height,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'IBRAHIM CISSE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${_currencyFormatter.format(soldeApresVirement)} ',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'XOF',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '800XXXXXXXX1',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMotifFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Motif principal de la transaction',
          style: AppTextStyles.bodyBold.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        8.height,
        TextField(
          controller: _motifPrincipalController,
          decoration: InputDecoration(
            hintText: 'Remboursement, anniversaire...',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        16.height,
        Text(
          'Motif complémentaire',
          style: AppTextStyles.bodyBold.copyWith(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        8.height,
        TextField(
          controller: _motifComplementaireController,
          decoration: InputDecoration(
            hintText: 'Référence de facture, coordonnées...',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildRecapitulatifStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            32.height,
            Text(
              'Récapitulatif',
              style: AppTextStyles.bodyBold.copyWith(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            32.height,
            _buildRecapCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecapCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade900,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildRecapHeader(),
          _buildRecapDetails(),
        ],
      ),
    );
  }

  Widget _buildRecapHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.swap_horiz,
              color: Colors.white,
              size: 20,
            ),
          ),
          16.width,
          Text(
            '$formattedMontant XOF',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecapDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Compte envoyeur', '0555568405', 'DEPOT'),
          16.height,
          Divider(color: Colors.grey.shade300),
          16.height,
          _buildDetailRow('Compte receveur', '800XXXXXXXX1', 'IBRAHIM CISSE'),
          if (_destinationChoice == 'autre_numero' && _selectedOperateur.isNotEmpty) ...[
            16.height,
            Divider(color: Colors.grey.shade300),
            16.height,
            _buildDetailRow('Opérateur',
                _operateurs.firstWhere(
                        (op) => op['code'] == _selectedOperateur,
                    orElse: () => {'name': _selectedOperateur}
                )['name']!,
                ''
            ),
          ],
          16.height,
          Divider(color: Colors.grey.shade300),
          16.height,
          _buildDetailRow(
              'Motif principal',
              _motifPrincipalController.text.isEmpty
                  ? 'Non spécifié'
                  : _motifPrincipalController.text,
              ''
          ),
          16.height,
          Divider(color: Colors.grey.shade300),
          16.height,
          _buildDetailRow(
              'Motif complémentaire',
              _motifComplementaireController.text.isEmpty
                  ? 'Non spécifié'
                  : _motifComplementaireController.text,
              ''
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, String subValue) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.right,
              ),
              if (subValue.isNotEmpty) ...[
                4.height,
                Text(
                  subValue,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}