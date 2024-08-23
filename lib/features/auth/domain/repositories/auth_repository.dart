import 'package:dartz/dartz.dart';
import 'package:metin/core/errors/error.dart';
import 'package:metin/features/auth/data/models/profile_model.dart';
import 'package:metin/features/auth/data/models/user_model.dart';

abstract class AuthenticationRepository {
  // Check the return type
  Future<Either<Failure, bool>> checkUserExistenceEmail(String email);
  Future<Either<Failure, bool>> registerEmail(Map user);
  Future<Either<Failure, bool>> registerPhone(Map user);
  Future<Either<Failure, UserModel>> verifySignIn(Map user);

  Future<Either<Failure, UserModel>> loginEmail(Map user);
  Future<Either<Failure, UserModel>> loginGoogle();
  Future<Either<Failure, UserModel>> loginFacebook();
  Future<Either<Failure, UserModel>> loginLinkedIn(String token);

  Future<Either<Failure, bool>> registerFullName(Map name);
  Future<Either<Failure, ProfileModel>> registerProfile();
  Future<Either<Failure, ProfileModel>> updateProfile(Map info);
  Future<Either<Failure, ProfileModel>> getUserProfile();
}
