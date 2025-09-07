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
                    subtitle: 'Loyalty made lovable',
                    // Tip: put your logo here
                    asset: 'assets/illustrations/logo.png',
                  ),
                  _BrandSlide(
                    title: 'Rewards that matter',
                    subtitle: 'Delight users with tiers, points, and perks',
                    asset: 'assets/illustrations/gradient_card.png',
                  ),
                  FeaturesGridSlide(),
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
  final String subtitle;
  final String asset;
  const _SplashSlide({ required this.subtitle, required this.asset});

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

class FeaturesGridSlide extends StatelessWidget {
  const FeaturesGridSlide({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final items = const [
      _FeatureItem('Earn', 'assets/illustrations/earn.png', 'Earn points on each purchase'),
      _FeatureItem('Redeem', 'assets/illustrations/redeem.png', 'Redeem across partners'),
      _FeatureItem('Tiers', 'assets/illustrations/tiers.png', 'Silver • Gold • Platinum'),
      _FeatureItem('Referrals', 'assets/illustrations/referral.png', 'Invite & get rewarded'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rewarity Features',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: .2,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(bottom: 8),
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 260,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: .70,
              ),
              itemBuilder: (_, i) => _FeatureCard(item: items[i], cs: cs),
            ),
          ),
        ],
      ),
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
  final ColorScheme cs;
  const _FeatureCard({required this.item, required this.cs});

  static const _radius = 20.0;

  @override
  Widget build(BuildContext context) {
    final bg = Color.alphaBlend(cs.primary.withOpacity(0.06), cs.surfaceVariant);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_radius),
      child: InkWell(
        borderRadius: BorderRadius.circular(_radius),
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(_radius),
            border: Border.all(color: cs.outlineVariant.withOpacity(.35)),
            boxShadow: [
              BoxShadow(
                color: cs.shadow.withOpacity(0.08),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(.45),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 16 / 11,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ColoredBox(
                    color: cs.surface,
                    child: Image.asset(
                      item.asset,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Title
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: .2,
                  color: cs.onSurface,
                ),
              ),

              const SizedBox(height: 6),

              // Description (clamped to avoid pushing pagination off-screen)
              Expanded(
                child: Text(
                  item.desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cs.onSurface.withOpacity(.78),
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
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
