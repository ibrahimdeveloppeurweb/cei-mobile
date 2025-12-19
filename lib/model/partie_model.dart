class Partie {
  final int? id;
  final String? name;
  final String? sigle;
  final String? siege;
  final DateTime? dateC;

  Partie({
    this.id,
    this.name,
    this.sigle,
    this.siege,
    this.dateC,
  });

  factory Partie.fromJson(Map<String, dynamic> json) {
    return Partie(
      id: json['id'],
      name: json['name'],
      sigle: json['sigle'],
      siege: json['siege'],
      dateC: json['dateC'] != null ? DateTime.parse(json['dateC']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sigle': sigle,
      'siege': siege,
      'dateC': dateC?.toIso8601String(),
    };
  }

  @override
  String toString() => name ?? 'Parti inconnu';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Partie && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}