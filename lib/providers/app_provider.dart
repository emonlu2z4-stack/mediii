import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../models/appointment.dart';
import '../models/message.dart';
import '../models/user.dart';

class AppProvider extends ChangeNotifier {
  final AppUser user = const AppUser(
    name: 'Sarah',
    age: 28,
    bloodType: 'O+',
    allergies: ['Penicillin', 'Pollen'],
    imagePath: 'assets/images/user_avatar.png',
  );

  final List<Doctor> doctors = const [
    Doctor(
      id: '1',
      name: 'Dr. Emily Carter',
      specialty: 'Cardiologist',
      rating: 4.9,
      reviewCount: 142,
      experience: '12 years',
      hospital: 'MediCare Clinic',
      location: 'New York, NY',
      fee: 150,
      about:
          'Dr. Emily Carter is a board-certified cardiologist with over 12 years of experience in cardiovascular medicine. She specializes in preventive cardiology and heart disease management.',
      available: true,
      imagePath: 'assets/images/doctor4.png',
      availableSlots: ['9:00 AM', '10:30 AM', '2:00 PM', '4:30 PM'],
    ),
    Doctor(
      id: '2',
      name: 'Dr. James Wilson',
      specialty: 'Dermatologist',
      rating: 4.9,
      reviewCount: 128,
      experience: '10 years',
      hospital: 'City Medical Center',
      location: 'New York, NY',
      fee: 120,
      about:
          'Dr. James Wilson is a renowned dermatologist specializing in skin conditions, cosmetic procedures, and dermatological surgeries.',
      available: true,
      imagePath: 'assets/images/doctor1.png',
      availableSlots: ['10:00 AM', '11:30 AM', '3:00 PM', '5:00 PM'],
    ),
    Doctor(
      id: '3',
      name: 'Dr. Priya Sharma',
      specialty: 'Neurologist',
      rating: 4.8,
      reviewCount: 95,
      experience: '8 years',
      hospital: 'NeuroHealth Center',
      location: 'Brooklyn, NY',
      fee: 180,
      about:
          'Dr. Priya Sharma is a highly skilled neurologist with expertise in neurodegenerative disorders, epilepsy, and headache management.',
      available: false,
      imagePath: 'assets/images/doctor2.png',
      availableSlots: ['9:30 AM', '1:00 PM', '3:30 PM'],
    ),
    Doctor(
      id: '4',
      name: 'Dr. Michael Lee',
      specialty: 'Orthopedic Surgeon',
      rating: 4.9,
      reviewCount: 110,
      experience: '15 years',
      hospital: 'Ortho Spine Institute',
      location: 'Manhattan, NY',
      fee: 200,
      about:
          'Dr. Michael Lee is an expert orthopedic surgeon focusing on joint replacement, sports injuries, and spinal disorders.',
      available: true,
      imagePath: 'assets/images/doctor3.png',
      availableSlots: ['8:00 AM', '11:00 AM', '2:30 PM'],
    ),
    Doctor(
      id: '5',
      name: 'Dr. Sarah Chen',
      specialty: 'Pediatrician',
      rating: 4.8,
      reviewCount: 87,
      experience: '7 years',
      hospital: "Children's Wellness Clinic",
      location: 'Queens, NY',
      fee: 100,
      about:
          'Dr. Sarah Chen is a compassionate pediatrician dedicated to the health and well-being of children from infancy through adolescence.',
      available: true,
      imagePath: 'assets/images/doctor5.png',
      availableSlots: ['9:00 AM', '10:00 AM', '2:00 PM', '4:00 PM'],
    ),
  ];

  final List<Prescription> prescriptions = const [
    Prescription(
      id: 'rx1',
      doctorName: 'Dr. Emily Carter',
      date: 'May 24, 2025',
      medications: [
        Medication(name: 'Lisinopril', dosage: '10mg', frequency: 'Once daily'),
        Medication(name: 'Aspirin', dosage: '81mg', frequency: 'Once daily'),
      ],
    ),
    Prescription(
      id: 'rx2',
      doctorName: 'Dr. James Wilson',
      date: 'Apr 10, 2025',
      medications: [
        Medication(name: 'Tretinoin', dosage: '0.05%', frequency: 'Once nightly'),
        Medication(name: 'Clindamycin', dosage: '1%', frequency: 'Twice daily'),
      ],
    ),
  ];

  List<Appointment> _appointments = [
    const Appointment(
      id: 'apt1',
      doctorId: '1',
      doctorName: 'Dr. Emily Carter',
      specialty: 'Cardiologist',
      date: 'May 24, 2025',
      time: '10:30 AM',
      location: 'MediCare Clinic, New York',
      status: AppointmentStatus.upcoming,
    ),
    const Appointment(
      id: 'apt2',
      doctorId: '2',
      doctorName: 'Dr. James Wilson',
      specialty: 'Dermatologist',
      date: 'Apr 10, 2025',
      time: '11:00 AM',
      location: 'City Medical Center',
      status: AppointmentStatus.completed,
      notes: 'Follow-up in 3 months',
    ),
  ];

