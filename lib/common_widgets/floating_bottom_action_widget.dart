import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class FloatButtomActionWidjet extends StatefulWidget {
  // Propriétés pour personnaliser les couleurs
  final Color openButtonBackgroundColor;
  final Color closeButtonBackgroundColor;
  final Color openButtonForegroundColor;
  final Color closeButtonForegroundColor;

  const FloatButtomActionWidjet({
    super.key,
    this.openButtonBackgroundColor = const Color(0xFF1B77B2),
    this.closeButtonBackgroundColor = Colors.red,
    this.openButtonForegroundColor = Colors.white,
    this.closeButtonForegroundColor = Colors.white,
  });

  @override
  State<FloatButtomActionWidjet> createState() => _FloatButtomActionWidjetState();
}

class _FloatButtomActionWidjetState extends State<FloatButtomActionWidjet> {
  // Key pour ExpandableFab
  final GlobalKey<ExpandableFabState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      distance: 70,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: Icon(Icons.headset_mic, color: widget.openButtonForegroundColor),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: widget.openButtonForegroundColor,
        backgroundColor: widget.openButtonBackgroundColor, // Couleur variable
        shape: CircleBorder(),
        heroTag: 'expandable-fab-open',
      ),
      closeButtonBuilder: RotateFloatingActionButtonBuilder(
        child: Icon(Icons.close, color: widget.closeButtonForegroundColor),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: widget.closeButtonForegroundColor,
        backgroundColor: widget.closeButtonBackgroundColor, // Couleur variable
        shape: CircleBorder(),
        heroTag: 'expandable-fab-close',
      ),
      overlayStyle: const ExpandableFabOverlayStyle(
        color: Colors.transparent,
        blur: 0,
      ),
      onOpen: () {
        debugPrint('📂 Menu ouvert');
        HapticFeedback.lightImpact();
      },
      afterOpen: () {
        debugPrint('✅ Menu complètement ouvert');
      },
      onClose: () {
        debugPrint('📁 Menu en cours de fermeture');
      },
      afterClose: () {
        debugPrint('❌ Menu complètement fermé');
      },
      children: [
        FloatingActionButton.small(
          heroTag: 'fab-language',
          backgroundColor: const Color(0xFF1B77B2),
          shape: const CircleBorder(),
          elevation: 4,
          child: const Icon(Icons.language, color: Colors.white),
          onPressed: () {
            debugPrint('🌍 Bouton langue pressé');
            Future.microtask(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Changement de langue"),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            });
            debugPrint('🔄 Menu devrait rester ouvert');
          },
        ),
        FloatingActionButton.small(
          heroTag: 'fab-email',
          backgroundColor: Colors.orange,
          shape: const CircleBorder(),
          elevation: 4,
          child: const Icon(Icons.email, color: Colors.white),
          onPressed: () {
            debugPrint('📧 Bouton email pressé');
            Future.microtask(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Contacter par email"),
                  backgroundColor: Colors.blue,
                  duration: Duration(seconds: 2),
                ),
              );
            });
            debugPrint('🔄 Menu devrait rester ouvert');
          },
        ),
      ],
    );
  }
}