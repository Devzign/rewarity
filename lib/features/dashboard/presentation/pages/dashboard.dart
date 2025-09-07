import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rewarity/features/dashboard/presentation/pages/profile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _bannerCtrl = PageController();
  int _bannerIndex = 0;
  Timer? _timer;

  final _banners = [
    _BannerData(
        title: 'Ride In Style',
        cta: 'Book now',
        color: const Color(0xFFF6A86E),
        icon: Icons.two_wheeler),
    _BannerData(
        title: 'Festive Offers',
        cta: 'Shop now',
        color: const Color(0xFF8EC5A1),
        icon: Icons.card_giftcard),
    _BannerData(
        title: 'Upgrade Today',
        cta: 'Explore',
        color: const Color(0xFF9DB7F5),
        icon: Icons.electric_bike),
  ];

  final _partners = const [
    _Partner('Partner A', Icons.circle),
    _Partner('Partner B', Icons.crop_square),
    _Partner('Partner', Icons.change_history),
  ];

  final _schemes = const [
    _Scheme('AC', Icons.ac_unit),
    _Scheme('Refrigerator', Icons.kitchen),
    _Scheme('Water Cooler', Icons.water_drop),
    _Scheme('Microwave', Icons.microwave),
  ];

  final _txns = const [
    _Txn('#1234', 'AC', '20 pts', 'Won'),
    _Txn('#1235', 'Cooler', '10 pts', 'Pending'),
    _Txn('#1236', 'Used', '15 pt', 'Used'),
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      _bannerIndex = (_bannerIndex + 1) % _banners.length;
      _bannerCtrl.animateToPage(_bannerIndex,
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _bannerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).padding;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 12, 16, pad.bottom + 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(),
              const SizedBox(height: 16),
              const Text('Auto-scroll Banner',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              _BannerCarousel(
                  controller: _bannerCtrl,
                  index: _bannerIndex,
                  items: _banners),
              const SizedBox(height: 16),
              const Text('Partner Advertisements',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _partners
                    .map((p) => Chip(
                          label: Text(p.name),
                          avatar: Icon(p.icon, size: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.grey.shade100,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              const Text('Schemes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              SizedBox(
                height: 98,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _schemes.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) {
                    final s = _schemes[i];
                    return Container(
                      width: 88,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(s.icon, size: 28, color: Colors.grey.shade800),
                          const SizedBox(height: 8),
                          Text(s.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text('Rewards',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Material(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    child: Row(
                      children: const [
                        Expanded(
                            child: Text('SCRATCH TO WIN',
                                style: TextStyle(fontWeight: FontWeight.w600))),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Transaction History',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Column(
                children: _txns
                    .map((t) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${t.id}  •  ${t.item}  •  ${t.points}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              _StatusChip(status: t.status),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 36,
          width: 72,
          fit: BoxFit.contain,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileView()),
            );
          },
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.black54),
          ),
        ),
      ],
    );
  }
}

class _BannerCarousel extends StatelessWidget {
  final PageController controller;
  final int index;
  final List<_BannerData> items;
  const _BannerCarousel(
      {required this.controller, required this.index, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: items.length,
            itemBuilder: (_, i) {
              final b = items[i];
              return Container(
                margin: const EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                    color: b.color, borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(b.title,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white)),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: b.color,
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {},
                            child: Text(b.cta),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(b.icon,
                        size: 80, color: Colors.white.withOpacity(.95)),
                  ],
                ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                items.length,
                (i) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: index == i ? 8 : 6,
                  height: index == i ? 8 : 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(index == i ? 0.95 : 0.6),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});
  Color get _bg {
    switch (status.toLowerCase()) {
      case 'won':
        return const Color(0xFF3CC38A);
      case 'pending':
        return const Color(0xFFBFC5D2);
      default:
        return const Color(0xFFE0E0E0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration:
          BoxDecoration(color: _bg, borderRadius: BorderRadius.circular(20)),
      child: Text(
        status,
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _BannerData {
  final String title;
  final String cta;
  final Color color;
  final IconData icon;
  const _BannerData(
      {required this.title,
      required this.cta,
      required this.color,
      required this.icon});
}

class _Partner {
  final String name;
  final IconData icon;
  const _Partner(this.name, this.icon);
}

class _Scheme {
  final String name;
  final IconData icon;
  const _Scheme(this.name, this.icon);
}

class _Txn {
  final String id;
  final String item;
  final String points;
  final String status;
  const _Txn(this.id, this.item, this.points, this.status);
}
