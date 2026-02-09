import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';

class UserProfile {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final String? phone;

  UserProfile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.phone,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      role: json['role'] ?? '',
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }
}

abstract class ProfileRepository {
  Future<UserProfile> getProfile(int id);
  Future<UserProfile> updateProfile(int id, String firstName, String lastName);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final Dio dio;

  ProfileRepositoryImpl({required this.dio});

  @override
  Future<UserProfile> getProfile(int id) async {
    try {
      final response = await dio.get('${ApiConstants.users}$id');
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch profile');
    }
  }

  @override
  Future<UserProfile> updateProfile(int id, String firstName, String lastName) async {
    try {
      final response = await dio.put(
        '${ApiConstants.users}$id',
        data: {
          'firstName': firstName,
          'lastName': lastName,
        },
      );
      return UserProfile.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to update profile');
    }
  }
}
