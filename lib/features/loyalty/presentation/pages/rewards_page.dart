import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/rewards_controller.dart';

class RewardsPage extends ConsumerWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rewardsControllerProvider('member-001'));

    return Scaffold(
      appBar: AppBar(title: const Text('Your Rewards')),
      body: state.member.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (member) => Column(
          children: [
            ListTile(title: Text(member.name), subtitle: Text('Points: ${member.points}')),
            const Divider(),
            Expanded(
              child: state.rewards.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (rewards) => ListView.builder(
                  itemCount: rewards.length,
                  itemBuilder: (_, i) => ListTile(
                    title: Text(rewards[i]),
                    trailing: ElevatedButton(
                      onPressed: () => ref.read(rewardsControllerProvider('member-001').notifier)
                          .earn(10),
                      child: const Text('Earn +10'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
