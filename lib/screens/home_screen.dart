import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/doctor_card.dart';
import 'doctors_screen.dart';
import 'appointments_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _navigateTo(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.user;
    final upcoming = provider.appointments
        .where((a) => a.status.name == 'upcoming')
        .toList();
    final topDoctors = provider.doctors.take(4).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${user.name} 👋',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.foreground,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Your health, our priority.',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _navigateTo(const ProfileScreen()),
                    child: CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.primaryLight,
                      backgroundImage: AssetImage(user.imagePath),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Search
              SearchBarWidget(
                controller: _searchController,
                onFilterTap: () => _navigateTo(const DoctorsScreen()),
              ),
              const SizedBox(height: 20),

              // Upcoming Appointment
              if (upcoming.isNotEmpty) ...[
                _AppointmentCard(appointment: upcoming.first),
                const SizedBox(height: 24),
              ],

              // Quick Actions
              SectionHeader(title: 'Quick Actions'),
              Row(
                children: [
                  QuickActionButton(
                    icon: Icons.calendar_today_outlined,
                    label: 'Book\nAppointment',
                    iconColor: AppColors.primary,
                    bgColor: AppColors.primaryLight,
                    onTap: () => _navigateTo(const DoctorsScreen()),
                  ),
                  QuickActionButton(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Chat with\nDoctor',
                    iconColor: AppColors.success,
                    bgColor: AppColors.successLight,
                    onTap: () => _navigateTo(const MessagesScreen()),
                  ),
                  QuickActionButton(
                    icon: Icons.description_outlined,
                    label: 'Prescrip-\ntions',
                    iconColor: AppColors.warning,
                    bgColor: AppColors.warningLight,
                    onTap: () => _navigateTo(const AppointmentsScreen()),
                  ),
                  QuickActionButton(
                    icon: Icons.folder_outlined,
                    label: 'Medical\nRecords',
                    iconColor: AppColors.purple,
                    bgColor: AppColors.purpleLight,
                    onTap: () => _navigateTo(const ProfileScreen()),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Top Doctors
              SectionHeader(
                title: 'Top Doctors',
                onViewAll: () => _navigateTo(const DoctorsScreen()),
              ),
              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topDoctors.length,
                  itemBuilder: (_, i) => DoctorCard(doctor: topDoctors[i]),
                ),
              ),
              const SizedBox(height: 24),

              // Health Tips
              SectionHeader(title: 'Health Tips'),
              _HealthTipCard(
                icon: Icons.wb_sunny_outlined,
                title: 'Stay Hydrated',
                body: 'Drink at least 8 glasses of water daily to maintain optimal health.',
                iconColor: AppColors.warning,
                bgColor: AppColors.warningLight,
              ),
              const SizedBox(height: 10),
              _HealthTipCard(
                icon: Icons.monitor_heart_outlined,
                title: 'Exercise Daily',
                body: '30 minutes of moderate activity each day reduces risk of chronic disease.',
                iconColor: AppColors.success,
                bgColor: AppColors.successLight,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final dynamic appointment;
  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.appointmentCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today_rounded, size: 13, color: AppColors.primary),
              const SizedBox(width: 5),
              const Text(
                'UPCOMING APPOINTMENT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.foreground,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      appointment.specialty,
                      style: const TextStyle(fontSize: 13, color: AppColors.mutedForeground),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.mutedForeground),
                        const SizedBox(width: 5),
                        Text(
                          '${appointment.date} · ${appointment.time}',
                          style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 13, color: AppColors.mutedForeground),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            appointment.location,
                            style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AppointmentsScreen()),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View Details',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.chevron_right, size: 14, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/appointment_doctor.png',
                width: 90,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 90,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.medical_services_outlined, color: AppColors.primary, size: 36),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HealthTipCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final Color iconColor;
  final Color bgColor;

  const _HealthTipCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.mutedForeground,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
