import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appointment.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.user;
    final upcoming = provider.appointments.where((a) => a.status == AppointmentStatus.upcoming).length;
    final completed = provider.appointments.where((a) => a.status == AppointmentStatus.completed).length;
    final favCount = provider.favoriteDoctors.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Profile Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      backgroundImage: AssetImage(user.imagePath),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Age ${user.age} · Blood Type ${user.bloodType}',
                      style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8)),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit_outlined, size: 14, color: Colors.white),
                          SizedBox(width: 6),
                          Text('Edit Profile', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Stats
              Row(
                children: [
                  _StatItem(value: '$upcoming', label: 'Upcoming', color: AppColors.primary),
                  const SizedBox(width: 10),
                  _StatItem(value: '$completed', label: 'Completed', color: AppColors.success),
                  const SizedBox(width: 10),
                  _StatItem(value: '$favCount', label: 'Favorites', color: AppColors.purple),
                ],
              ),
              const SizedBox(height: 16),

              // Allergies
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.warning_amber_rounded, size: 16, color: AppColors.warning),
                        SizedBox(width: 8),
                        Text('Allergies', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.foreground)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: user.allergies
                          .map((a) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.warningLight,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(a,
                                    style: const TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.warning)),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Health Menu
              _MenuSection(
                title: 'HEALTH',
                items: [
                  _MenuItem(icon: Icons.description_outlined, label: 'Medical Records', iconColor: AppColors.purple, iconBg: AppColors.purpleLight),
                  _MenuItem(icon: Icons.monitor_heart_outlined, label: 'Health Reports', iconColor: AppColors.success, iconBg: AppColors.successLight),
                  _MenuItem(icon: Icons.favorite_border_rounded, label: 'Vital Signs', iconColor: AppColors.destructive, iconBg: const Color(0xFFFFE5E5), value: 'Normal'),
                ],
              ),
              const SizedBox(height: 16),

              // Account Menu
              _MenuSection(
                title: 'ACCOUNT',
                items: [
                  _MenuItem(icon: Icons.notifications_outlined, label: 'Notifications', iconColor: AppColors.warning, iconBg: AppColors.warningLight),
                  _MenuItem(icon: Icons.lock_outline_rounded, label: 'Privacy & Security', iconColor: AppColors.primary, iconBg: AppColors.primaryLight),
                  _MenuItem(icon: Icons.credit_card_outlined, label: 'Payment Methods', iconColor: AppColors.success, iconBg: AppColors.successLight),
                  _MenuItem(icon: Icons.help_outline_rounded, label: 'Help & Support', iconColor: AppColors.mutedForeground, iconBg: AppColors.muted),
                ],
              ),
              const SizedBox(height: 16),

              // Logout
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.destructive, width: 1.5),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded, size: 17, color: AppColors.destructive),
                      SizedBox(width: 8),
                      Text('Log Out', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.destructive)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _StatItem({required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: color)),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
          ],
        ),
      ),
    );
  }
}

class _MenuSection extends StatelessWidget {
  final String title;
  final List<_MenuItem> items;
  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.mutedForeground,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ...items.map((item) => _MenuItemTile(item: item)),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color iconBg;
  final String? value;
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.iconBg,
    this.value,
  });
}

class _MenuItemTile extends StatelessWidget {
  final _MenuItem item;
  const _MenuItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: item.iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, color: item.iconColor, size: 17),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.label,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.foreground),
              ),
            ),
            if (item.value != null) ...[
              Text(item.value!, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              const SizedBox(width: 6),
            ],
            const Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.mutedForeground),
          ],
        ),
      ),
    );
  }
}
