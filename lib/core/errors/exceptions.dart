class ServerException implements Exception {
  final String msg;

  const ServerException({required this.msg});
}

class NetworkException implements Exception {
  final String msg;

  const NetworkException({required this.msg});
}

class CacheException implements Exception {
  final String msg;

  const CacheException({required this.msg});
}

class AuthenticationException implements Exception {
  final String msg;

  const AuthenticationException({required this.msg});
}
