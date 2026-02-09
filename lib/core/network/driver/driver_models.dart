/// Driver Task Summary - matches Swagger DriverTaskSummary schema
class DriverTaskSummary {
  final String taskId;
  final String addressSummary;
  final String priority;
  final String status;

  DriverTaskSummary({
    required this.taskId,
    required this.addressSummary,
    required this.priority,
    required this.status,
  });

  factory DriverTaskSummary.fromJson(Map<String, dynamic> json) {
    return DriverTaskSummary(
      taskId: json['taskId']?.toString() ?? '',
      addressSummary: json['addressSummary'] ?? '',
      priority: json['priority'] ?? 'NORMAL',
      status: json['status'] ?? '',
    );
  }

  // Getter for backward compatibility in UI
  String get id => taskId;
  String get title => addressSummary;
  String get createdAt => '';
}

/// Driver Task Detail - matches Swagger DriverTaskDetail schema
class DriverTaskDetail {
  final String taskId;
  final String description;
  final double latitude;
  final double longitude;
  final String status;
  final String? reportedAt;
  final List<String> mediaUrls;
  final List<String> mediaTokens;
  final String? reporterNote;

  DriverTaskDetail({
    required this.taskId,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.status,
    this.reportedAt,
    this.mediaUrls = const [],
    this.mediaTokens = const [],
    this.reporterNote,
  });

  factory DriverTaskDetail.fromJson(Map<String, dynamic> json) {
    return DriverTaskDetail(
      taskId: json['taskId']?.toString() ?? '',
      description: json['description'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      reportedAt: json['reportedAt'],
      mediaUrls:
          (json['mediaUrls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      mediaTokens:
          (json['mediaTokens'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      reporterNote: json['reporterNote'],
    );
  }

  // Getter for backward compatibility in UI
  String get id => taskId;
  String get title => description;
  String? get mediaToken => mediaTokens.isNotEmpty ? mediaTokens.first : null;
}

/// Complete Task Request - matches Swagger CompleteTaskRequest schema
class CompleteTaskRequest {
  final String? mediaToken;

  CompleteTaskRequest({this.mediaToken});

  Map<String, dynamic> toJson() => {
    if (mediaToken != null) 'mediaToken': mediaToken,
  };
}
