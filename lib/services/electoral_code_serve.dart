import 'dart:convert';
import 'package:flutter/services.dart';

class Article {
  final String numero;
  final String titre;
  final String contenu;
  final String chapitre;
  final String? section;
  final List<String> motsCles;

  Article({
    required this.numero,
    required this.titre,
    required this.contenu,
    required this.chapitre,
    this.section,
    required this.motsCles,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      numero: json['numero'],
      titre: json['titre'],
      contenu: json['contenu'],
      chapitre: json['chapitre'],
      section: json['section'],
      motsCles: List<String>.from(json['mots_cles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero': numero,
      'titre': titre,
      'contenu': contenu,
      'chapitre': chapitre,
      'section': section,
      'mots_cles': motsCles,
    };
  }
}

class CodeElectoral {
  final String titre;
  final String ordonnance;
  final List<Article> articles;

  CodeElectoral({
    required this.titre,
    required this.ordonnance,
    required this.articles,
  });

  factory CodeElectoral.fromJson(Map<String, dynamic> json) {
    var codeData = json['code_electoral'];
    return CodeElectoral(
      titre: codeData['titre'],
      ordonnance: codeData['ordonnance'],
      articles: (codeData['articles'] as List)
          .map((article) => Article.fromJson(article))
          .toList(),
    );
  }
}

class ElectoralCodeService {
  static ElectoralCodeService? _instance;
  static ElectoralCodeService get instance => _instance ??= ElectoralCodeService._();

  ElectoralCodeService._();

  CodeElectoral? _codeElectoral;

  // Charger le code électoral depuis les assets
  Future<void> loadElectoralCode() async {
    if (_codeElectoral != null) return;

    try {
      final String jsonString = await rootBundle.loadString('assets/data/code_electoral.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      _codeElectoral = CodeElectoral.fromJson(jsonData);
    } catch (e) {
      throw Exception('Erreur lors du chargement du code électoral: $e');
    }
  }

  // Obtenir tous les articles
  List<Article> getAllArticles() {
    return _codeElectoral?.articles ?? [];
  }

  // Rechercher un article par son numéro
  Article? getArticleByNumber(String numero) {
    if (_codeElectoral == null) return null;

    try {
      return _codeElectoral!.articles.firstWhere(
            (article) => article.numero == numero,
      );
    } catch (e) {
      return null;
    }
  }

  // Rechercher des articles par mot-clé
  List<Article> searchArticlesByKeyword(String keyword) {
    if (_codeElectoral == null) return [];

    final String searchTerm = keyword.toLowerCase();

    return _codeElectoral!.articles.where((article) {
      return article.contenu.toLowerCase().contains(searchTerm) ||
          article.titre.toLowerCase().contains(searchTerm) ||
          article.chapitre.toLowerCase().contains(searchTerm) ||
          (article.section?.toLowerCase().contains(searchTerm) ?? false) ||
          article.motsCles.any((motCle) => motCle.toLowerCase().contains(searchTerm));
    }).toList();
  }

  // Rechercher des articles par chapitre
  List<Article> getArticlesByChapter(String chapitre) {
    if (_codeElectoral == null) return [];

    return _codeElectoral!.articles.where((article) {
      return article.chapitre.toLowerCase().contains(chapitre.toLowerCase());
    }).toList();
  }

  // Rechercher des articles par section
  List<Article> getArticlesBySection(String section) {
    if (_codeElectoral == null) return [];

    return _codeElectoral!.articles.where((article) {
      return article.section?.toLowerCase().contains(section.toLowerCase()) ?? false;
    }).toList();
  }

  // Obtenir les chapitres uniques
  List<String> getUniqueChapters() {
    if (_codeElectoral == null) return [];

    return _codeElectoral!.articles
        .map((article) => article.chapitre)
        .toSet()
        .toList();
  }

  // Obtenir les sections uniques
  List<String> getUniqueSections() {
    if (_codeElectoral == null) return [];

    return _codeElectoral!.articles
        .where((article) => article.section != null)
        .map((article) => article.section!)
        .toSet()
        .toList();
  }

  // Recherche avancée avec plusieurs critères
  List<Article> advancedSearch({
    String? keyword,
    String? chapitre,
    String? section,
    List<String>? motsCles,
  }) {
    if (_codeElectoral == null) return [];

    return _codeElectoral!.articles.where((article) {
      bool matches = true;

      if (keyword != null && keyword.isNotEmpty) {
        final searchTerm = keyword.toLowerCase();
        matches = matches && (
            article.contenu.toLowerCase().contains(searchTerm) ||
                article.titre.toLowerCase().contains(searchTerm) ||
                article.chapitre.toLowerCase().contains(searchTerm) ||
                (article.section?.toLowerCase().contains(searchTerm) ?? false)
        );
      }

      if (chapitre != null && chapitre.isNotEmpty) {
        matches = matches && article.chapitre.toLowerCase().contains(chapitre.toLowerCase());
      }

      if (section != null && section.isNotEmpty) {
        matches = matches && (article.section?.toLowerCase().contains(section.toLowerCase()) ?? false);
      }

      if (motsCles != null && motsCles.isNotEmpty) {
        matches = matches && motsCles.any((motCle) =>
            article.motsCles.any((articleMotCle) =>
                articleMotCle.toLowerCase().contains(motCle.toLowerCase())
            )
        );
      }

      return matches;
    }).toList();
  }

  // Obtenir le titre et l'ordonnance
  String? getTitle() => _codeElectoral?.titre;
  String? getOrdinanceNumber() => _codeElectoral?.ordonnance;
}