  List<Message> _messages = [
    const Message(
      id: 'msg1',
      doctorId: '1',
      doctorName: 'Dr. Emily Carter',
      specialty: 'Cardiologist',
      lastMessage: 'Please remember to take your medication before sleeping.',
      timestamp: '10:30 AM',
      unread: 2,
    ),
    const Message(
      id: 'msg2',
      doctorId: '2',
      doctorName: 'Dr. James Wilson',
      specialty: 'Dermatologist',
      lastMessage: 'Your test results look great! See you next month.',
      timestamp: 'Yesterday',
      unread: 0,
    ),
    const Message(
      id: 'msg3',
      doctorId: '4',
      doctorName: 'Dr. Michael Lee',
      specialty: 'Orthopedic Surgeon',
      lastMessage: 'How is the knee feeling after the exercises?',
      timestamp: 'Mon',
      unread: 1,
    ),
  ];

  final Map<String, List<ChatMessage>> _chats = {
    '1': [
      const ChatMessage(
          id: 'c1',
          text: 'Hello Dr. Carter, I have a question about my medication.',
          isUser: true,
          time: '10:00 AM'),
      const ChatMessage(
          id: 'c2',
          text: 'Of course Sarah, what would you like to know?',
          isUser: false,
          time: '10:05 AM'),
      const ChatMessage(
          id: 'c3', text: 'Can I take it with food?', isUser: true, time: '10:10 AM'),
      const ChatMessage(
          id: 'c4',
          text: 'Please remember to take your medication before sleeping.',
          isUser: false,
          time: '10:30 AM'),
    ],
    '2': [
      const ChatMessage(
          id: 'c5',
          text: 'Doctor, the cream is working well.',
          isUser: true,
          time: 'Yesterday'),
      const ChatMessage(
          id: 'c6',
          text: 'Your test results look great! See you next month.',
          isUser: false,
          time: 'Yesterday'),
    ],
    '4': [
      const ChatMessage(
          id: 'c7',
          text: 'How is the knee feeling after the exercises?',
          isUser: false,
          time: 'Mon'),
      const ChatMessage(
          id: 'c8', text: 'Much better, thank you!', isUser: true, time: 'Mon'),
    ],
  };

  final Set<String> _favoriteDoctors = {};

  List<Appointment> get appointments => List.unmodifiable(_appointments);
  List<Message> get messages => List.unmodifiable(_messages);
  Set<String> get favoriteDoctors => Set.unmodifiable(_favoriteDoctors);

  List<ChatMessage> getChats(String doctorId) =>
      List.unmodifiable(_chats[doctorId] ?? []);

  bool isFavorite(String doctorId) => _favoriteDoctors.contains(doctorId);

  void toggleFavorite(String doctorId) {
    if (_favoriteDoctors.contains(doctorId)) {
      _favoriteDoctors.remove(doctorId);
    } else {
      _favoriteDoctors.add(doctorId);
    }
    notifyListeners();
  }

  void bookAppointment({
    required String doctorId,
    required String doctorName,
    required String specialty,
    required String date,
    required String time,
    required String location,
  }) {
    final apt = Appointment(
      id: 'apt_${DateTime.now().millisecondsSinceEpoch}',
      doctorId: doctorId,
      doctorName: doctorName,
      specialty: specialty,
      date: date,
      time: time,
      location: location,
      status: AppointmentStatus.upcoming,
    );
    _appointments = [apt, ..._appointments];
    notifyListeners();
  }

  void cancelAppointment(String id) {
    _appointments = _appointments.map((a) {
      if (a.id == id) return a.copyWith(status: AppointmentStatus.cancelled);
      return a;
    }).toList();
    notifyListeners();
  }

  void sendMessage(
      String doctorId, String text, String doctorName, String specialty) {
    final now = TimeOfDay.now();
    final timeStr =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final msg = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      text: text,
      isUser: true,
      time: timeStr,
    );
    _chats[doctorId] = [...(_chats[doctorId] ?? []), msg];
    final existing = _messages.indexWhere((m) => m.doctorId == doctorId);
    if (existing >= 0) {
      final updated = List<Message>.from(_messages);
      updated[existing] = updated[existing].copyWith(
        lastMessage: text,
        timestamp: 'Just now',
        unread: 0,
      );
      _messages = updated;
    } else {
      _messages = [
        Message(
          id: 'thread_${DateTime.now().millisecondsSinceEpoch}',
          doctorId: doctorId,
          doctorName: doctorName,
          specialty: specialty,
          lastMessage: text,
          timestamp: 'Just now',
          unread: 0,
        ),
        ..._messages,
      ];
    }
    notifyListeners();
  }

  Doctor? getDoctorById(String id) {
    try {
      return doctors.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }
}
