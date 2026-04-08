import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/config/routes/app_pages.dart';
import 'package:laundry/core/services/app_lock_service.dart';
import 'package:laundry/core/services/biometric_service.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  String biometricText = 'Biometric';

  @override
  void initState() {
    super.initState();
    _loadLabel();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _unlock();
    });
  }

  Future<void> _loadLabel() async {
    biometricText = await BiometricService.instance.biometricLabel();
    if (mounted) setState(() {});
  }

  Future<void> _unlock() async {
    final ok = await AppLockService.to.unlockWithBiometric();
    if (ok) {
      Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock, size: 72),
                  const SizedBox(height: 20),
                  const Text(
                    'App Locked',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Use $biometricText to continue',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: AppLockService.to.isAuthenticating.value
                        ? null
                        : _unlock,
                    child: AppLockService.to.isAuthenticating.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('Unlock with $biometricText'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}