import '../repositories/loyalty_repository.dart';
import '../entities/member.dart';

class EarnPoints {
  final LoyaltyRepository repo;
  EarnPoints(this.repo);
  Future<Member> call({required String memberId, required int points, String? reason}) {
    return repo.earnPoints(memberId, points, reason: reason);
  }
}
