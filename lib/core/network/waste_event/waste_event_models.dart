/// Waste Report Request - matches Swagger WasteReportRequest schema
class WasteReportRequest {
  final String category;
  final String description;
  final double latitude;
  final double longitude;
  final String? mediaToken;

  WasteReportRequest({
    required this.category,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.mediaToken,
  });

  Map<String, dynamic> toJson() => {
    'category': category,
    'description': description,
    'latitude': latitude,
    'longitude': longitude,
    if (mediaToken != null) 'mediaToken': mediaToken,
  };

  // Getter for backward compatibility
  String get title => category;
}

/// Public Waste Event Response - matches Swagger PublicWasteEventResponse schema
class PublicWasteEventResponse {
  final String publicId;
  final String category;
  final String description;
  final double latitude;
  final double longitude;
  final String status;
  final String? reportedAt;
  final String? imageUrl;
  final List<String> mediaTokens;

  PublicWasteEventResponse({
    required this.publicId,
    required this.category,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.status,
    this.reportedAt,
    this.imageUrl,
    this.mediaTokens = const [],
  });

  factory PublicWasteEventResponse.fromJson(Map<String, dynamic> json) {
    return PublicWasteEventResponse(
      publicId: json['publicId']?.toString() ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      reportedAt: json['reportedAt'],
      imageUrl: json['imageUrl'],
      mediaTokens:
          (json['mediaTokens'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  // Getters for backward compatibility with existing UI
  String get id => publicId;
  String get title => category;
  String get createdAt => reportedAt ?? '';
  String? get mediaToken => mediaTokens.isNotEmpty ? mediaTokens.first : null;
  String get reporterEmail => ''; // Not available in public response
}
