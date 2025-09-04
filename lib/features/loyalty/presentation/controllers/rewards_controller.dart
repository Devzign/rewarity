import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/repositories/loyalty_repository.dart';
import '../../../../domain/entities/member.dart';

import '../../../../core/di/locator.dart';

class RewardsState {
  final AsyncValue<Member> member;
  final AsyncValue<List<String>> rewards;
  const RewardsState({required this.member, required this.rewards});

  RewardsState copyWith({AsyncValue<Member>? member, AsyncValue<List<String>>? rewards}) =>
      RewardsState(member: member ?? this.member, rewards: rewards ?? this.rewards);

  factory RewardsState.initial() =>
      const RewardsState(member: AsyncValue.loading(), rewards: AsyncValue.loading());
}

class RewardsController extends StateNotifier<RewardsState> {
  final LoyaltyRepository repo;
  final String memberId;

  RewardsController({required this.repo, required this.memberId}) : super(RewardsState.initial()) {
    load();
  }

  Future<void> load() async {
    state = state.copyWith(member: const AsyncValue.loading(), rewards: const AsyncValue.loading());
    try {
      final m = await repo.fetchMember(memberId);
      final r = await repo.listRewards();
      state = state.copyWith(member: AsyncValue.data(m), rewards: AsyncValue.data(r));
    } catch (e, st) {
      state = state.copyWith(member: AsyncValue.error(e, st), rewards: AsyncValue.error(e, st));
    }
  }

  Future<void> earn(int points) async {
    try {
      final updated = await repo.earnPoints(memberId, points, reason: 'Daily streak');
      state = state.copyWith(member: AsyncValue.data(updated));
    } catch (e, st) {
      state = state.copyWith(member: AsyncValue.error(e, st));
    }
  }
}



final loyaltyRepoProvider = Provider<LoyaltyRepository>((_) => sl<LoyaltyRepository>());

final rewardsControllerProvider = StateNotifierProvider.family<RewardsController, RewardsState, String>(
      (ref, memberId) => RewardsController(repo: ref.read(loyaltyRepoProvider), memberId: memberId),
);

