import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:metin/core/network/network_info.dart';
import 'package:metin/features/auth/data/data_sources/auth_data_source.dart';
import 'package:metin/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:metin/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:metin/features/auth/domain/repositories/auth_repository.dart';
import 'package:metin/features/auth/domain/use_cases/get_user_profile.dart';
import 'package:metin/features/auth/domain/use_cases/login_email.dart';
import 'package:metin/features/auth/domain/use_cases/login_facebook.dart';
import 'package:metin/features/auth/domain/use_cases/login_linked_in.dart';
import 'package:metin/features/auth/domain/use_cases/register_email.dart';
import 'package:metin/features/auth/domain/use_cases/register_full_name.dart';
import 'package:metin/features/auth/domain/use_cases/register_phone.dart';
import 'package:metin/features/auth/domain/use_cases/register_profile.dart';
import 'package:metin/features/auth/domain/use_cases/update_profile.dart';
import 'package:metin/features/auth/domain/use_cases/verify_existence_email.dart';
import 'package:metin/features/auth/domain/use_cases/verify_sign_in.dart';
import 'package:metin/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/domain/use_cases/login_google.dart';

// sl = service locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Authentication
  // BLoC
  sl.registerFactory(
    () => AuthenticationBloc(
      emailLogin: sl(),
      googleLogin: sl(),
      facebookLogin: sl(),
      linkedInLogin: sl(),
      registerEmail: sl(),
      verifySignIn: sl(),
      registerPhone: sl(),
      verifyUserExistenceEmail: sl(),
      registerFullName: sl(),
      registerProfile: sl(),
      getUserProfile: sl(),
      updateUserProfile: sl(),
    ),
  );

  // User cases
  sl.registerLazySingleton(
    () => EmailLogin(repository: sl()),
  );
  sl.registerLazySingleton(
    () => GoogleLogin(repository: sl()),
  );
  sl.registerLazySingleton(
    () => FacebookLogin(repository: sl()),
  );
  sl.registerLazySingleton(
    () => RegisterEmail(repository: sl()),
  );
  sl.registerLazySingleton(
    () => RegisterPhone(repository: sl()),
  );
  sl.registerLazySingleton(
    () => VerifySignIn(repository: sl()),
  );
  sl.registerLazySingleton(
    () => VerifyUserExistenceEmail(repository: sl()),
  );
  sl.registerLazySingleton(
    () => RegisterFullName(repository: sl()),
  );
  sl.registerLazySingleton(
    () => RegisterProfile(repository: sl()),
  );
  sl.registerLazySingleton(
    () => LinkedInLogin(repository: sl()),
  );
  sl.registerLazySingleton(
    () => GetUserProfile(repository: sl()),
  );
  sl.registerLazySingleton(
    () => UpdateProfile(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authDataSource: sl(),
      localAuthDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthenticationDataSource>(
      () => AuthenticationDataSourceImpl());

  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl(
            secureStorage: sl(),
            sharedPreferences: sl(),
          ));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());

  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
}
