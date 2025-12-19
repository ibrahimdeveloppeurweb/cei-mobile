import 'package:cei_mobile/common_widgets/file_preview_card.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/core/utils/common.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/model/user/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:nb_utils/nb_utils.dart';

class ReclamationDetailsForm extends StatefulWidget {
  final String selectedType;
  final EnrollmentData? foundUser;
  final Function(String receiptNumber) onSubmit;
  final VoidCallback onBack;

  const ReclamationDetailsForm({
    super.key,
    required this.selectedType,
    required this.foundUser,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  State<ReclamationDetailsForm> createState() => _ReclamationDetailsFormState();
}

class _ReclamationDetailsFormState extends State<ReclamationDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<PlatformFile> _selectedFiles = [];
  bool _isPickingFiles = false;
  bool _isLoading = false;

  final TextEditingController _personConcernedController =
  TextEditingController();
  final TextEditingController _justificationController =
  TextEditingController();
  final TextEditingController _newNomController = TextEditingController();
  final TextEditingController _newPrenomController = TextEditingController();
  final TextEditingController _newProfessionController =
  TextEditingController();
  final TextEditingController _newResidenceController = TextEditingController();
  TextEditingController voterNumberController = TextEditingController();

  String? _newBirthDay;
  String? _newBirthMonth;
  String? _newBirthYear;
  String? _newGenre;

  bool _correctNom = false;
  bool _correctPrenom = false;
  bool _correctDateNaissance = false;
  bool _correctGenre = false;
  bool _correctProfession = false;
  bool _correctResidence = false;

  @override
  void initState() {
    super.initState();
    _prefillUserData();
  }

  void _prefillUserData() {
    if (widget.foundUser != null) {
      // Pré-remplir le nom complet
      _personConcernedController.text =
      "${widget.foundUser?.firstName.validate()} ${widget.foundUser?.lastName.validate()}";

      // Pré-remplir les champs de correction avec les données actuelles
      _newNomController.text = widget.foundUser?.lastName.validate() ?? '';
      _newPrenomController.text = widget.foundUser?.firstName.validate() ?? '';
      _newProfessionController.text = widget.foundUser?.profession.validate() ?? '';

      // Pré-remplir l'adresse (combinant address et quartier si disponibles)
      String currentAddress = '';
      if (widget.foundUser?.address?.isNotEmpty == true) {
        currentAddress = widget.foundUser!.address!;
      }
      if (widget.foundUser?.quartier?.isNotEmpty == true) {
        if (currentAddress.isNotEmpty) {
          currentAddress += ', ${widget.foundUser!.quartier!}';
        } else {
          currentAddress = widget.foundUser!.quartier!;
        }
      }
      _newResidenceController.text = currentAddress;

      // Pré-remplir la date de naissance
      if (widget.foundUser?.birthdate != null) {
        _newBirthDay = widget.foundUser!.birthdate!.day.toString();
        _newBirthMonth = widget.foundUser!.birthdate!.month.toString();
        _newBirthYear = widget.foundUser!.birthdate!.year.toString();
      }

      // Pré-remplir le genre
      if (widget.foundUser?.gender?.isNotEmpty == true) {
        // Normaliser le genre pour correspondre aux options du dropdown
        String gender = widget.foundUser!.gender!.toLowerCase();
        if (gender.contains('m') || gender.contains('h')) {
          _newGenre = 'Masculin';
        } else if (gender.contains('f')) {
          _newGenre = 'Féminin';
        } else {
          _newGenre = widget.foundUser!.gender; // Garder la valeur originale si pas de correspondance
        }
      }
    }
  }

  @override
  void dispose() {
    _personConcernedController.dispose();
    _justificationController.dispose();
    _newNomController.dispose();
    _newPrenomController.dispose();
    _newProfessionController.dispose();
    _newResidenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.foundUser != null) ...[
            const Text('Informations sur la personne',
                style: AppTextStyles.h3),
            16.height,
            if (widget.foundUser != null) _buildPersonDetailsCard(),
            24.height,
          ],
          const Text('Détails de la réclamation', style: AppTextStyles.h3),
          16.height,
          if (widget.selectedType == 'Correction') _buildCorrectionForm(),
          if (widget.selectedType == 'Inscription') ...[
            Text(
              widget.selectedType == 'Inscription'
                  ? 'Nom et prénom de la personne à inscrire *'
                  : 'Nom et prénom de la personne à radier *',
              style: AppTextStyles.body2,
            ),
            AppTextField(
              controller: _personConcernedController,
              enabled: widget.selectedType == 'Inscription',
              decoration: const InputDecoration(border: OutlineInputBorder()),
              validator: (value) =>
              value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
              textFieldType: TextFieldType.NAME,
            ),
            const SizedBox(height: 12),
          ],
          if (widget.selectedType == 'Inscription')
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(FluentIcons.location_20_regular,
                      color: AppColors.primary),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Centre concerné", style: AppTextStyles.body2),
                      Text(
                        _getPollingStationName(),
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          const Text("Motif de la réclamation *", style: AppTextStyles.body2),
          AppTextField(
            controller: _justificationController,
            decoration: const InputDecoration(
              hintText: 'Veuillez expliquer votre réclamation',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 5,
            validator: (value) => value?.isEmpty ?? true
                ? 'Veuillez justifier votre réclamation'
                : null,
            textFieldType: TextFieldType.MULTILINE,
          ),
          const SizedBox(height: 12),
          const Text("Numéro d'enregistrement", style: AppTextStyles.body2),
        if(widget.selectedType == 'Inscription')  AppTextField(
            controller: voterNumberController,
            textFieldType: TextFieldType.NAME,
            inputFormatters: [VoterIDInputFormatter()],
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'V 0000 0000 00',
            ),
          ),
          const SizedBox(height: 12),
          _buildFileAttachmentSection(),
          const SizedBox(height: 24),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildCorrectionForm() {
    final List<Map<String, dynamic>> fieldOptions = [
      {'key': 'nom', 'label': 'Nom', 'icon': Icons.person},
      {'key': 'prenom', 'label': 'Prénom', 'icon': Icons.person_outline},
      {
        'key': 'dateNaissance',
        'label': 'Date de naissance',
        'icon': Icons.calendar_today
      },
      {'key': 'genre', 'label': 'Genre', 'icon': Icons.people},
      {'key': 'profession', 'label': 'Profession', 'icon': Icons.work},
      {'key': 'residence', 'label': 'Adresse/Résidence', 'icon': Icons.home},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sélectionnez les informations à corriger:',
        ),
        16.height,

        // Multi-select Chips for better visual selection
        Wrap(
          spacing: 8,
          runSpacing: 12,
          children: fieldOptions.map((field) {
            bool isSelected = _getFieldSelectionStatus(field['key']);

            return InkWell(
              onTap: () => _toggleFieldSelection(field['key']),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                    isSelected ? AppColors.primary : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      field['icon'],
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      size: 20,
                    ),
                    8.width,
                    Text(
                      field['label'],
                      style: TextStyle(
                        color:
                        isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    8.width,
                    Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      color: isSelected ? Colors.white : Colors.grey.shade400,
                      size: 18,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        24.height,

        // Show selected fields with prefilled current values
        if (_hasAnyFieldSelected())
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Entrez les nouvelles informations:',
                  style: AppTextStyles.h4.copyWith(color: AppColors.primary),
                ),
                8.height,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: Colors.blue.shade700, size: 16),
                      8.width,
                      Expanded(
                        child: Text(
                          'Les champs sont pré-remplis avec les informations actuelles. Modifiez selon vos besoins.',
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 24),

                // Dynamically show input fields for selected options
                if (_correctNom)
                  _buildInputField(
                    title: 'Nouveau nom',
                    currentValue: 'Actuel: ${widget.foundUser?.lastName ?? "Non défini"}',
                    icon: Icons.person,
                    field: AppTextField(
                      controller: _newNomController,
                      textFieldType: TextFieldType.NAME,
                      decoration: InputDecoration(
                        hintText: 'Entrez le nouveau nom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.primary, width: 2),
                        ),
                        prefixIcon:
                        const Icon(Icons.edit, color: AppColors.primary),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Veuillez entrer le nouveau nom'
                          : null,
                    ),
                  ),

                if (_correctPrenom)
                  _buildInputField(
                    title: 'Nouveau prénom',
                    currentValue: 'Actuel: ${widget.foundUser?.firstName ?? "Non défini"}',
                    icon: Icons.person_outline,
                    field: AppTextField(
                      controller: _newPrenomController,
                      textFieldType: TextFieldType.NAME,
                      decoration: InputDecoration(
                        hintText: 'Entrez le nouveau prénom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.primary, width: 2),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Veuillez entrer le nouveau prénom'
                          : null,
                    ),
                  ),

                if (_correctDateNaissance)
                  _buildInputField(
                    title: 'Nouvelle date de naissance',
                    currentValue: 'Actuel: ${_getFormattedDateOfBirth()}',
                    icon: Icons.calendar_today,
                    field: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Jour',
                                border: InputBorder.none,
                              ),
                              value: _newBirthDay,
                              items: List.generate(31, (index) => index + 1)
                                  .map((day) => DropdownMenuItem(
                                value: day.toString(),
                                child: Text(day.toString()),
                              ))
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => _newBirthDay = value),
                              validator: (value) =>
                              value == null ? 'Requis' : null,
                            ),
                          ),
                          12.width,
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Mois',
                                border: InputBorder.none,
                              ),
                              value: _newBirthMonth,
                              items: List.generate(12, (index) => index + 1)
                                  .map((month) => DropdownMenuItem(
                                value: month.toString(),
                                child: Text(month.toString()),
                              ))
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => _newBirthMonth = value),
                              validator: (value) =>
                              value == null ? 'Requis' : null,
                            ),
                          ),
                          12.width,
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Année',
                                border: InputBorder.none,
                              ),
                              value: _newBirthYear,
                              items: List.generate(100, (index) => 2025 - index)
                                  .map((year) => DropdownMenuItem(
                                value: year.toString(),
                                child: Text(year.toString()),
                              ))
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => _newBirthYear = value),
                              validator: (value) =>
                              value == null ? 'Requis' : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (_correctGenre)
                  _buildInputField(
                    title: 'Nouveau genre',
                    currentValue: 'Actuel: ${widget.foundUser?.gender ?? "Non défini"}',
                    icon: Icons.people,
                    field: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Sélectionnez le nouveau genre',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.primary, width: 2),
                        ),
                      ),
                      value: _newGenre,
                      items: ['Masculin', 'Féminin']
                          .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                          .toList(),
                      onChanged: (value) => setState(() => _newGenre = value),
                      validator: (value) => value == null
                          ? 'Veuillez sélectionner le genre'
                          : null,
                    ),
                  ),

                if (_correctProfession)
                  _buildInputField(
                    title: 'Nouvelle profession',
                    currentValue: 'Actuel: ${widget.foundUser?.profession ?? "Non défini"}',
                    icon: Icons.work,
                    field: AppTextField(
                      controller: _newProfessionController,
                      textFieldType: TextFieldType.NAME,
                      decoration: InputDecoration(
                        hintText: 'Entrez la nouvelle profession',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.primary, width: 2),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Veuillez entrer la nouvelle profession'
                          : null,
                    ),
                  ),

                if (_correctResidence)
                  _buildInputField(
                    title: 'Nouvelle adresse/résidence',
                    currentValue: 'Actuel: ${_getCurrentAddress()}',
                    icon: Icons.home,
                    field: AppTextField(
                      controller: _newResidenceController,
                      textFieldType: TextFieldType.MULTILINE,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Entrez la nouvelle adresse/résidence',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: AppColors.primary, width: 2),
                        ),
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Veuillez entrer la nouvelle adresse'
                          : null,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  // Helper method to build input field with title, current value, and icon
  Widget _buildInputField({
    required String title,
    required String currentValue,
    required IconData icon,
    required Widget field,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style:
                AppTextStyles.body2.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          4.height,
          Text(
            currentValue,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          8.height,
          field,
        ],
      ),
    );
  }

  // Helper method to get current address
  String _getCurrentAddress() {
    if (widget.foundUser == null) return "Non défini";

    String address = '';
    if (widget.foundUser?.address?.isNotEmpty == true) {
      address = widget.foundUser!.address!;
    }
    if (widget.foundUser?.quartier?.isNotEmpty == true) {
      if (address.isNotEmpty) {
        address += ', ${widget.foundUser!.quartier!}';
      } else {
        address = widget.foundUser!.quartier!;
      }
    }

    return address.isNotEmpty ? address : "Non défini";
  }

  // Helper methods for field selection state management
  bool _getFieldSelectionStatus(String fieldKey) {
    switch (fieldKey) {
      case 'nom':
        return _correctNom;
      case 'prenom':
        return _correctPrenom;
      case 'dateNaissance':
        return _correctDateNaissance;
      case 'genre':
        return _correctGenre;
      case 'profession':
        return _correctProfession;
      case 'residence':
        return _correctResidence;
      default:
        return false;
    }
  }

  void _toggleFieldSelection(String fieldKey) {
    setState(() {
      switch (fieldKey) {
        case 'nom':
          _correctNom = !_correctNom;
          break;
        case 'prenom':
          _correctPrenom = !_correctPrenom;
          break;
        case 'dateNaissance':
          _correctDateNaissance = !_correctDateNaissance;
          break;
        case 'genre':
          _correctGenre = !_correctGenre;
          break;
        case 'profession':
          _correctProfession = !_correctProfession;
          break;
        case 'residence':
          _correctResidence = !_correctResidence;
          break;
      }
    });
  }

  bool _hasAnyFieldSelected() {
    return _correctNom ||
        _correctPrenom ||
        _correctDateNaissance ||
        _correctGenre ||
        _correctProfession ||
        _correctResidence;
  }

  Widget _buildPersonDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  child: widget.foundUser!.photoIdentite.isEmptyOrNull
                      ? Image.asset(
                    'assets/images/profile_placeholder.png',
                    fit: BoxFit.cover,
                  )
                      : Image.network(
                    widget.foundUser!.photoIdentite!,
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
                      '${widget.foundUser!.firstName.validate()} ${widget.foundUser!.lastName.validate()}',
                      style: boldTextStyle(size: 20),
                    ),
                    12.height,
                    _buildDetailRow(
                        'Date de naissance:', _getFormattedDateOfBirth()),
                    8.height,
                    _buildDetailRow('N° d\'ordre:',
                        widget.foundUser!.numOrder.validate()),
                    8.height,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('N° d\'électeur:',
                            style: secondaryTextStyle(size: 14)),
                        4.width,
                        Text(
                          widget.foundUser!.numEnregister.validate(),
                          style: boldTextStyle(size: 14),
                        ),
                      ],
                    ),
                    8.height,
                    _buildDetailRow(
                        'Genre:', widget.foundUser!.gender.validate()),
                    8.height,
                    _buildDetailRow(
                        'Profession:', widget.foundUser!.profession.validate()),
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
                          const Icon(Icons.location_on,
                              size: 18, color: AppColors.primary),
                          4.width,
                          Expanded(
                            child: Text(
                              _getPollingStationName(),
                              style: boldTextStyle(
                                  color: AppColors.primary, size: 14),
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

  Widget _buildFileAttachmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppButton(
          shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
          elevation: 0.0,
          color: Colors.grey[300],
          onTap: _pickFiles,
          child: _isPickingFiles
              ? const CircularProgressIndicator()
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.attach_file, color: AppColors.textPrimary),
              const SizedBox(width: 8),
              Text(
                widget.selectedType == "Inscription" ? "Récépissé d'enrôlement" : 'Joindre des pièces',
                style: boldTextStyle(color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Formats acceptés: PDF, JPG, PNG, DOC, DOCX (10mo max)',
          style: AppTextStyles.caption,
        ),
        const SizedBox(height: 16),
        if (_selectedFiles.isNotEmpty) ...[
          Text(
         widget.selectedType == "Inscription" ? "Récépissé d'enrôlement" :  'Pièces jointes (${_selectedFiles.length})',
            style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._selectedFiles
              .map((file) => FilePreviewCard(
            file: file,
            onRemove: () => _removeFile(file),
          ))
              .toList(),
        ],
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
          onTap: _submitForm,
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text('Soumettre', style: boldTextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _pickFiles() async {
    try {
      setState(() => _isPickingFiles = true);

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        setState(() => _selectedFiles.addAll(result.files));
        toast('${result.files.length} fichier(s) sélectionné(s)');
      }
    } catch (e) {
      toast('Erreur lors de la sélection des fichiers');
      debugPrint('File picking error: $e');
    } finally {
      setState(() => _isPickingFiles = false);
    }
  }

  void _removeFile(PlatformFile file) {
    setState(() => _selectedFiles.remove(file));
    toast('Fichier supprimé');
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      // Generate receipt number
      final randomNum = 10000 + DateTime.now().millisecondsSinceEpoch % 90000;
      final receiptNum = 'REC-$randomNum-${DateTime.now().year}';

      widget.onSubmit(receiptNum);
    }
  }

  String _getPollingStationName() {
    return widget.foundUser?.centre?.name ??
        "Centre de vote non défini";
  }

  String _getFormattedDateOfBirth() {
    return widget.foundUser?.birthdate != null
        ? "${widget.foundUser!.birthdate!.day}/${widget.foundUser!.birthdate!.month}/${widget.foundUser!.birthdate!.year}"
        : "Date non disponible";
  }
}