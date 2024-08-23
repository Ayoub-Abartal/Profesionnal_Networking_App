import 'package:dartz/dartz.dart';
import 'package:metin/core/errors/error.dart';
import 'package:metin/core/use_case/use_case.dart';
import 'package:metin/features/auth/domain/repositories/auth_repository.dart';

class RegisterPhone implements UseCase<bool, Map> {
  final AuthenticationRepository repository;

  RegisterPhone({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Map credentials) async {
    return await repository.registerPhone(credentials);
  }
}
