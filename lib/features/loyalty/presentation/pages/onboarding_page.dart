import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  void _next() {
    if (_index < 2) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      context.go('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // top skip
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.go('/dashboard'),
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _index = i),
                children: const [
                  _SplashSlide(
                    title: 'Rewarity',
                    subtitle: 'Loyalty made lovable',
                    // Tip: put your logo here
                    asset: 'assets/illustrations/logo.png',
                  ),
                  _BrandSlide(
                    title: 'Rewards that matter',
                    subtitle: 'Delight users with tiers, points, and perks',
                    asset: 'assets/illustrations/gradient_card.png',
                  ),
                  _FeaturesGridSlide(), // the 4-image single page + CTA
                ],
              ),
            ),
            const SizedBox(height: 8),
            _Dots(count: 3, index: _index),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _next,
                  child: Text(_index < 2 ? 'Next' : 'Get Started'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SplashSlide extends StatelessWidget {
  final String title;
  final String subtitle;
  final String asset;
  const _SplashSlide({required this.title, required this.subtitle, required this.asset});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          // Logo / hero
          Flexible(
            flex: 6,
            child: Center(
              child: Image.asset(asset, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 24),
          Text(title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: cs.primary)),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(fontSize: 16, color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

class _BrandSlide extends StatelessWidget {
  final String title;
  final String subtitle;
  final String asset;
  const _BrandSlide({required this.title, required this.subtitle, required this.asset});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                children: [
                  Positioned.fill(child: Image.asset(asset, fit: BoxFit.cover)),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    right: 20,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: cs.onPrimary,
                        shadows: const [Shadow(blurRadius: 10, color: Colors.black45)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: TextStyle(fontSize: 16, color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

/// The requested single page that shows 4 images and a CTA button.
/// Replace the asset placeholders with your illustrations.
class _FeaturesGridSlide extends StatelessWidget {
  const _FeaturesGridSlide();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final items = const [
      _FeatureItem('Earn', 'assets/illustrations/earn.png', 'Earn points on each purchase'),
      _FeatureItem('Redeem', 'assets/illustrations/redeem.png', 'Redeem across partners'),
      _FeatureItem('Tiers', 'assets/illustrations/tiers.png', 'Silver • Gold • Platinum'),
      _FeatureItem('Referrals', 'assets/illustrations/referral.png', 'Invite & get rewarded'),
    ];

    // 2x2 grid, responsive
    return LayoutBuilder(
      builder: (context, c) {
        final isWide = c.maxWidth >= 700;
        final crossAxisCount = isWide ? 4 : 2;
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text('Rewarity Features', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: isWide ? 0.85 : 0.9,
                  ),
                  itemBuilder: (_, i) => _FeatureCard(item: items[i], color: cs.primaryContainer),
                ),
              ),
              // CTA rendered by the outer page as the main button; keeping a secondary here is optional.
            ],
          ),
        );
      },
    );
  }
}

class _FeatureItem {
  final String title;
  final String asset;
  final String desc;
  const _FeatureItem(this.title, this.asset, this.desc);
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem item;
  final Color color;
  const _FeatureCard({required this.item, required this.color});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(child: Image.asset(item.asset, fit: BoxFit.contain)),
            const SizedBox(height: 8),
            Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(item.desc, style: TextStyle(color: cs.onSurfaceVariant), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int count;
  final int index;
  const _Dots({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
            (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: i == index ? 22 : 8,
          decoration: BoxDecoration(
            color: i == index ? cs.primary : cs.outlineVariant,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      ),
    );
  }
}
