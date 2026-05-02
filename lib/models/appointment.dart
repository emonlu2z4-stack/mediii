enum AppointmentStatus { upcoming, completed, cancelled }

class Appointment {
  final String id;
  final String doctorId;
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final String location;
  final AppointmentStatus status;
  final String? notes;

  const Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
    this.notes,
  });

  Appointment copyWith({AppointmentStatus? status, String? notes}) {
    return Appointment(
      id: id,
      doctorId: doctorId,
      doctorName: doctorName,
      specialty: specialty,
      date: date,
      time: time,
      location: location,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}
