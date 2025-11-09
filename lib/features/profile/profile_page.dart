import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../app_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
  String? location;
  String? phone;
  String? farmName;
  String? farmLocation;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() => loading = true);
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      setState(() => loading = false);
      return;
    }
    try {
      // Fetch user info from 'users' table
      final userResponse = await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      // Fetch farm info from 'farms' table
      final farmResponse = await Supabase.instance.client
          .from('farms')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();
      setState(() {
        name =
            userResponse?['full_name'] ??
            user.email?.split('@').first ??
            'Farmer';
        phone = userResponse?['phone_number'] ?? user.phone ?? '0701 234 567';
        farmName = farmResponse?['farm_name'] ?? 'No Farm';
        farmLocation = farmResponse?['farm_location'] ?? 'No Location';
        location = farmLocation;
        loading = false;
      });
    } catch (e) {
      setState(() {
        name = user.email?.split('@').first ?? 'Farmer';
        phone = user.phone ?? '0701 234 567';
        farmName = 'No Farm';
        farmLocation = 'No Location';
        location = farmLocation;
        loading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load profile. Showing defaults.')),
        );
      }
    }
  }

  Future<void> _logout() async {
    await Supabase.instance.client.auth.signOut();
    if (mounted) context.go('/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr()),
        centerTitle: true,
        // Removed notification icon from actions
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.grey[300],
                          child: Text(
                            name != null && name!.isNotEmpty
                                ? name![0].toUpperCase()
                                : 'O',
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'poultry_farmer'.tr(),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'myfarm_is_in'.tr(
                                namedArgs: {'location': farmLocation ?? ''},
                              ),
                              style: const TextStyle(
                                color: Colors.black26,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'my_number'.tr(namedArgs: {'phone': phone ?? ''}),
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Coming soon.')),
                          );
                        },
                        child: Text('edit_profile'.tr()),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _ProfileOption(
                      icon: Icons.language,
                      label: 'language_preferences'.tr(),
                      onTap: () =>
                          context.go('/language', extra: {'fromProfile': true}),
                    ),
                    _ProfileOption(
                      icon: Icons.phone,
                      label: 'add_recovery_phone'.tr(),
                      onTap: () {},
                    ),
                    _ProfileOption(
                      icon: Icons.logout,
                      label: 'logout'.tr(),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            backgroundColor: const Color(0xFFF7F8FA),
                            title: Text('logout_confirmation_title'.tr()),
                            content: Text('logout_confirmation_message'.tr()),
                            actions: [
                              OutlinedButton(
                                onPressed: () => Navigator.pop(context, false),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: CustomColors.primary,
                                  side: BorderSide(color: CustomColors.primary),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text('no'.tr()),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                  _logout();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColors.primary,
                                ),
                                child: Text('yes'.tr()),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    _ProfileOption(
                      icon: Icons.delete_outline,
                      label: 'delete_account'.tr(),
                      onTap: () {},
                      iconColor: Colors.red,
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  const _ProfileOption({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white, // Set card background to white
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? CustomColors.primary),
        title: Text(
          label,
          style: TextStyle(color: textColor ?? CustomColors.text),
        ),
        onTap: onTap,
        trailing: const Icon(Icons.chevron_right, color: Colors.black26),
      ),
    );
  }
}
