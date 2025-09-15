class ProductCandidate {
  final int rank;
  final String name;
  final double confidence;

  ProductCandidate({
    required this.rank,
    required this.name,
    required this.confidence,
  });

  factory ProductCandidate.fromJson(Map<String, dynamic> json) {
    return ProductCandidate(
      rank: json['rank'] ?? 0,
      name: json['name'] ?? '',
      confidence: (json['confidence'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'name': name,
      'confidence': confidence,
    };
  }
}