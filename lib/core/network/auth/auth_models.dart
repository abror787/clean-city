class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class RegisterRequest {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'phone': phone,
  };
}

class AuthResponse {
  final int id;
  final String token;
  final String email;
  final String role;

  AuthResponse({
    required this.id,
    required this.token,
    required this.email,
    required this.role,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      id: json['id'] ?? 0,
      token: json['token'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
