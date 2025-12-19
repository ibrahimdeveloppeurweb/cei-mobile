import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class QuickActionsWidget extends StatefulWidget {
  final bool isEnrollmentComplete;
  final bool isVoterCenterSaved;
  final VoidCallback onEnrollmentTap;
  final VoidCallback onVerificationTap;
  final VoidCallback onCenterTap;
  final VoidCallback onElectoralListTap;

  const QuickActionsWidget({
    Key? key,
    required this.isEnrollmentComplete,
    required this.isVoterCenterSaved,
    required this.onEnrollmentTap,
    required this.onVerificationTap,
    required this.onCenterTap,
    required this.onElectoralListTap,
  }) : super(key: key);

  @override
  State<QuickActionsWidget> createState() => _QuickActionsWidgetState();
}

class _QuickActionsWidgetState extends State<QuickActionsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _slideAnimation.value)),
          child: Opacity(
            opacity: _slideAnimation.value,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF005828).withOpacity(0.1),
                    const Color(0xFFDB812E).withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF005828).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF005828),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          FluentIcons.flash_20_filled,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Actions Rapides',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF005828),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Accédez rapidement aux services les plus utilisés',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildQuickActionsList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActionsList() {
    List<QuickAction> actions = [];

    // Action conditionnelle pour l'enrôlement
    if (!widget.isEnrollmentComplete) {
      actions.add(QuickAction(
        icon: FluentIcons.person_add_20_filled,
        title: 'Commencer mon enrôlement',
        subtitle: 'Inscrivez-vous sur les listes électorales',
        color: const Color(0xFFDB812E),
        isHighPriority: true,
        onTap: widget.onEnrollmentTap,
      ));
    }

    // Action conditionnelle pour le centre
    if (!widget.isVoterCenterSaved) {
      actions.add(QuickAction(
        icon: FluentIcons.location_20_filled,
        title: 'Trouver mon centre',
        subtitle: 'Localisez votre centre d\'enrôlement',
        color: const Color(0xFF005828),
        isHighPriority: true,
        onTap: widget.onCenterTap,
      ));
    }

    // Actions toujours disponibles
    actions.addAll([
      QuickAction(
        icon: FluentIcons.checkmark_circle_20_filled,
        title: 'Vérifier mon inscription',
        subtitle: 'Vérifiez votre statut électoral',
        color: const Color(0xFF4CAF50),
        isHighPriority: false,
        onTap: widget.onVerificationTap,
      ),
      QuickAction(
        icon: FluentIcons.document_20_filled,
        title: 'Consulter la liste électorale',
        subtitle: 'Accédez à la liste de votre centre',
        color: const Color(0xFF2196F3),
        isHighPriority: false,
        onTap: widget.onElectoralListTap,
      ),
    ]);

    return Column(
      children: actions.asMap().entries.map((entry) {
        int index = entry.key;
        QuickAction action = entry.value;

        return AnimatedContainer(
          duration: Duration(milliseconds: 200 + (index * 100)),
          margin: const EdgeInsets.only(bottom: 12),
          child: _buildQuickActionTile(action),
        );
      }).toList(),
    );
  }

  Widget _buildQuickActionTile(QuickAction action) {
    return InkWell(
      onTap: action.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: action.isHighPriority
              ? action.color.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: action.isHighPriority
                ? action.color.withOpacity(0.3)
                : const Color(0xFFEEEEEE),
            width: action.isHighPriority ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: action.color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                action.icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          action.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: action.isHighPriority
                                ? action.color
                                : const Color(0xFF212121),
                          ),
                        ),
                      ),
                      if (action.isHighPriority)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: action.color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Priorité',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    action.subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF757575),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickAction {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isHighPriority;
  final VoidCallback onTap;

  QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isHighPriority,
    required this.onTap,
  });
}

// Widget de bannière d'information pour le statut utilisateur
class StatusBannerWidget extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final VoidCallback? onTap;

  const StatusBannerWidget({
    Key? key,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                color: textColor,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}