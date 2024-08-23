import 'package:dartz/dartz.dart';
import 'package:metin/core/errors/error.dart';
import 'package:metin/core/errors/exceptions.dart';
import 'package:metin/core/network/network_info.dart';
import 'package:metin/features/auth/data/data_sources/auth_data_source.dart';
import 'package:metin/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:metin/features/auth/data/models/profile_model.dart';
import 'package:metin/features/auth/data/models/user_model.dart';
import 'package:metin/features/auth/domain/repositories/auth_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource authDataSource;
  final AuthenticationLocalDataSource localAuthDataSource;
  final NetworkInfo networkInfo;

  AuthenticationRepositoryImpl({
    required this.authDataSource,
    required this.localAuthDataSource,
    required this.networkInfo,
  });

  Future<Either<Failure, UserModel>> _loginUser(
      Future<UserModel> Function() loginMethod) async {
    if (await networkInfo.isConnected) {
      try {
        final loggedUser = await loginMethod();
        localAuthDataSource.cacheLoggedUser(loggedUser);
        return Right(loggedUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(msg: e.msg));
      } on AuthenticationException catch (e) {
        return Left(AuthenticationFailure(msg: e.msg));
      }
    } else {
      return const Left(NetworkFailure(msg: "There is no internet connection"));
    }
  }

  Future<Either<Failure, bool>> _isUserRegistered(
      Future<bool> Function() registerMethod) async {
    if (await networkInfo.isConnected) {
      try {
        final isRegistered = await registerMethod();
        return Right(isRegistered);
      } on ServerException catch (e) {
        return Left(ServerFailure(msg: e.msg));
      } on AuthenticationException catch (e) {
        return Left(AuthenticationFailure(msg: e.msg));
      }
    } else {
      return const Left(NetworkFailure(msg: "There is no internet connection"));
    }
  }

  Future<Either<Failure, ProfileModel>> _getUserProfile(
      Future<ProfileModel> Function() getProfileMethod) async {
    if (await networkInfo.isConnected) {
      try {
        final registeredProfile = await getProfileMethod();
        localAuthDataSource.cacheUserProfile(registeredProfile);
        return Right(registeredProfile);
      } on ServerException catch (e) {
        return Left(ServerFailure(msg: e.msg));
      } on AuthenticationException catch (e) {
        return Left(AuthenticationFailure(msg: e.msg));
      }
    } else {
      return const Left(NetworkFailure(msg: "There is no internet connection"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginEmail(
      Map<dynamic, dynamic> user) async {
    return await _loginUser(() => authDataSource.loginEmail(user));
  }

  @override
  Future<Either<Failure, UserModel>> loginFacebook() async {
    return await _loginUser(() => authDataSource.loginFacebook());
  }

  @override
  Future<Either<Failure, UserModel>> loginGoogle() async {
    return await _loginUser(() => authDataSource.loginGoogle());
  }

  @override
  Future<Either<Failure, UserModel>> loginLinkedIn(String token) async {
    return await _loginUser(() => authDataSource.loginLinkedIn(token));
  }

  @override
  Future<Either<Failure, bool>> registerEmail(
      Map<dynamic, dynamic> user) async {
    return await _isUserRegistered(() => authDataSource.registerEmail(user));
  }

  @override
  Future<Either<Failure, bool>> registerPhone(
      Map<dynamic, dynamic> user) async {
    return await _isUserRegistered(() => authDataSource.registerPhone(user));
  }

  @override
  Future<Either<Failure, UserModel>> verifySignIn(Map user) async {
    return await _loginUser(() => authDataSource.verifySignIn(user));
  }

  @override
  Future<Either<Failure, bool>> checkUserExistenceEmail(String email) async {
    return await _isUserRegistered(
        () => authDataSource.checkUserExistenceEmail(email));
  }

  @override
  Future<Either<Failure, bool>> registerFullName(
      Map<dynamic, dynamic> name) async {
    return await _isUserRegistered(() => authDataSource.registerFullName(name));
  }

  @override
  Future<Either<Failure, ProfileModel>> registerProfile() async {
    Map loggedUser = await localAuthDataSource.getLoggedUser();

    Map userInfo = {"token": loggedUser[cachedAccessTokenKey]};

    return await _getUserProfile(
        () => authDataSource.registerProfile(userInfo));
  }

  @override
  Future<Either<Failure, ProfileModel>> getUserProfile() async {
    Map loggedUser = await localAuthDataSource.getLoggedUser();

    String token = loggedUser[cachedAccessTokenKey];

    return await _getUserProfile(() => authDataSource.getUserProfile(token));
  }

  @override
  Future<Either<Failure, ProfileModel>> updateProfile(
      Map<dynamic, dynamic> info) async {
    Map cachedProfile = localAuthDataSource.getUserCachedProfile();

    Map profileData = info;

    profileData['id'] = cachedProfile['id'];
    return await _getUserProfile(
        () => authDataSource.updateProfile(profileData));
  }
}
