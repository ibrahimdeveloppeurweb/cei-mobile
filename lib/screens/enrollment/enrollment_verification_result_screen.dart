import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/model/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EnrollmentVerificationResultScreen extends StatefulWidget {
  final EnrollmentData userModel;
  const EnrollmentVerificationResultScreen({super.key, required this.userModel});

  @override
  State<EnrollmentVerificationResultScreen> createState() => _EnrollmentVerificationResultScreenState();
}

class _EnrollmentVerificationResultScreenState extends State<EnrollmentVerificationResultScreen> {
  void _showEnrollmentCenterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Enregistrer votre centre d'enrolement"),
        content: const Text(
            "Enregistrer ce centre vous permettra de suivre sa position géographique par la suite. Voulez-vous le faire maintenant ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
       if(widget.userModel.centre != null)   ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              appStore.setIsVoterCenterSaved(true);
              appStore.setVoterCenterId(widget.userModel.centre!.id.validate());
              appStore.setBureauDeVoteNumber(widget.userModel.centre!.id.validate().toString());
              appStore.setEnrollmentData(widget.userModel);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: AppColors.secondary,
                  content: Text("Centre d'enrolement enregistré avec succès !"),
                ),
              );
            },
            child: const Text("Confirmer"),
          ),
        ],
      ),
    );
  }

  String _getPollingStationName() {
    if (widget.userModel.centre?.name != null) {
      return "Bureau de vote #${widget.userModel.centre!.id}";
    }
    return "Bureau de vote non défini";
  }

  String _getFormattedDateOfBirth() {
    if (widget.userModel.birthdate != null) {
      return "${widget.userModel.birthdate!.day}/${widget.userModel.birthdate!.month}/${widget.userModel.birthdate!.year}";
    }
    return "Date non disponible";
  }

  String _getFormattedFatherDateOfBirth() {
    if (widget.userModel.birthdateFather != null) {
      return "${widget.userModel.birthdateFather!.day}/${widget.userModel.birthdateFather!.month}/${widget.userModel.birthdateFather!.year}";
    }
    return "Date non disponible";
  }

  String _getFormattedMotherDateOfBirth() {
    if (widget.userModel.birthdateMother != null) {
      return "${widget.userModel.birthdateMother!.day}/${widget.userModel.birthdateMother!.month}/${widget.userModel.birthdateMother!.year}";
    }
    return "Date non disponible";
  }

  String _getEnrollmentCenter() {
    if (widget.userModel.centre != null) {
      final ps = widget.userModel.centre!;
      if (ps.name != null && ps.name != null) {
        return "${ps.name} - ${ps.commune!.name}";
      } else if (ps.name != null) {
        return ps.name!;
      }
    }
    return "Centre d'enrôlement non défini";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Informations Electeur'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              toast('Partage de données électorales');
            },
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              toast('Impression des données électorales');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header banner
            Container(
              width: double.infinity,
              color: AppColors.secondary,
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'LISTE ÉLECTORALE PROVISOIRE 2025',
                    style: boldTextStyle(color: Colors.white, size: 14),
                  ),
                  10.height,
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Vous êtes inscrit sur la liste électorale',
                      style: boldTextStyle(color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
            ),

            // Card with voter information
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile header with photo
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile picture
                        Container(
                          width: 120,
                          height: 150,
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: AppColors.grey2, width: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: widget.userModel.photoIdentite.isEmptyOrNull
                                ? Image.asset(
                              'assets/images/profile_placeholder.png',
                              fit: BoxFit.cover,
                            )
                                : Image.network(
                              widget.userModel.photoIdentite!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        16.width,
                        // Basic identification
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.userModel.lastName.validate()} ${widget.userModel.firstName.validate()}',
                                style: boldTextStyle(size: 20),
                              ),
                              12.height,
                              _buildDetailRow('N° d\'ordre:',
                                  widget.userModel.numOrder.validate()),
                              8.height,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'N° d\'électeur:',
                                    style: secondaryTextStyle(size: 14),
                                  ),
                                  4.width,
                                  Text(
                                    widget.userModel.numEnregister
                                        .validate(),
                                    style: boldTextStyle(size: 14),
                                  ),
                                ],
                              ),
                              8.height,
                              _buildDetailRow(
                                  'Genre:', widget.userModel.gender.validate()),
                              8.height,
                              _buildDetailRow('Profession:',
                                  widget.userModel.profession.validate()),
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
                  ),

                  // Personal Information Section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('INFORMATIONS PERSONNELLES'),
                        12.height,
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoBox(
                                'Date de naissance:',
                                _getFormattedDateOfBirth(),
                                Icons.calendar_today,
                              ),
                            ),
                            12.width,
                            Expanded(
                              child: _buildInfoBox(
                                'Lieu de naissance:',
                                widget.userModel.birthplace.validate(),
                                Icons.place,
                              ),
                            ),
                          ],
                        ),
                        12.height,
                        _buildInfoBox(
                          'Domicile:',
                          widget.userModel.quartier.validate(),
                          Icons.home,
                        ),
                      ],
                    ),
                  ),

                  // Parents Information Section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('INFORMATIONS FAMILIALES'),
                        12.height,

                        // Father's information
                        _buildParentInfo(
                          'Père:',
                          widget.userModel.firstNameFather.validate(),
                          _getFormattedFatherDateOfBirth(),
                          widget.userModel.birthplaceFather.validate(),
                          Icons.person,
                        ),
                        16.height,

                        // Mother's information
                        _buildParentInfo(
                          'Mère:',
                          widget.userModel.lastNameMother.validate(),
                          _getFormattedMotherDateOfBirth(),
                          widget.userModel.birthplaceMother.validate(),
                          Icons.person_outline,
                        ),
                      ],
                    ),
                  ),

                  // Enrollment Information
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader('INFORMATION D\'ENRÔLEMENT'),
                        12.height,
                        _buildInfoBox(
                          'Centre d\'enrôlement:',
                          _getEnrollmentCenter(),
                          Icons.how_to_vote,
                        ),
                      ],
                    ),
                  ),

                  // QR Code Section
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'CODE QR D\'IDENTIFICATION',
                          style: boldTextStyle(size: 16),
                          textAlign: TextAlign.center,
                        ),
                        8.height,
                        Text(
                          'Présentez ce code lors du vote',
                          style: secondaryTextStyle(size: 14),
                          textAlign: TextAlign.center,
                        ),
                        20.height,
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: QrImageView(
                              data:
                              '${widget.userModel.numEnregister}:${widget.userModel.firstName} ${widget.userModel.lastName}',
                              version: QrVersions.auto,
                              size: 200.0,
                              embeddedImage: const AssetImage(
                                  'assets/images/cei_logo_small.png'),
                              embeddedImageStyle: const QrEmbeddedImageStyle(
                                size: Size(30, 30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Important notice
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.orange),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Information importante',
                          style: boldTextStyle(
                              color: Colors.orange.shade800, size: 14),
                        ),
                        8.height,
                        Text(
                          'N\'oubliez pas de vous munir d\'une pièce d\'identité valide (CNI, passeport, permis de conduire) le jour du scrutin.',
                          style: primaryTextStyle(size: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.height
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.map,
                  color: Colors.white,
                ),
                label: const Text('Enregistrer mon centre d\'enrolement'),
                onPressed: () {
                  _showEnrollmentCenterDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          color: AppColors.primary,
        ),
        8.width,
        Text(
          title,
          style: boldTextStyle(size: 16),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: secondaryTextStyle(size: 14),
        ),
        4.width,
        Expanded(
          child: Text(
            value,
            style: boldTextStyle(size: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.primary,
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: secondaryTextStyle(size: 13),
                ),
                4.height,
                Text(
                  value,
                  style: boldTextStyle(size: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParentInfo(
      String label, String name, String dob, String pob, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: AppColors.primary,
              ),
              8.width,
              Text(
                label,
                style: secondaryTextStyle(size: 13),
              ),
            ],
          ),
          8.height,
          Text(
            name,
            style: boldTextStyle(size: 15),
          ),
          8.height,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date de naissance:',
                      style: secondaryTextStyle(size: 12),
                    ),
                    4.height,
                    Text(
                      dob,
                      style: primaryTextStyle(size: 14),
                    ),
                  ],
                ),
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lieu de naissance:',
                      style: secondaryTextStyle(size: 12),
                    ),
                    4.height,
                    Text(
                      pob,
                      style: primaryTextStyle(size: 14),
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
}



