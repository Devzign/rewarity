// dart:io platforms (iOS/Android)
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'secure_store_stub.dart';

class SecureStoreIO implements SecureStore {
  final _s = const FlutterSecureStorage();
  @override Future<void> write(String k, String v) => _s.write(key: k, value: v);
  @override Future<String?> read(String k) => _s.read(key: k);
}
