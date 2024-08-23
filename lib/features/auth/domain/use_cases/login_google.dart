import 'package:dartz/dartz.dart';
import 'package:metin/core/errors/error.dart';
import 'package:metin/core/use_case/use_case.dart';
import 'package:metin/features/auth/data/models/user_model.dart';
import 'package:metin/features/auth/domain/repositories/auth_repository.dart';

class GoogleLogin implements UseCase<UserModel, NoParams> {
  final AuthenticationRepository repository;

  GoogleLogin({required this.repository});

  @override
  Future<Either<Failure, UserModel>> call(NoParams noParams) async {
    return await repository.loginGoogle();
  }
}
