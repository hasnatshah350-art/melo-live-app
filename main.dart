import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MeloLiveApp());
}

class MeloLiveApp extends StatelessWidget {
  const MeloLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Melo Live',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFF120E1C),
      ),
      home: const SplashScreen(),
    );
  }
}

// 1. سپلیش (لوگو) اسکرین
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 2 سیکنڈ کے بعد خود بخود لاگ ان اسکرین پر چلے جائیں
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF120E1C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Melo Live',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Live & Short Videos',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. لاگ ان اور سائن اپ اسکرین
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedCountryCode = '+92'; // آٹو لوکیشن بیسڈ ڈیفالٹ کوڈ
  final TextEditingController phoneController = TextEditingController();

  final List<String> countryCodes = ['+92 (PK)', '+1 (US)', '+44 (UK)', '+966 (SA)', '+971 (AE)', '+91 (IN)'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Log in to Melo Live',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 30),

              // فون نمبر اور کنٹری کوڈ ڈراپ ڈاؤن
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCountryCode,
                          dropdownColor: const Color(0xFF261E38),
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          items: countryCodes.map((String code) {
                            return DropdownMenuItem<String>(
                              value: code.split(' ')[0],
                              child: Text(code, style: const TextStyle(color: Colors.white)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountryCode = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(height: 30, width: 1, color: Colors.white24),
                    Expanded(
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // او ٹی پی / لاگ ان بٹن
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFE2C55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // نمبر درج کرنے کے بعد پروفائل سیٹ اپ پر جائیں
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileSetupScreen()),
                    );
                  },
                  child: const Text(
                    'Send Code / Log in',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.white24)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('or', style: TextStyle(color: Colors.white54)),
                  ),
                  Expanded(child: Divider(color: Colors.white24)),
                ],
              ),
              const SizedBox(height: 25),

              _buildLoginOption(Icons.mail_outline, 'Continue with email / username'),
              const SizedBox(height: 12),
              _buildLoginOption(Icons.facebook, 'Continue with Facebook', iconColor: Colors.blue),
              const SizedBox(height: 12),
              _buildLoginOption(Icons.g_mobiledata, 'Continue with Google', iconColor: Colors.red, isCustom: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginOption(IconData icon, String text, {Color iconColor = Colors.white, bool isCustom = false}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(icon, color: iconColor, size: isCustom ? 30 : 24),
          Expanded(
            child: Center(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

// 3. پروفائل سیٹ اپ اسکرین (نام، تصویر مع سکپ، اور تاریخ پیدائش)
class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Complete Your Profile', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              // سکپ کرنے کا بٹن
            },
            child: const Text('Skip', style: TextStyle(color: Color(0xFFFE2C55), fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // پروفائل پکچر لگانے کی جگہ
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white24,
              child: Icon(Icons.camera_alt, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 30),

            // نام (Name) لکھنے کی فیلڈ
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter your name',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white.withOpacity(0.08),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),

            // تاریخ پیدائش (Date of Birth) کی فیلڈ
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Date of Birth (e.g. DD/MM/YYYY)',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white.withOpacity(0.08),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 40),

            // اگلا قدم مکمل کرنے کا بٹن
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE2C55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: const Text(
                  'Confirm & Continue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
