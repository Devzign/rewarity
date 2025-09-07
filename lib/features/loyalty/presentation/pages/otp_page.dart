import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/auth/auth_service.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;
  final String phone;

  const OtpPage({
    super.key,
    required this.verificationId,
    required this.phone,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _otpCtrl = TextEditingController();
  bool _loading = false;
  String? _error;

  final _auth = AuthService();

  @override
  void dispose() {
    _otpCtrl.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    setState(() { _loading = true; _error = null; });
    try {
      await _auth.verifyOtp(
        verificationId: widget.verificationId,
        smsCode: _otpCtrl.text.trim(),
      );
      if (!mounted) return;
      context.goNamed('dashboard');
    } catch (e) {
      setState(() => _error = 'Invalid code or expired. ${e.toString()}');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final phone = widget.phone;
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('OTP sent to $phone'),
            const SizedBox(height: 12),
            TextField(
              controller: _otpCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter 6-digit code',
              ),
              maxLength: 6,
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _verify,
                child: _loading ? const CircularProgressIndicator() : const Text('Verify & Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
