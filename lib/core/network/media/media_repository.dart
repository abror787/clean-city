import 'dart:io';
import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';

/// Response from media upload API
class MediaUploadResponse {
  final String token;
  final String? url;

  MediaUploadResponse({required this.token, this.url});

  factory MediaUploadResponse.fromJson(Map<String, dynamic> json) {
    return MediaUploadResponse(token: json['token'] ?? '', url: json['url']);
  }
}

/// Repository for media upload operations
abstract class MediaRepository {
  /// Upload an image file and get a media token
  Future<MediaUploadResponse> uploadImage(File file);

  /// Get media content URL by token
  String getMediaUrl(String token);
}

class MediaRepositoryImpl implements MediaRepository {
  final Dio dio;

  MediaRepositoryImpl({required this.dio});

  @override
  Future<MediaUploadResponse> uploadImage(File file) async {
    try {
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await dio.post(
        ApiConstants.mediaUpload,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      return MediaUploadResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to upload image');
    }
  }

  @override
  String getMediaUrl(String token) {
    return '${ApiConstants.baseUrl}${ApiConstants.mediaContent}$token/content';
  }
}
