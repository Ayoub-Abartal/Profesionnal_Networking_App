part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class EmailRegistrationEvent extends AuthenticationEvent {
  final Map user;
  final Function() onSuccess;
  final Function(String) onError;
  const EmailRegistrationEvent(
      {required this.user, required this.onSuccess, required this.onError});

  @override
  List<Object> get props => [user, onSuccess, onError];
}

class PhoneRegistrationEvent extends AuthenticationEvent {
  final Map user;
  final Function(bool) onSuccess;
  final Function(String) onError;
  const PhoneRegistrationEvent(
      {required this.user, required this.onSuccess, required this.onError});

  @override
  List<Object> get props => [user, onSuccess, onError];
}

class EmailExistenceCheckEvent extends AuthenticationEvent {
  final String email;
  final Function(bool) onSuccess;
  final Function(String) onError;
  const EmailExistenceCheckEvent(
      {required this.email, required this.onSuccess, required this.onError});

  @override
  List<Object> get props => [email, onSuccess, onError];
}

class SignInVerificationEvent extends AuthenticationEvent {
  final LoginType loginType;
  final Map user;
  final Function(UserModel) onSuccess;
  final Function(String) onError;
  const SignInVerificationEvent(
      {required this.loginType,
      required this.user,
      required this.onSuccess,
      required this.onError});

  @override
  List<Object> get props => [loginType, user, onSuccess, onError];
}

class EmailLoginEvent extends AuthenticationEvent {
  final Map user;
  final Function onSuccess;
  final Function(String) onError;
  const EmailLoginEvent(
      {required this.user, required this.onSuccess, required this.onError});

  @override
  List<Object> get props => [user, onSuccess, onError];
}

class GoogleLoginEvent extends AuthenticationEvent {
  final Function(UserModel) onSuccess;
  final Function(String) onError;
  const GoogleLoginEvent({required this.onSuccess, required this.onError});

  @override
  List<Object> get props => [onSuccess, onError];
}

class FacebookLoginEvent extends AuthenticationEvent {
  final Function(UserModel) onSuccess;
  final Function(String) onError;
  const FacebookLoginEvent({required this.onSuccess, required this.onError});

  @override
  List<Object> get props => [onSuccess, onError];
}

class LinkedInLoginEvent extends AuthenticationEvent {
  final String token;

  final Function(UserModel) onSuccess;
  final Function(String) onError;
  const LinkedInLoginEvent(
      {required this.token, required this.onSuccess, required this.onError});

  @override
  List<Object> get props => [token, onSuccess, onError];
}

class RegisterFullNameEvent extends AuthenticationEvent {
  final Map fullName;
  final Function() onSuccess;
  final Function(String) onError;
  const RegisterFullNameEvent(
      {required this.onSuccess, required this.onError, required this.fullName});

  @override
  List<Object> get props => [fullName, onSuccess, onError];
}

class RegisterProfileEvent extends AuthenticationEvent {
  final Function onSuccess;
  final Function(String) onError;
  const RegisterProfileEvent({
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object> get props => [onSuccess, onError];
}

class UpdateProfileEvent extends AuthenticationEvent {
  final Map profile;
  final Function onSuccess;
  final Function(String) onError;
  const UpdateProfileEvent({
    required this.profile,
    required this.onSuccess,
    required this.onError,
  });

  @override
  List<Object> get props => [profile, onSuccess, onError];
}

class GetUserProfileEvent extends AuthenticationEvent {
  final Function(ProfileModel) onSuccess;
  final Function(String) onNotFound;
  const GetUserProfileEvent({
    required this.onSuccess,
    required this.onNotFound,
  });

  @override
  List<Object> get props => [onSuccess, onNotFound];
}
