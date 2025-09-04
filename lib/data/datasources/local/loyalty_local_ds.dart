import '../../../core/storage/kv_store.dart';

class LoyaltyLocalDS {
  final KVStore store;
  LoyaltyLocalDS(this.store);

  Future<void> cacheMember(String id, String json) => store.write('member_$id', json);
  Future<String?> getCachedMember(String id) => store.read('member_$id');
}
