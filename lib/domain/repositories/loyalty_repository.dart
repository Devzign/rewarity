import '../entities/member.dart';

abstract class LoyaltyRepository {
  Future<Member> fetchMember(String id);
  Future<Member> earnPoints(String id, int delta, {String? reason});
  Future<List<String>> listRewards(); // ids or names
  Future<bool> redeem(String id, String rewardId);
}
