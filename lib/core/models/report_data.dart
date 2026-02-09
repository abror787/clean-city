import 'dart:io';

/// Data class to hold all report information as it flows through screens
class ReportData {
  final File? imageFile;
  final String? category;
  final double? latitude;
  final double? longitude;
  final String? description;

  const ReportData({
    this.imageFile,
    this.category,
    this.latitude,
    this.longitude,
    this.description,
  });

  /// Creates a copy with updated fields
  ReportData copyWith({
    File? imageFile,
    String? category,
    double? latitude,
    double? longitude,
    String? description,
  }) {
    return ReportData(
      imageFile: imageFile ?? this.imageFile,
      category: category ?? this.category,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      description: description ?? this.description,
    );
  }
}
