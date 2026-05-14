import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _nameKey = 'user_name';
  static const _usernameKey = 'user_username';

  static Future<void> saveSession({
    required String token,
    required String name,
    required String username,
  }) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _nameKey, value: name);
    await _storage.write(key: _usernameKey, value: username);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<String?> getName() async {
    return await _storage.read(key: _nameKey);
  }

  static Future<String?> getUsername() async {
    return await _storage.read(key: _usernameKey);
  }

  static Future<void> clearSession() async {
    await _storage.deleteAll();
  }
}