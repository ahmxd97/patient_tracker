class Record {
  final int? id;
  final int patientId;
  final String note;

  Record({this.id, required this.patientId, required this.note});

  Map<String, dynamic> toMap() => {
        'id': id,
        'patient_id': patientId,
        'note': note,
      };
}
