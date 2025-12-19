import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class PersonalInfoForm extends StatefulWidget {
  final VoidCallback onContinue;
  final VoidCallback onBack;

  const PersonalInfoForm({
    super.key,
    required this.onContinue,
    required this.onBack,
  });

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController(text: userStore.lastName);
  final _prenomController = TextEditingController(text: userStore.firstName);
  final _numeroElecteurController = TextEditingController(text: "V999666000");
  final _telephoneController = TextEditingController(text: userStore.username);

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _numeroElecteurController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Informations concernant le déclarant', style: AppTextStyles.h3),
          const SizedBox(height: 16),
          _buildTextField('Nom *', _nomController, TextFieldType.NAME),
          const SizedBox(height: 12),
          _buildTextField('Prénom *', _prenomController, TextFieldType.NAME),
          const SizedBox(height: 12),
          _buildTextField("Numéro d'électeur *", _numeroElecteurController, TextFieldType.NAME),
          const SizedBox(height: 12),
          _buildTextField('Téléphone *', _telephoneController, TextFieldType.PHONE),
          const SizedBox(height: 24),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextFieldType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.body2),
        AppTextField(
          controller: controller,
          textFieldType: type,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          validator: (value) => value?.isEmpty ?? true ? 'Ce champ est obligatoire' : null,
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
          color: AppColors.primary,
          onTap: () {
            if (_formKey.currentState!.validate()) {
              widget.onContinue();
            }
          },
          child: Text('Continuer', style: boldTextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}