class Message {
  final String id;
  final String doctorId;
  final String doctorName;
  final String specialty;
  final String lastMessage;
  final String timestamp;
  final int unread;

  const Message({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.lastMessage,
    required this.timestamp,
    required this.unread,
  });

  Message copyWith({String? lastMessage, String? timestamp, int? unread}) {
    return Message(
      id: id,
      doctorId: doctorId,
      doctorName: doctorName,
      specialty: specialty,
      lastMessage: lastMessage ?? this.lastMessage,
      timestamp: timestamp ?? this.timestamp,
      unread: unread ?? this.unread,
    );
  }
}

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final String time;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.time,
  });
}

class Prescription {
  final String id;
  final String doctorName;
  final String date;
  final List<Medication> medications;

  const Prescription({
    required this.id,
    required this.doctorName,
    required this.date,
    required this.medications,
  });
}

class Medication {
  final String name;
  final String dosage;
  final String frequency;

  const Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
  });
}
