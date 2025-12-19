import 'package:cei_mobile/core/constants/app_constants.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/store/UserStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../core/constants/user_constants.dart' show USER_UNIQUE_REGISTRATION_NUMBER;

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mon Compte',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: Observer(
        builder: (_) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              _buildProfileHeader(context),

              const SizedBox(height: 24),

              // Personal Information Section
              _buildSectionHeader('Informations Personnelles', Icons.person),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildInfoItem(
                        context,
                        'Nom d\'utilisateur',
                        userStore.username ?? 'Non défini',
                        Icons.person_outline,
                      ),
                      const Divider(height: 24),
                      _buildInfoItem(
                        context,
                        'Téléphone',
                        userStore.username ?? 'Non défini',
                        Icons.phone_outlined,
                      ),
                      const Divider(height: 24),
                      _buildInfoItem(
                        context,
                        'Email',
                        userStore.email ?? 'Non défini',
                        Icons.email_outlined,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Settings Section
              _buildSectionHeader('Paramètres', Icons.settings),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildSettingItem(
                      context,
                      'Modifier les informations personnelles',
                      Icons.edit_outlined,
                          () => _editProfile(context, userStore),
                    ),
                    const Divider(height: 1, indent: 56),
                    _buildSettingItem(
                      context,
                      'Changer le mot de passe',
                      Icons.lock_outline,
                          () => _changePassword(context),
                    ),
                    const Divider(height: 1, indent: 56),
                    _buildSettingItem(
                      context,
                      'Notifications',
                      Icons.notifications_outlined,
                          () => _manageNotifications(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Additional Options Section
              _buildSectionHeader('Options', Icons.more_horiz),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildSettingItem(
                      context,
                      'Conditions d\'utilisation',
                      Icons.description_outlined,
                          () => toast('Affichage des conditions d\'utilisation'),
                    ),
                    const Divider(height: 1, indent: 56),
                    _buildSettingItem(
                      context,
                      'Politique de confidentialité',
                      Icons.privacy_tip_outlined,
                          () => toast('Affichage de la politique de confidentialité'),
                    ),
                    const Divider(height: 1, indent: 56),
                    _buildSettingItem(
                      context,
                      'À propos',
                      Icons.info_outline,
                          () => toast('Affichage des informations sur l\'application'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Logout Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () => _confirmLogout(context, userStore),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout, color: Colors.white,),
                  label: const Text(
                    'Déconnexion',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final String initials = _getInitials(userStore.firstName, userStore.lastName);
    final String displayName = userStore.username ?? 'Utilisateur';

    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primary,
            child: Text(
              initials.isEmpty ? 'U' : initials,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            displayName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (userStore.email != null)
            Text(
              userStore.email!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(BuildContext context, String title, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 22,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String? firstName, String? lastName) {
    String initials = '';
    if (firstName != null && firstName.isNotEmpty) {
      initials += firstName[0];
    }
    if (lastName != null && lastName.isNotEmpty) {
      initials += lastName[0];
    }
    return initials.toUpperCase();
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aide'),
        content: const Text(
          'Cet écran vous permet de gérer vos informations personnelles et les paramètres de votre compte.\n\n'
              'Vous pouvez modifier vos informations, changer votre mot de passe ou gérer vos préférences de notification.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _editProfile(BuildContext context, UserStore userStore) {
    // Navigate to edit profile screen
    toast('Fonctionnalité à venir: Modification du profil');
  }

  void _changePassword(BuildContext context) {
    // Show change password dialog or navigate to change password screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Changer le mot de passe'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mot de passe actuel',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Nouveau mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmer le nouveau mot de passe',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              toast('Fonctionnalité à venir: Changement de mot de passe');
            },
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  void _manageNotifications(BuildContext context) {
    // Navigate to notification settings screen
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paramètres de notification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Notifications push'),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Implement notification toggle
                  toast('Paramètre sauvegardé');
                },
                activeColor: AppColors.primary,
              ),
            ),
            ListTile(
              title: const Text('Notifications par email'),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Implement notification toggle
                  toast('Paramètre sauvegardé');
                },
                activeColor: AppColors.primary,
              ),
            ),
            ListTile(
              title: const Text('Notifications SMS'),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Implement notification toggle
                  toast('Paramètre sauvegardé');
                },
                activeColor: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context, UserStore userStore) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
            ),
            onPressed: () {
              Navigator.pop(context);

              // Clear user data
              userStore.clearUser();

              // Clear app store data
              appStore.setLoggedIn(false);
              appStore.setEnrollmentData(null);
              appStore.setIsVoterCenterSaved(false);
              //appStore.setVoterCenterId(null); // Clear voter center ID

              // IMPORTANT: Completely reset enrollment store
              enrollmentStore.resetEnrollment();

              // Clear all authentication tokens
              tokenManager.clearTokens();

              // Remove all stored keys related to user session
              removeKey(AppConstants.authTokenKey);
              removeKey(AppConstants.refreshTokenKey);
              removeKey(AppConstants.isLoggedInKey);
              removeKey(AppConstants.isVoterCenterSavedKey);
              removeKey(AppConstants.voterCenterIdKey);
              removeKey(USER_UNIQUE_REGISTRATION_NUMBER);
              removeKey(AppConstants.numEnregisterKey);

              // Clear enrollment-related keys
              removeKey(AppConstants.isEnrollmentCompleteKey);
              removeKey(AppConstants.enrollmentReferenceNumberKey);
              removeKey(AppConstants.hasEnrollmentDataKey);
              removeKey(AppConstants.enrollmentCurrentStepKey);

              // Clear all enrollment form data keys
              removeKey(AppConstants.enrollmentLastNameKey);
              removeKey(AppConstants.enrollmentFirstNameKey);
              removeKey(AppConstants.enrollmentGenderKey);
              removeKey(AppConstants.enrollmentCityKey);
              removeKey(AppConstants.enrollmentCommuneKey);
              removeKey(AppConstants.enrollmentQuarterKey);
              removeKey(AppConstants.enrollmentFatherLastNameKey);
              removeKey(AppConstants.enrollmentFatherFirstNameKey);
              removeKey(AppConstants.enrollmentFatherBirthdateKey);
              removeKey(AppConstants.enrollmentFatherBirthplaceKey);
              removeKey(AppConstants.enrollmentMotherLastNameKey);
              removeKey(AppConstants.enrollmentMotherFirstNameKey);
              removeKey(AppConstants.enrollmentMotherBirthdateKey);
              removeKey(AppConstants.enrollmentMotherBirthplaceKey);
              removeKey(AppConstants.enrollmentPhoneKey);
              removeKey(AppConstants.enrollmentSecondPhoneKey);
              removeKey(AppConstants.enrollmentEmailKey);
              removeKey(AppConstants.enrollmentProfessionKey);

              // Clear temporary verification data
              removeKey('document_face_photo_path');
              removeKey('face_verification_result');
              removeKey('face_verification_score');

              // Clear welcome message flags for all users
              // This ensures the new user will see the welcome message
              SharedPreferences.getInstance().then((prefs) {
                final keys = prefs.getKeys();
                for (String key in keys) {
                  if (key.startsWith('has_shown_welcome_')) {
                    prefs.remove(key);
                  }
                }
              });

              toast('Déconnexion réussie');
              context.goNamed(AppRoutes.login);
            },
            child: const Text('Déconnecter'),
          ),
        ],
      ),
    );
  }
}