import 'dart:convert';
import '../../domain/entities/member.dart';
import '../../domain/repositories/loyalty_repository.dart';
import '../datasources/local/loyalty_local_ds.dart';
import '../datasources/remote/loyalty_remote_ds.dart';

class LoyaltyRepositoryImpl implements LoyaltyRepository {
  final LoyaltyRemoteDS remote;
  final LoyaltyLocalDS local;

  LoyaltyRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Member> fetchMember(String id) async {
    final cached = await local.getCachedMember(id);
    if (cached != null) {
      return Member.fromJson(jsonDecode(cached));
    }
    final raw = await remote.getMemberRaw(id);
    final member = Member.fromJson(raw);
    await local.cacheMember(id, jsonEncode(member.toJson()));
    return member;
    // LSP: Replacement respects interface contract; no surprises.
  }

  @override
  Future<Member> earnPoints(String id, int delta, {String? reason}) async {
    final raw = await remote.earnRaw(id, delta, reason: reason);
    final member = Member.fromJson(raw);
    await local.cacheMember(id, jsonEncode(member.toJson()));
    return member;
  }

  @override
  Future<List<String>> listRewards() async {
    final list = await remote.listRewardsRaw();
    return list.map((e) => e.toString()).toList();
  }

  @override
  Future<bool> redeem(String id, String rewardId) => remote.redeemRaw(id, rewardId);
}
