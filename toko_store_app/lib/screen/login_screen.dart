import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;

  final String nim = '123230140'; 

  void _handleLogin() async {
    final String username = _usernameCtrl.text.trim();
    final String password = _passwordCtrl.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showError('Username dan password tidak boleh kosong');
      return;
    }

    if (password == nim) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('currentUser', username);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNav()),
      );
    } else {
      _showError('Password salah! Password wajib menggunakan NIM Anda.');
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.shopping_cart, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 16),
              Text('TokoStore', style: teks.headlineMedium),
              const SizedBox(height: 4),
              Text('Beli apa aja disini!', style: teks.bodyMedium),
              const SizedBox(height: 40),
              TextField(
                controller: _usernameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordCtrl,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password (NIM)',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _handleLogin,
                child: const Text('Masuk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}