enum RequestStatus {
  notRequested, // Aucune demande effectuée
  pending,      // Demande en attente
  approved,     // Demande approuvée
  rejected      // Demande rejetée
}

/// Classe représentant une demande d'accès à la liste électorale
class ElectoralRequest {
  /// Identifiant unique de la demande
  final String id;

  /// Statut actuel de la demande
  final RequestStatus status;

  /// Date de soumission de la demande (format "JJ/MM/AAAA")
  final String date;

  /// Motif de la demande
  final String motif;

  /// Année concernée par la demande
  final String annee;

  /// District concerné
  final String district;

  /// Région concernée (peut être null)
  final String? region;

  /// Département concerné (peut être null)
  final String? departement;

  /// Sous-préfecture concernée (peut être null)
  final String? sousPrefecture;

  /// Commune concernée (peut être null)
  final String? commune;

  /// Type d'accès demandé (lecture seule, téléchargement, etc.)
  final String typeAcces;

  /// Type de liste électorale (provisoire, définitive)
  final String typeList;

  /// Raison du refus (uniquement pour les demandes rejetées)
  final String? rejectReason;

  /// Lien vers la liste électorale (uniquement pour les demandes approuvées)
  final String? electoralListLink;

  /// Constructeur
  ElectoralRequest({
    required this.id,
    required this.status,
    required this.date,
    required this.motif,
    required this.annee,
    required this.district,
    this.region,
    this.departement,
    this.sousPrefecture,
    this.commune,
    required this.typeAcces,
    required this.typeList,
    this.rejectReason,
    this.electoralListLink,
  });

  /// Crée un objet ElectoralRequest à partir d'un Map JSON
  factory ElectoralRequest.fromJson(Map<String, dynamic> json) {
    // Conversion du statut depuis le string
    RequestStatus statusFromString(String? statusStr) {
      switch (statusStr) {
        case 'pending':
          return RequestStatus.pending;
        case 'approved':
          return RequestStatus.approved;
        case 'rejected':
          return RequestStatus.rejected;
        default:
          return RequestStatus.notRequested;
      }
    }

    return ElectoralRequest(
      id: json['id'].toString(),
      status: statusFromString(json['status']),
      date: json['date'],
      motif: json['motif'],
      annee: json['annee'],
      district: json['district'],
      region: json['region'],
      departement: json['departement'],
      sousPrefecture: json['sousPrefecture'],
      commune: json['commune'],
      typeAcces: json['typeAcces'],
      typeList: json['typeList'],
      rejectReason: json['rejectReason'],
      electoralListLink: json['electoralListLink'],
    );
  }

  /// Convertit l'objet en Map JSON
  Map<String, dynamic> toJson() {
    // Conversion du statut en string
    String statusToString(RequestStatus status) {
      switch (status) {
        case RequestStatus.pending:
          return 'pending';
        case RequestStatus.approved:
          return 'approved';
        case RequestStatus.rejected:
          return 'rejected';
        default:
          return 'notRequested';
      }
    }

    return {
      'id': id,
      'status': statusToString(status),
      'date': date,
      'motif': motif,
      'annee': annee,
      'district': district,
      'region': region,
      'departement': departement,
      'sousPrefecture': sousPrefecture,
      'commune': commune,
      'typeAcces': typeAcces,
      'typeList': typeList,
      'rejectReason': rejectReason,
      'electoralListLink': electoralListLink,
    };
  }
}