import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../constants/login_images.dart';
import '../../../../core/auth/auth_service.dart';
import '../widgets/common_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final PageController _pageController;
  late final Timer _timer;
  int _currentPage = 0;

  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();

  bool _loading = false;
  String? _error;

  final _auth = AuthService();

  static const Map<String, String> _demoPhones = {
    '+919998316492': '555444',
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _phoneCtrl.text = '+91';
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < LoginImages.banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    final phone = _phoneCtrl.text.trim();
    final String? demoCode = _demoPhones[phone];

    try {
      // Always request verificationId (Firebase won’t send SMS for test numbers)
      final verificationId = await _auth.sendOtp(phoneNumber: phone);

      if (demoCode != null) {
        // 🔥 DEMO PATH: instantly verify using the fixed test code
        await _auth.verifyOtp(
          verificationId: verificationId,
          smsCode: demoCode,
        );
        if (!mounted) return;
        context.goNamed('dashboard'); // go straight in for demo
        return;
      }

      // Normal path: go to OTP screen
      if (!mounted) return;
      context.pushNamed('otp', extra: {
        'verificationId': verificationId,
        'phone': phone,
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: LoginImages.banners.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (_, index) {
                      return Image.asset(
                        LoginImages.banners[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  ),
                  Positioned(
                    bottom: 8,
                    child: Row(
                      children: List.generate(
                        LoginImages.banners.length,
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _currentPage == index ? 10 : 6,
                          height: _currentPage == index ? 10 : 6,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white54,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Log In",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Enter your mobile number to Log In",
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Enter Mobile Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (v) {
                          final t = (v ?? '').trim();
                          if (t.isEmpty) return 'Phone number required';
                          if (!t.startsWith('+') || t.length < 10) {
                            return 'Use full international format, e.g. +91XXXXXXXXXX';
                          }
                          return null;
                        },
                      ),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    const Spacer(),
                    CommonButton(
                      borderRadius: 16.0,
                      label: "Send OTP",
                      onPressed: _loading ? null : _sendOtp,
                      isLoading: _loading,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
