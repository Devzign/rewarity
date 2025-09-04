import '../../../core/network/api_client.dart';

class LoyaltyRemoteDS {
  final ApiClient api;
  LoyaltyRemoteDS(this.api);

  Future<Map<String, dynamic>> getMemberRaw(String id) async {
    final res = await api.get<Map<String, dynamic>>('/members/$id');
    return res.data ?? {};
  }

  Future<Map<String, dynamic>> earnRaw(String id, int delta, {String? reason}) async {
    final res = await api.post<Map<String, dynamic>>('/members/$id/earn', data: {'points': delta, 'reason': reason});
    return res.data ?? {};
  }

  Future<List<dynamic>> listRewardsRaw() async {
    final res = await api.get<List<dynamic>>('/rewards');
    return res.data ?? [];
  }

  Future<bool> redeemRaw(String id, String rewardId) async {
    final res = await api.post<Map<String, dynamic>>('/members/$id/redeem', data: {'rewardId': rewardId});
    return (res.data?['ok'] ?? false) as bool;
  }
}
