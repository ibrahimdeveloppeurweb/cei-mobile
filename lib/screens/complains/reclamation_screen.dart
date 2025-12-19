import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/core/utils/common.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/model/user/user_model.dart';
import 'package:cei_mobile/screens/complains/personal_info_form.dart';
import 'package:cei_mobile/screens/complains/reclamation_details_form.dart';
import 'package:cei_mobile/screens/complains/search_form.dart';
import 'package:cei_mobile/screens/complains/type_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import 'confirmation_view.dart';

class ReclamationScreen extends StatefulWidget {
  const ReclamationScreen({super.key});

  @override
  State<ReclamationScreen> createState() => _ReclamationScreenState();
}

class _ReclamationScreenState extends State<ReclamationScreen> {
  int _currentStep = 0;
  bool _isSubmitted = false;
  String _selectedType = '';
  String _receiptNumber = '';
  EnrollmentData? foundUser;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _isSubmitted
                ? ConfirmationView(
              receiptNumber: _receiptNumber,
              selectedType: _selectedType,
              onFinish: () => GoRouter.of(context).pop(),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_currentStep > 0)
                  _buildStepIndicator(),
                const SizedBox(height: 24),
                _buildCurrentStep(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondary,
      elevation: 0,
      title: Text(
        'Réclamations',
        style: AppTextStyles.h2.copyWith(color: Colors.white),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => GoRouter.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(FluentIcons.question_circle_20_regular, color: Colors.white),
          onPressed: () => showArticleInfo(context),
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    return Text(
      'Type: $_selectedType',
      style: AppTextStyles.body1.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return TypeSelectionWidget(
          onTypeSelected: (type) {
            setState(() {
              _selectedType = type;
              _currentStep = 1;
            });
          },
        );
      case 1:
        return PersonalInfoForm(
          onContinue: () {
            setState(() => _currentStep = 2);
          },
          onBack: () => setState(() => _currentStep = 0),
        );
      case 2:
        return SearchForm(
          selectedType: _selectedType,
          onContinue: (personFound, user) {
            setState(() => foundUser = user);
            if (_selectedType == 'Inscription' && !personFound) {
              setState(() => _currentStep = 3);
            } else if ( personFound) {
              setState(() => _currentStep = 3);
            }
          },
          onBack: () => setState(() => _currentStep = 1),
        );
      case 3:
        return ReclamationDetailsForm(
          selectedType: _selectedType,
          foundUser: foundUser,
          onSubmit: (receiptNumber) {
            setState(() {
              _isSubmitted = true;
              _receiptNumber = receiptNumber;
            });
          },
          onBack: () => setState(() => _currentStep = _selectedType == 'Correction' ? 1 : 2),
        );
      default:
        return const SizedBox();
    }
  }
}