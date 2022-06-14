part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoaded extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLogged extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  @override
  List<Object> get props => [];
}
