import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:metin/core/errors/exceptions.dart';
import 'package:metin/features/auth/data/models/profile_model.dart';
import 'package:metin/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDataSource {
  /// Gets the user token and id stored in the cache.
  Future<Map> getLoggedUser();

  /// Store the newly logged user's token and id
  Future<void> cacheLoggedUser(UserModel userToCache);

  /// Store the newly logged user's profile id
  Future<void> cacheUserProfile(ProfileModel profileToCache);

  /// Gets the user profile id stored in the cache.
  Map getUserCachedProfile();
}

// const storage = FlutterSecureStorage();
// await storage.write(key: "token", value: user.accessToken);
const cachedAccessTokenKey = 'token';
const cachedIDKey = 'id';
const cachedProfileIdKey = 'profileId';

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  AuthenticationLocalDataSourceImpl({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  @override
  Future<Map> getLoggedUser() async {
    final Map cachedData = {
      'token': await secureStorage.read(key: cachedAccessTokenKey),
      'id': await secureStorage.read(key: cachedIDKey)
    };
    if (cachedData['token'] != null) {
      return Future.value(cachedData);
    } else {
      throw const CacheException(msg: "Cache is empty, must login first");
    }
  }

  @override
  Future<void> cacheLoggedUser(UserModel userToCache) async {
    await secureStorage.write(
      key: cachedAccessTokenKey,
      value: userToCache.accessToken,
    );
    await secureStorage.write(
      key: cachedIDKey,
      value: userToCache.user.id.toString(),
    );
  }

  @override
  Future<void> cacheUserProfile(ProfileModel profileToCache) async {
    await sharedPreferences.setInt(cachedProfileIdKey, profileToCache.id);
  }

  @override
  Map getUserCachedProfile() {
    final Map cachedData = {
      'id': sharedPreferences.getInt(cachedProfileIdKey),
    };

    if (cachedData['id'] != null) {
      return cachedData;
    } else {
      throw const CacheException(msg: "Cache is empty");
    }
  }
}
