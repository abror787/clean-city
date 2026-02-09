import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/api_constants.dart';
import 'auth_models.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String email, String password);
  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phone,
  );
  Future<void> logout();
  Future<bool> isAuthenticated();
  Future<String?> getUserRole();
  Future<String?> getUserId();
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  static const String _tokenKey = 'auth_token';
  static const String _roleKey = 'user_role';
  static const String _userIdKey = 'user_id';

  AuthRepositoryImpl({required this.dio, required this.sharedPreferences});

  @override
  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: LoginRequest(email: email, password: password).toJson(),
      );

      final authResponse = AuthResponse.fromJson(response.data);

      // Map backend roles to app roles
      // Backend returns: USER, DRIVER, ADMIN
      // App expects: resident, driver
      final mappedRole = _mapRole(authResponse.role);

      await sharedPreferences.setString(_tokenKey, authResponse.token);
      await sharedPreferences.setString(_roleKey, mappedRole);
      await sharedPreferences.setString(_userIdKey, authResponse.id.toString());

      return AuthResponse(
        id: authResponse.id,
        token: authResponse.token,
        email: authResponse.email,
        role: mappedRole,
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }

  /// Maps backend roles to app-friendly roles
  String _mapRole(String backendRole) {
    switch (backendRole.toUpperCase()) {
      case 'USER':
      case 'RESIDENT':
        return 'resident';
      case 'DRIVER':
        return 'driver';
      case 'ADMIN':
        return 'admin';
      default:
        return 'resident'; // Default to resident
    }
  }

  @override
  Future<void> register(
    String email,
    String password,
    String firstName,
    String lastName,
    String phone,
  ) async {
    try {
      await dio.post(
        ApiConstants.register,
        data: RegisterRequest(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
        ).toJson(),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Registration failed');
    }
  }

  @override
  Future<void> logout() async {
    await sharedPreferences.remove(_tokenKey);
    await sharedPreferences.remove(_roleKey);
    await sharedPreferences.remove(_userIdKey);
  }

  @override
  Future<bool> isAuthenticated() async {
    return sharedPreferences.getString(_tokenKey) != null;
  }

  @override
  Future<String?> getUserRole() async {
    return sharedPreferences.getString(_roleKey);
  }

  @override
  Future<String?> getUserId() async {
    return sharedPreferences.getString(_userIdKey);
  }
}
