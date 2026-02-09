part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, loading, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final String? role;
  final String? errorMessage;

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.role,
    this.errorMessage,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(String role)
      : this._(status: AuthStatus.authenticated, role: role);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);
      
  const AuthState.loading()
      : this._(status: AuthStatus.loading);

  const AuthState.error(String message)
      : this._(status: AuthStatus.error, errorMessage: message);

  @override
  List<Object?> get props => [status, role, errorMessage];
}
