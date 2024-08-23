part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationStateInitial extends AuthenticationState {
  const AuthenticationStateInitial();
}

class AuthenticationLoading extends AuthenticationState {
  final LoginType loginType;
  const AuthenticationLoading({required this.loginType});

  @override
  List<Object> get props => [loginType];
}

class AuthenticationVerification extends AuthenticationState {
  final LoginType loginType;
  const AuthenticationVerification({required this.loginType});

  @override
  List<Object> get props => [loginType];
}

class CreatingUserProfile extends AuthenticationState {
  const CreatingUserProfile();

  @override
  List<Object> get props => [];
}

class AuthenticationEnded extends AuthenticationState {
  const AuthenticationEnded();

  @override
  List<Object> get props => [];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError({required this.message});

  @override
  List<Object> get props => [message];
}
