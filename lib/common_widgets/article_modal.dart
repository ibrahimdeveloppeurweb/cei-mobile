import 'package:cei_mobile/services/electoral_code_serve.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArticleModal extends StatelessWidget {
  final Article article;

  const ArticleModal({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 800,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // En-tête du modal
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          article.titre,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.chapitre,
                    style: TextStyle(
                      color: Colors.blue.shade100,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (article.section != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      article.section!,
                      style: TextStyle(
                        color: Colors.blue.shade200,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Contenu scrollable
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contenu de l'article
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: SelectableText(
                        article.contenu,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Mots-clés
                    if (article.motsCles.isNotEmpty) ...[
                      const Text(
                        'Mots-clés :',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: article.motsCles.map((motCle) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.blue.shade300,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              motCle,
                              style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),

            // Actions du modal
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: '${article.titre}\n\n${article.contenu}',
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Article copié dans le presse-papiers'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copier'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue.shade600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Fermer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode statique pour afficher le modal
  static void show(BuildContext context, Article article) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ArticleModal(article: article),
    );
  }
}

// Widget pour afficher un article dans une liste
class ArticleListTile extends StatelessWidget {
  final Article article;
  final VoidCallback? onTap;

  const ArticleListTile({
    Key? key,
    required this.article,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap ?? () => ArticleModal.show(context, article),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Art. ${article.numero}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      article.chapitre,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                article.contenu,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
              if (article.motsCles.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: article.motsCles.take(3).map((motCle) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.shade200,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        motCle,
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}