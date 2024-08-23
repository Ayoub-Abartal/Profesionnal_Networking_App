import 'package:equatable/equatable.dart';
import 'package:metin/features/auth/data/models/user_model.dart';

class LoggedUser extends Equatable {
  const LoggedUser({
    required this.id,
    required this.name,
    required this.email,
    required this.isConfirmed,
    required this.phone,
    required this.phoneCode,
    required this.isActive,
  });
  final int id;
  final String name;
  final String email;
  final bool isConfirmed;
  final String phone;
  final PhoneCode phoneCode;
  final bool isActive;

  @override
  List<Object> get props => [
        id,
        name,
        email,
        isConfirmed,
        phone,
        phoneCode,
        isActive,
      ];
}
