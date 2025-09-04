
import 'dart:html' as html;
import 'secure_store_stub.dart';

class SecureStoreWeb implements SecureStore {
  @override Future<void> write(String k, String v) async => html.window.localStorage[k] = v;
  @override Future<String?> read(String k) async => html.window.localStorage[k];
}
