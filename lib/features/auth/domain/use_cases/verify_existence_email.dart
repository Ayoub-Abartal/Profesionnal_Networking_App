import 'package:dartz/dartz.dart';
import 'package:metin/core/errors/error.dart';
import 'package:metin/core/use_case/use_case.dart';
import 'package:metin/features/auth/domain/repositories/auth_repository.dart';

class VerifyUserExistenceEmail implements UseCase<bool, String> {
  final AuthenticationRepository repository;

  const VerifyUserExistenceEmail({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(
    String email,
  ) async {
    return await repository.checkUserExistenceEmail(email);
  }
}
