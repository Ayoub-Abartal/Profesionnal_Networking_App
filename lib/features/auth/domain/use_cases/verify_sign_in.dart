import 'package:dartz/dartz.dart';
import 'package:metin/core/errors/error.dart';
import 'package:metin/core/use_case/use_case.dart';
import 'package:metin/features/auth/data/models/user_model.dart';
import 'package:metin/features/auth/domain/repositories/auth_repository.dart';

class VerifySignIn implements UseCase<UserModel, Map> {
  final AuthenticationRepository repository;

  VerifySignIn({required this.repository});

  @override
  Future<Either<Failure, UserModel>> call(Map<dynamic, dynamic> user) async {
    return await repository.verifySignIn(user);
  }
}
