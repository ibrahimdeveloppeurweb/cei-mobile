import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/core/utils/common.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/repository/verification_repository.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchForm extends StatefulWidget {
  final String selectedType;
  final Function(bool personFound, EnrollmentData? user) onContinue;
  final VoidCallback onBack;

  const SearchForm({
    super.key,
    required this.selectedType,
    required this.onContinue,
    required this.onBack,
  });

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  int _currentSearchTab = 0;
  bool _searchLoading = false;
  bool _personFound = false;
  EnrollmentData? foundUser;

  final TextEditingController _formNumberController = TextEditingController();
  final TextEditingController _voterNumberController = TextEditingController();
  final TextEditingController _searchFamilyNameController = TextEditingController();
  final TextEditingController _searchFirstNameController = TextEditingController();
  String? _selectedDay;
  String? _selectedMonth;
  String? _selectedYear;

  @override
  void dispose() {
    _formNumberController.dispose();
    _voterNumberController.dispose();
    _searchFamilyNameController.dispose();
    _searchFirstNameController.dispose();
    super.dispose();
  }

  String get _getTitle {
    switch (widget.selectedType) {
      case 'Inscription':
        return 'Recherchez la personne à inscrire';
      case 'Radiation':
        return 'Recherchez la personne à radier';
      case 'Correction':
        return 'Recherchez la personne concernée';
      default:
        return 'Recherchez la personne';
    }
  }

  String get _getSubtitle {
    switch (widget.selectedType) {
      case 'Inscription':
        return 'Vérifiez d\'abord que la personne n\'est pas déjà sur la liste électorale.';
      case 'Radiation':
        return 'Trouvez la personne que vous souhaitez radier de la liste électorale.';
      case 'Correction':
        return 'Vérifiez les informations de la personne concernée par la correction.';
      default:
        return 'Veuillez rechercher la personne concernée.';
    }
  }

  String get _getInfoBannerText {
    switch (widget.selectedType) {
      case 'Inscription':
        return 'Si la personne n\'est pas trouvée, vous pourrez continuer avec la réclamation d\'inscription.';
      case 'Radiation':
        return 'Vous devez trouver la personne dans la liste électorale pour pouvoir demander sa radiation.';
      case 'Correction':
        return 'Vous devez trouver la personne dans la liste électorale pour pouvoir demander une correction.';
      default:
        return 'Veuillez rechercher la personne concernée.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _getTitle,
          style: AppTextStyles.h3,
        ),
        const SizedBox(height: 8),
        Text(
          _getSubtitle,
          style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),
        _buildInfoBanner(),
        20.height,
        _buildSearchTabs(),
        20.height,
        _buildSearchTabContent(),
        if (_personFound) ...[
          20.height,
          _buildPersonFoundCard(),
        ],
        20.height,
        _buildNavigationButtons(),
      ],
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppColors.primary),
          12.width,
          Expanded(
            child: Text(
              _getInfoBannerText,
              style: AppTextStyles.body2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTabs() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => setState(() => _currentSearchTab = 0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _currentSearchTab == 0
                        ? AppColors.primary
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'Rechercher par numéro de formulaire',
                style: TextStyle(
                  fontWeight: _currentSearchTab == 0 ? FontWeight.bold : FontWeight.normal,
                  color: _currentSearchTab == 0 ? AppColors.primary : Colors.black,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => setState(() => _currentSearchTab = 1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _currentSearchTab == 1
                        ? AppColors.primary
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'Rechercher par numéro d\'électeur',
                style: TextStyle(
                  fontWeight: _currentSearchTab == 1 ? FontWeight.bold : FontWeight.normal,
                  color: _currentSearchTab == 1 ? AppColors.primary : Colors.black,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () => setState(() => _currentSearchTab = 2),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _currentSearchTab == 2
                        ? AppColors.primary
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'Rechercher par nom et prénom',
                style: TextStyle(
                  fontWeight: _currentSearchTab == 2 ? FontWeight.bold : FontWeight.normal,
                  color: _currentSearchTab == 2 ? AppColors.primary : Colors.black,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchTabContent() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(16),
      child: _currentSearchTab == 0
          ? _buildFormNumberSearch()
          : _currentSearchTab == 1
          ? _buildVoterNumberSearch()
          : _buildNameSearch(),
    );
  }

  Widget _buildFormNumberSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('NUMÉRO FORMULAIRE 2025', style: primaryTextStyle(size: 12)),
        8.height,
        AppTextField(
          controller: _formNumberController,
          textFieldType: TextFieldType.NUMBER,
          maxLength: 10,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '0000000000',
          ),
        ),
        16.height,
        _searchLoading
            ? const Center(child: CircularProgressIndicator())
            : AppButton(
          width: 180,
          shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
          elevation: 0.0,
          color: AppColors.primary,
          onTap: _performFormNumberSearch,
          child: Text('Lancer la recherche', style: boldTextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildVoterNumberSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("NUMÉRO D'ÉLECTEUR", style: primaryTextStyle(size: 12)),
        8.height,
        AppTextField(
          controller: _voterNumberController,
          textFieldType: TextFieldType.NAME,
          inputFormatters: [VoterIDInputFormatter()],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'V 0000 0000 00',
          ),
        ),
        16.height,
        _searchLoading
            ? const Center(child: CircularProgressIndicator())
            : AppButton(
          width: 180,
          shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
          elevation: 0.0,
          color: AppColors.primary,
          onTap: _performVoterIdSearch,
          child: Text('Lancer la recherche', style: boldTextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildNameSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('NOM DE FAMILLE', style: primaryTextStyle(size: 12)),
        8.height,
        AppTextField(
          controller: _searchFamilyNameController,
          textFieldType: TextFieldType.NAME,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Nom de famille',
          ),
        ),
        16.height,
        Text('PRÉNOM(S)', style: primaryTextStyle(size: 12)),
        8.height,
        AppTextField(
          controller: _searchFirstNameController,
          textFieldType: TextFieldType.NAME,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Prénoms',
          ),
        ),
        16.height,
        Text('DATE DE NAISSANCE', style: primaryTextStyle(size: 12)),
        4.height,
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text('- Jour -'),
                value: _selectedDay,
                items: List.generate(31, (index) => index + 1)
                    .map((day) => DropdownMenuItem(
                  value: day.toString(),
                  child: Text(day.toString()),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedDay = value),
              ),
            ),
            4.width,
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text('- Mois -'),
                value: _selectedMonth,
                items: List.generate(12, (index) => index + 1)
                    .map((month) => DropdownMenuItem(
                  value: month.toString(),
                  child: Text(month.toString()),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedMonth = value),
              ),
            ),
            4.width,
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                hint: const Text('- Année -'),
                value: _selectedYear,
                items: List.generate(100, (index) => 2025 - index)
                    .map((year) => DropdownMenuItem(
                  value: year.toString(),
                  child: Text(year.toString()),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedYear = value),
              ),
            ),
          ],
        ),
        16.height,
        _searchLoading
            ? const Center(child: CircularProgressIndicator())
            : AppButton(
          width: 180,
          shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
          elevation: 0.0,
          color: AppColors.primary,
          onTap: _performNameSearch,
          child: Text('Lancer la recherche', style: boldTextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Widget _buildPersonFoundCard() {
    Color cardColor;
    Color borderColor;
    IconData iconData;
    Color iconColor;
    String statusText;

    if (widget.selectedType == 'Inscription') {
      cardColor = Colors.red.shade50;
      borderColor = Colors.red.shade300;
      iconData = Icons.warning_amber_outlined;
      iconColor = Colors.red;
      statusText = 'Personne trouvée sur la liste';
    }  else {
      cardColor = Colors.green.shade50;
      borderColor = Colors.green.shade300;
      iconData = Icons.check_circle_outline;
      iconColor = Colors.green;
      statusText = 'Personne trouvée';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                color: iconColor,
                size: 24,
              ),
              12.width,
              Text(
                statusText,
                style: AppTextStyles.body1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey2, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: foundUser!.photoIdentite == null
                      ? Image.asset(
                    'assets/images/profile_placeholder.png',
                    fit: BoxFit.cover,
                  )
                      : Image.network(
                    foundUser!.photoIdentite!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              16.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${foundUser!.firstName.validate()} ${foundUser!.lastName.validate()}',
                      style: boldTextStyle(size: 20),
                    ),
                    12.height,
                    _buildDetailRow('Date de naissance:', _getFormattedDateOfBirth()),
                    8.height,
                    _buildDetailRow('N° d\'ordre:', foundUser!.numOrder.validate()),
                    8.height,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('N° d\'électeur:', style: secondaryTextStyle(size: 14)),
                        4.width,
                        Text(
                          foundUser!.numEnregister.validate(),
                          style: boldTextStyle(size: 14),
                        ),
                      ],
                    ),
                    8.height,
                    _buildDetailRow('Genre:', foundUser!.gender.validate()),
                    8.height,
                    _buildDetailRow('Profession:', foundUser!.profession.validate()),
                    8.height,
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on, size: 18, color: AppColors.primary),
                          4.width,
                          Expanded(
                            child: Text(
                              _getPollingStationName(),
                              style: boldTextStyle(color: AppColors.primary, size: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: secondaryTextStyle(size: 14)),
        4.width,
        Expanded(
          child: Text(value, style: boldTextStyle(size: 14)),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back),
          label: const Text('Retour'),
        ),
        AppButton(
          shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
          elevation: 0.0,
          color: AppColors.primary,
          onTap: () {
            print(widget.selectedType );
            if (widget.selectedType == 'Inscription') {
              if (!_personFound) {
                widget.onContinue(false, null);
              } else {
                toast('Cette personne est déjà inscrite sur la liste électorale.');
              }
            } else if (widget.selectedType == 'Radiation') {
              if (_personFound) {
                widget.onContinue(true, foundUser);
              } else {
                toast('Vous devez d\'abord trouver la personne à radier.');
              }
            } else if (widget.selectedType == 'Correction') {
              if (_personFound) {
                widget.onContinue(true, foundUser);
              } else {
                toast('Vous devez d\'abord trouver la personne concernée.');
              }
            }
          },
          child: Text('Continuer', style: boldTextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _performFormNumberSearch() async {
    if (_formNumberController.text.isEmpty) {
      toast('Veuillez saisir un numéro de formulaire.');
      return;
    }

    setState(() => _searchLoading = true);

    try {
      final result = await verifyEnrolmentForm({
        'form': 'NUM_FORM',
        'formNumber': _formNumberController.text.trim(),
      });

      setState(() {
        _searchLoading = false;
        _personFound = true;
        foundUser = EnrollmentData.fromJson(result['data']);
      });
    } catch (e) {
      setState(() {
        _searchLoading = false;
        _personFound = false;
        foundUser = null;
      });
      _showSearchFailedDialog('$e');
    }
  }

  Future<void> _performVoterIdSearch() async {
    if (_voterNumberController.text.isEmpty) {
      toast('Veuillez saisir un numéro d\'électeur.');
      return;
    }

    setState(() => _searchLoading = true);

    try {
      final result = await verifyEnrolmentUniqId({
        'form': 'NUM_ELECTOR',
        'uniqueRegistrationNumber': _voterNumberController.text.trim(),
      });

      setState(() {
        _searchLoading = false;
        _personFound = true;
        foundUser = EnrollmentData.fromJson(result['data']);
      });
    } catch (e) {
      setState(() {
        _searchLoading = false;
        _personFound = false;
        foundUser = null;
      });
      _showSearchFailedDialog('$e');
    }
  }

  Future<void> _performNameSearch() async {
    if (_searchFamilyNameController.text.isEmpty) {
      toast('Veuillez saisir un nom de famille.');
      return;
    }

    if (_searchFirstNameController.text.isEmpty) {
      toast('Veuillez saisir un prénom.');
      return;
    }

    if (_selectedDay == null || _selectedMonth == null || _selectedYear == null) {
      toast('Veuillez saisir une date de naissance complète.');
      return;
    }

    setState(() => _searchLoading = true);

    try {
      final birthdate =
          '$_selectedYear-${_selectedMonth!.padLeft(2, '0')}-${_selectedDay!.padLeft(2, '0')}';

      final result = await verifyEnrolmentName({
        'form': 'NAME_AND_BIRTHDATE',
        'firstname': _searchFirstNameController.text.trim(),
        'lastname': _searchFamilyNameController.text.trim(),
        'birthdate': birthdate,
      });

      setState(() {
        _searchLoading = false;
        _personFound = true;
        foundUser = EnrollmentData.fromJson(result['data']);
      });
    } catch (e) {
      setState(() {
        _searchLoading = false;
        _personFound = false;
        foundUser = null;
      });
      _showSearchFailedDialog('$e');
    }
  }

  void _showSearchFailedDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recherche échouée', style: boldTextStyle()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50),
              16.height,
              Text(message, style: primaryTextStyle()),
              8.height,
              Text(
                'Veuillez vérifier vos informations et réessayer.',
                style: secondaryTextStyle(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        );
      },
    );
  }

  String _getPollingStationName() {
    return foundUser?.centre?.name ?? "Centre de vote non défini";
  }

  String _getFormattedDateOfBirth() {
    return foundUser?.birthdate != null
        ? "${foundUser!.birthdate!.day}/${foundUser!.birthdate!.month}/${foundUser!.birthdate!.year}"
        : "Date non disponible";
  }
}