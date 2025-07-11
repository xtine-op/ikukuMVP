import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../app_theme.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isSignUp = false;
  String? _error;

  Future<void> _signInOrSignUp() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    try {
      if (_isSignUp) {
        final res = await Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
        );
        if (res.user != null) {
          setState(() {
            _isSignUp = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Sign up successful! Please check your email to confirm.',
              ),
            ),
          );
        } else {
          setState(() {
            _error = 'Sign up failed.';
          });
        }
      } else {
        final res = await Supabase.instance.client.auth.signInWithPassword(
          email: email,
          password: password,
        );
        if (res.user != null) {
          context.go('/');
        } else {
          setState(() {
            _error = 'Sign in failed.';
          });
        }
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isSignUp ? 'Sign Up' : 'Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _signInOrSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      foregroundColor: CustomColors.text,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: CustomColors.buttonGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(minHeight: 48),
                        child: Text(_isSignUp ? 'Sign Up' : 'Sign In'),
                      ),
                    ),
                  ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isSignUp = !_isSignUp;
                  _error = null;
                });
              },
              child: Text(
                _isSignUp
                    ? 'Already have an account? Sign In'
                    : "Don't have an account? Sign Up",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
