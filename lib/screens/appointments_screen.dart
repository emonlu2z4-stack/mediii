import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appointment.dart';
import '../models/message.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showPrescriptions = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Appointments',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.foreground,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _showPrescriptions = !_showPrescriptions),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: _showPrescriptions ? AppColors.primary : AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.description_outlined,
                            size: 15,
                            color: _showPrescriptions ? Colors.white : AppColors.mutedForeground,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Prescriptions',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _showPrescriptions ? Colors.white : AppColors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (!_showPrescriptions) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.muted,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.mutedForeground,
                    labelStyle: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    tabs: const [
                      Tab(text: 'Upcoming'),
                      Tab(text: 'Completed'),
                      Tab(text: 'Cancelled'),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Expanded(
              child: _showPrescriptions
                  ? _PrescriptionsTab(prescriptions: provider.prescriptions)
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _AppointmentList(
                          appointments: provider.appointments
                              .where((a) => a.status == AppointmentStatus.upcoming)
                              .toList(),
                          onCancel: provider.cancelAppointment,
                        ),
                        _AppointmentList(
                          appointments: provider.appointments
                              .where((a) => a.status == AppointmentStatus.completed)
                              .toList(),
                          onCancel: null,
                        ),
                        _AppointmentList(
                          appointments: provider.appointments
                              .where((a) => a.status == AppointmentStatus.cancelled)
                              .toList(),
                          onCancel: null,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppointmentList extends StatelessWidget {
  final List<Appointment> appointments;
  final void Function(String)? onCancel;

  const _AppointmentList({required this.appointments, this.onCancel});

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_outlined, size: 48, color: AppColors.mutedForeground),
            SizedBox(height: 12),
            Text('No appointments found',
                style: TextStyle(fontSize: 16, color: AppColors.mutedForeground)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      itemCount: appointments.length,
      itemBuilder: (_, i) => _AppointmentCard(
        appointment: appointments[i],
        onCancel: onCancel,
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final void Function(String)? onCancel;

  const _AppointmentCard({required this.appointment, this.onCancel});

  Color get _statusColor {
    switch (appointment.status) {
      case AppointmentStatus.upcoming: return AppColors.primary;
      case AppointmentStatus.completed: return AppColors.success;
      case AppointmentStatus.cancelled: return AppColors.destructive;
    }
  }

  Color get _statusBg {
    switch (appointment.status) {
      case AppointmentStatus.upcoming: return AppColors.primaryLight;
      case AppointmentStatus.completed: return AppColors.successLight;
      case AppointmentStatus.cancelled: return const Color(0xFFFFE5E5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  appointment.status.name[0].toUpperCase() + appointment.status.name.substring(1),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _statusColor,
                  ),
                ),
              ),
              Text(
                appointment.date,
                style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            appointment.doctorName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            appointment.specialty,
            style: const TextStyle(fontSize: 13, color: AppColors.mutedForeground),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 14, color: AppColors.mutedForeground),
              const SizedBox(width: 5),
              Text(appointment.time, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              const SizedBox(width: 12),
              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.mutedForeground),
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
          if (appointment.notes != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.muted,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, size: 13, color: AppColors.mutedForeground),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      appointment.notes!,
                      style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (onCancel != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.visibility_outlined, size: 15, color: AppColors.primary),
                          SizedBox(width: 6),
                          Text('View Details',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Cancel Appointment'),
                        content: const Text('Are you sure you want to cancel this appointment?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
                          TextButton(
                            onPressed: () {
                              onCancel!(appointment.id);
                              Navigator.pop(context);
                            },
                            child: const Text('Yes, Cancel', style: TextStyle(color: AppColors.destructive)),
                          ),
                        ],
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE5E5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close_rounded, size: 15, color: AppColors.destructive),
                          SizedBox(width: 6),
                          Text('Cancel',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.destructive)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _PrescriptionsTab extends StatelessWidget {
  final List<Prescription> prescriptions;
  const _PrescriptionsTab({required this.prescriptions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      itemCount: prescriptions.length,
      itemBuilder: (_, i) {
        final rx = prescriptions[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.description_outlined, size: 16, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(rx.doctorName,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.foreground)),
                ],
              ),
              const SizedBox(height: 4),
              Text(rx.date, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
              const SizedBox(height: 10),
              ...rx.medications.map((m) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 8, height: 8,
                          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${m.name} — ${m.dosage}',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.foreground)),
                            Text(m.frequency,
                                style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
