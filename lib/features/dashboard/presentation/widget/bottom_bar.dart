import 'package:flutter/material.dart';
import '../pages/dashboard.dart';
import '../pages/report.dart';
import '../pages/schedule.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;

  static final List<Widget> _pages = [
    const HomeView(),
    const ScheduleView(),
    const ReportView(),
    const SizedBox.shrink(),
  ];

  void _openMenu() => showLoyaltyMenu(context);

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).padding;
    final cs = Theme.of(context).colorScheme;
    final active = cs.primary;
    final inactive = cs.onSurfaceVariant;

    return Scaffold(
      body: _pages[index],
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, pad.bottom == 0 ? 12 : pad.bottom),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 18, offset: const Offset(0, 8))],
          ),
          child: Row(
            children: [
              _NavItem(icon: Icons.home_rounded, label: 'Home', selected: index == 0, active: active, inactive: inactive, onTap: () => setState(() => index = 0)),
              _NavItem(icon: Icons.card_giftcard_rounded, label: 'Schemes', selected: index == 1, active: active, inactive: inactive, onTap: () => setState(() => index = 1)),
              _NavItem(icon: Icons.receipt_long_rounded, label: 'Orders', selected: index == 2, active: active, inactive: inactive, onTap: () => setState(() => index = 2)),
              _NavItem(icon: Icons.menu_rounded, label: 'Menu', selected: false, active: active, inactive: inactive, onTap: _openMenu),
            ],
          ),
        ),
      ),
      backgroundColor: cs.background,
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color active;
  final Color inactive;
  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap, required this.active, required this.inactive});

  @override
  Widget build(BuildContext context) {
    final color = selected ? active : inactive;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
          ]),
        ),
      ),
    );
  }
}

/// Floating bottom panel (wrap-content, not full-height)
void showLoyaltyMenu(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Menu',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 280),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, _, __) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
      final bottom = MediaQuery.of(ctx).padding.bottom;

      return Stack(
        children: [
          Positioned(
            left: 12,
            right: 12,
            bottom: 12 + bottom,
            child: FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(curved),
                child: const _LoyaltyMenuPanel(),
              ),
            ),
          ),
        ],
      );
    },
  );
}

class _LoyaltyMenuPanel extends StatelessWidget {
  const _LoyaltyMenuPanel();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final headerBg = cs.primary.withOpacity(0.08);
    final maxH = MediaQuery.of(context).size.height * 0.75;

    return Material(
      color: cs.surface,
      elevation: 16,
      borderRadius: BorderRadius.circular(22),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxH, minWidth: double.infinity),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 5,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(12)),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: headerBg, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  const CircleAvatar(radius: 24, backgroundImage: AssetImage('assets/images/profile.jpg')),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jane Marie Doe', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        SizedBox(height: 2),
                        Text('Loyalty ID: RV-10242', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.logout, size: 18, color: cs.error),
                    label: Text('Sign out', style: TextStyle(color: cs.error)),
                  ),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                children: const [
                  _MenuRow(icon: Icons.dashboard_outlined, label: 'Dashboard'),
                  _MenuRow(icon: Icons.card_giftcard_outlined, label: 'Rewards & Offers'),
                  _MenuRow(icon: Icons.star_border_rounded, label: 'Loyalty Points'),
                  _MenuRow(icon: Icons.history, label: 'Transaction History'),
                  _MenuRow(icon: Icons.people_outline, label: 'Referrals'),
                  Divider(height: 16),
                  _MenuRow(icon: Icons.policy_outlined, label: 'Privacy Policy'),
                  _MenuRow(icon: Icons.article_outlined, label: 'Terms & Conditions'),
                  _MenuRow(icon: Icons.support_agent_outlined, label: 'Help & Support'),
                  _MenuRow(icon: Icons.settings_outlined, label: 'Settings'),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MenuRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      dense: true,
      leading: Icon(icon, size: 22, color: cs.onSurface),
      title: Text(label, style: TextStyle(fontSize: 15, color: cs.onSurface)),
      onTap: () => Navigator.pop(context),
    );
  }
}
