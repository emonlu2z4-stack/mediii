import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';

class DoctorDetailScreen extends StatefulWidget {
  final String doctorId;
  const DoctorDetailScreen({super.key, required this.doctorId});

  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  int _selectedDay = 0;
  String? _selectedSlot;

  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final List<String> _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final doctor = provider.getDoctorById(widget.doctorId);

    if (doctor == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Doctor')),
        body: const Center(child: Text('Doctor not found')),
      );
    }

    final isFav = provider.isFavorite(doctor.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header
          SafeArea(
            bottom: false,
            child: Container(
              color: AppColors.card,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.muted,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_rounded, color: AppColors.foreground, size: 20),
                    ),
                  ),
                  const Text('Doctor Profile',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.foreground)),
                  GestureDetector(
                    onTap: () => provider.toggleFavorite(doctor.id),
                    child: Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.muted,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: isFav ? Colors.red : AppColors.foreground,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Doctor Info Card
                  Container(
                    color: AppColors.card,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.primaryLight,
                          backgroundImage: AssetImage(doctor.imagePath),
                        ),
                        const SizedBox(height: 14),
                        Text(doctor.name,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.foreground)),
                        const SizedBox(height: 4),
                        Text(doctor.specialty,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.primary)),
                        const SizedBox(height: 4),
                        Text('${doctor.hospital} · ${doctor.location}',
                            style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _StatChip(icon: Icons.star_rounded, iconColor: AppColors.star,
                                value: '${doctor.rating}', label: 'Rating'),
                            const _Divider(),
                            _StatChip(icon: Icons.people_outline_rounded, iconColor: AppColors.primary,
                                value: '${doctor.reviewCount}+', label: 'Patients'),
                            const _Divider(),
                            _StatChip(icon: Icons.work_outline_rounded, iconColor: AppColors.success,
                                value: doctor.experience, label: 'Exp.'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // About
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('About', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.foreground)),
                              const SizedBox(height: 10),
                              Text(doctor.about,
                                  style: const TextStyle(fontSize: 14, color: AppColors.mutedForeground, height: 1.6)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => ChatScreen(doctorId: doctor.id))),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primary, size: 20),
                                      SizedBox(width: 8),
                                      Text('Message', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  color: AppColors.successLight,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.phone_outlined, color: AppColors.success, size: 20),
                                    SizedBox(width: 8),
                                    Text('Call', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.success)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Book Appointment
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Book Appointment',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.foreground)),
                              const SizedBox(height: 12),
                              const Text('Select Day',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.mutedForeground)),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _days.length,
                                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                                  itemBuilder: (_, i) {
                                    final isActive = _selectedDay == i;
                                    return GestureDetector(
                                      onTap: () => setState(() { _selectedDay = i; _selectedSlot = null; }),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                                        decoration: BoxDecoration(
                                          color: isActive ? AppColors.primary : AppColors.muted,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: isActive ? AppColors.primary : AppColors.border),
                                        ),
                                        child: Text(_days[i],
                                            style: TextStyle(
                                              fontSize: 13, fontWeight: FontWeight.w500,
                                              color: isActive ? Colors.white : AppColors.mutedForeground,
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text('Available Slots',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.mutedForeground)),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: doctor.availableSlots.map((slot) {
                                  final isActive = _selectedSlot == slot;
                                  return GestureDetector(
                                    onTap: () => setState(() => _selectedSlot = slot),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                                      decoration: BoxDecoration(
                                        color: isActive ? AppColors.primary : AppColors.muted,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: isActive ? AppColors.primary : AppColors.border),
                                      ),
                                      child: Text(slot,
                                          style: TextStyle(
                                            fontSize: 13, fontWeight: FontWeight.w500,
                                            color: isActive ? Colors.white : AppColors.foreground,
                                          )),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16),
                              const Divider(color: AppColors.border, height: 1),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Consultation Fee',
                                      style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                                  Text('\$${doctor.fee.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: FloatingActionButton.extended(
          onPressed: () {
            if (_selectedSlot == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select an available time slot.')),
              );
              return;
            }
            final now = DateTime.now();
            final date =
                '${_months[now.month - 1]} ${now.day + _selectedDay + 1}, ${now.year}';
            provider.bookAppointment(
              doctorId: doctor.id,
              doctorName: doctor.name,
              specialty: doctor.specialty,
              date: date,
              time: _selectedSlot!,
              location: '${doctor.hospital}, ${doctor.location}',
            );
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: AppColors.success),
                    SizedBox(width: 8),
                    Text('Appointment Booked!'),
                  ],
                ),
                content: Text(
                    'Your appointment with ${doctor.name} on $date at $_selectedSlot has been confirmed.'),
                actions: [
                  TextButton(
                    onPressed: () { Navigator.pop(context); Navigator.pop(context); },
                    child: const Text('Done'),
                  ),
                ],
              ),
            );
          },
          backgroundColor: doctor.available ? AppColors.primary : AppColors.mutedForeground,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          label: Text(
            doctor.available ? 'Book Appointment' : 'Not Available',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  const _StatChip({required this.icon, required this.iconColor, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.foreground)),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.mutedForeground)),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 40, color: AppColors.border);
  }
}
