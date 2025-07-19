import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../shared/services/supabase_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _error;
  bool _isSignUp = false;

  void _onSubmit() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final repeatPassword = _repeatPasswordController.text.trim();
    if (email.isEmpty ||
        password.isEmpty ||
        (_isSignUp && repeatPassword.isEmpty)) {
      setState(() {
        _error = 'Please fill in all fields.';
        _isLoading = false;
      });
      return;
    }
    if (_isSignUp && password != repeatPassword) {
      setState(() {
        _error = 'Passwords do not match.';
        _isLoading = false;
      });
      return;
    }
    try {
      // Test connection first
      final supabaseService = SupabaseService();
      final isConnected = await supabaseService.testConnection();
      if (!isConnected) {
        setState(() {
          _error =
              'Unable to connect to server. Please check your internet connection.';
          _isLoading = false;
        });
        return;
      }

      if (_isSignUp) {
        print('Attempting sign up for email: $email');
        final res = await Supabase.instance.client.auth.signUp(
          email: email,
          password: password,
        );
        final user = res.user;
        print(
          'Sign up response: ${res.session != null ? 'Session created' : 'No session'}',
        );
        print('User: ${user?.id ?? 'No user'}');

        if (user != null) {
          try {
            await Supabase.instance.client.from('users').insert({
              'id': user.id,
              'full_name': '', // You can collect this later
              'phone_number': '', // You can collect this later
            });
            print('User record created successfully');
            context.go('/create-farm');
          } catch (dbError) {
            print('Database error creating user record: $dbError');
            // Even if user table insert fails, we can still proceed
            context.go('/create-farm');
          }
        } else {
          setState(() {
            _error = 'Sign up failed. Please try again.';
          });
        }
      } else {
        print('Attempting sign in for email: $email');
        final res = await Supabase.instance.client.auth.signInWithPassword(
          email: email,
          password: password,
        );
        print(
          'Sign in response: ${res.session != null ? 'Session created' : 'No session'}',
        );
        print('User: ${res.user?.id ?? 'No user'}');

        if (res.user != null) {
          // Ensure user exists in users table
          final user = res.user;
          if (user != null) {
            try {
              final userExists = await Supabase.instance.client
                  .from('users')
                  .select('id')
                  .eq('id', user.id)
                  .maybeSingle();
              if (userExists == null) {
                print('Creating user record for existing auth user');
                await Supabase.instance.client.from('users').insert({
                  'id': user.id,
                  'full_name': user.userMetadata?['full_name'] ?? '',
                  'phone_number': user.userMetadata?['phone_number'] ?? '',
                });
              }
            } catch (dbError) {
              print('Database error checking/creating user record: $dbError');
              // Continue anyway - the user is authenticated
            }
          }
          // Check if user has a farm
          final farm = await Supabase.instance.client
              .from('farms')
              .select()
              .eq('user_id', user!.id)
              .maybeSingle();
          if (farm == null) {
            context.go(
              '/create-farm',
              extra: {
                'name': user.userMetadata?['full_name'] ?? '',
                'phone': user.userMetadata?['phone_number'] ?? '',
              },
            );
          } else {
            context.go('/');
          }
        } else {
          setState(() {
            _error = 'Sign in failed.';
          });
        }
      }
    } catch (e) {
      print('Authentication error: $e'); // Debug log
      setState(() {
        // Provide user-friendly error messages
        if (e.toString().contains('SocketException') ||
            e.toString().contains('Failed host lookup') ||
            e.toString().contains('No address associated with hostname') ||
            e.toString().contains('Network is unreachable')) {
          _error =
              'No internet connection. Please check your network and try again.';
        } else if (e.toString().contains('Invalid login credentials')) {
          _error = 'Invalid email or password. Please try again.';
        } else if (e.toString().contains('Email not confirmed')) {
          _error =
              'Please check your email and confirm your account before signing in.';
        } else if (e.toString().contains('User already registered')) {
          _error =
              'An account with this email already exists. Please sign in instead.';
        } else if (e.toString().contains('Invalid API key')) {
          _error = 'Configuration error. Please contact support.';
        } else if (e.toString().contains('timeout')) {
          _error =
              'Request timed out. Please check your connection and try again.';
        } else {
          _error = 'An error occurred: ${e.toString().split(':').last.trim()}';
        }
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.green.shade700, width: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isSignUp = true; // Default to sign up (create account)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Image.asset('assets/icons/app-logo.png', height: 56),
                      SizedBox(height: 8),
                      Text(
                        'i-kuku',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  _isSignUp ? "Create Account" : "Sign In",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  _isSignUp
                      ? 'Enter your email and password to create an account.'
                      : 'Enter your email and password to sign in.',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 32),
                Text('Email', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration('Type your email'),
                ),
                SizedBox(height: 20),
                Text('Password', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: _inputDecoration('Type your password'),
                ),
                if (_isSignUp) ...[
                  SizedBox(height: 20),
                  Text(
                    'Repeat Password',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _repeatPasswordController,
                    obscureText: true,
                    decoration: _inputDecoration('Repeat your password'),
                  ),
                ],
                if (_error != null) ...[
                  SizedBox(height: 16),
                  Text(_error!, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 8),
                  // Debug button to test connection
                  if (_error!.contains('internet') ||
                      _error!.contains('connection'))
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                          _error = null;
                        });
                        try {
                          final supabaseService = SupabaseService();
                          final isConnected = await supabaseService
                              .testConnection();
                          setState(() {
                            _error = isConnected
                                ? 'Connection test successful!'
                                : 'Connection test failed. Check your Supabase configuration.';
                            _isLoading = false;
                          });
                        } catch (e) {
                          setState(() {
                            _error = 'Connection test error: $e';
                            _isLoading = false;
                          });
                        }
                      },
                      child: Text('Test Connection'),
                    ),
                ],
                SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onSubmit,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFC727), Color(0xFF8DC63F)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: BoxConstraints(minHeight: 48),
                        child: _isLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _isSignUp ? 'SIGN UP' : 'SIGN IN',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isSignUp
                            ? 'Have an account? '
                            : "Don't have an account? ",
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSignUp = !_isSignUp;
                            _error = null;
                          });
                        },
                        child: Text(
                          _isSignUp ? 'SIGN IN' : 'SIGN UP',
                          style: TextStyle(
                            color: Colors.green[800],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
