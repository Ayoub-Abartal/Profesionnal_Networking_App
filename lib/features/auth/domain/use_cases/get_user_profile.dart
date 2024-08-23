import 'package:dartz/dartz.dart';
import 'package:metin/core/errors/error.dart';
import 'package:metin/core/use_case/use_case.dart';
import 'package:metin/features/auth/data/models/profile_model.dart';
import 'package:metin/features/auth/domain/repositories/auth_repository.dart';

class GetUserProfile implements UseCase<ProfileModel, NoParams> {
  final AuthenticationRepository repository;

  const GetUserProfile({
    required this.repository,
  });

  @override
  Future<Either<Failure, ProfileModel>> call(NoParams noParams) async {
    return await repository.getUserProfile();
  }
}
