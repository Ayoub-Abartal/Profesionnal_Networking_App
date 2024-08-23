import 'package:dartz/dartz.dart';
import 'package:metin/core/errors/error.dart';
import 'package:metin/core/use_case/use_case.dart';
import 'package:metin/features/auth/domain/repositories/auth_repository.dart';

class RegisterEmail implements UseCase<bool, Map> {
  final AuthenticationRepository repository;

  RegisterEmail({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Map credentials) async {
    return await repository.registerEmail(credentials);
  }
}
