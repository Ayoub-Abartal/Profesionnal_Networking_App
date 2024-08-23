import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String msg;
  const Failure({required this.msg});
  final List properties = const <dynamic>[];

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {
  const ServerFailure({required String msg}) : super(msg: msg);
  @override
  List<Object> get props => [msg];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String msg}) : super(msg: msg);
  @override
  List<Object> get props => [msg];
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({required String msg}) : super(msg: msg);
  @override
  List<Object> get props => [msg];
}
