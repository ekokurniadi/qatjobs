import 'dart:convert';

class CandidateSlots {
  List<History> histories;
  bool rejectedSlot;
  List<Slot> slots;
  Map<String, dynamic> selectSlot;
  String employerCancelNote;
  String employerFullName;
  String companyFullName;
  int isSlotRejected;
  int scheduleSelect;

  CandidateSlots({
    required this.histories,
    required this.rejectedSlot,
    required this.slots,
    required this.selectSlot,
    required this.employerCancelNote,
    required this.employerFullName,
    required this.companyFullName,
    required this.isSlotRejected,
    required this.scheduleSelect,
  });

  CandidateSlots copyWith({
    List<History>? histories,
    bool? rejectedSlot,
    List<Slot>? slots,
    Map<String, dynamic>? selectSlot,
    String? employerCancelNote,
    String? employerFullName,
    String? companyFullName,
    int? isSlotRejected,
    int? scheduleSelect,
  }) =>
      CandidateSlots(
        histories: histories ?? this.histories,
        rejectedSlot: rejectedSlot ?? this.rejectedSlot,
        slots: slots ?? this.slots,
        selectSlot: selectSlot ?? this.selectSlot,
        employerCancelNote: employerCancelNote ?? this.employerCancelNote,
        employerFullName: employerFullName ?? this.employerFullName,
        companyFullName: companyFullName ?? this.companyFullName,
        isSlotRejected: isSlotRejected ?? this.isSlotRejected,
        scheduleSelect: scheduleSelect ?? this.scheduleSelect,
      );

  factory CandidateSlots.fromJson(String str) =>
      CandidateSlots.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CandidateSlots.fromMap(Map<String, dynamic> json) => CandidateSlots(
        histories: List<History>.from(
            json["histories"].map((x) => History.fromMap(x))),
        rejectedSlot: json["rejectedSlot"],
        slots: json["slots"] != null
            ? List<Slot>.from(json["slots"].map((x) => Slot.fromMap(x)))
            : [],
        selectSlot: json['selectSlot'],
        employerCancelNote: json["employer_cancel_note"],
        employerFullName: json["employer_fullName"],
        companyFullName: json["company_fullName"],
        isSlotRejected: json["isSlotRejected"],
        scheduleSelect: json["scheduleSelect"],
      );

  Map<String, dynamic> toMap() => {
        "histories": List<dynamic>.from(histories.map((x) => x.toMap())),
        "rejectedSlot": rejectedSlot,
        "slots": List<dynamic>.from(slots.map((x) => x.toMap())),
        "selectSlot": {},
        "employer_cancel_note": employerCancelNote,
        "employer_fullName": employerFullName,
        "company_fullName": companyFullName,
        "isSlotRejected": isSlotRejected,
        "scheduleSelect": scheduleSelect,
      };
}

class History {
  String notes;
  String companyName;
  String scheduleCreatedAt;

  History({
    required this.notes,
    required this.companyName,
    required this.scheduleCreatedAt,
  });

  History copyWith({
    String? notes,
    String? companyName,
    String? scheduleCreatedAt,
  }) =>
      History(
        notes: notes ?? this.notes,
        companyName: companyName ?? this.companyName,
        scheduleCreatedAt: scheduleCreatedAt ?? this.scheduleCreatedAt,
      );

  factory History.fromJson(String str) => History.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory History.fromMap(Map<String, dynamic> json) => History(
        notes: json["notes"],
        companyName: json["company_name"],
        scheduleCreatedAt: json["schedule_created_at"],
      );

  Map<String, dynamic> toMap() => {
        "notes": notes,
        "company_name": companyName,
        "schedule_created_at": scheduleCreatedAt,
      };
}

class Slot {
  String notes;
  String scheduleDate;
  String scheduleTime;
  int jobScheduleId;
  bool isAllRejected;

  Slot({
    required this.notes,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.jobScheduleId,
    required this.isAllRejected,
  });

  Slot copyWith({
    String? notes,
    String? scheduleDate,
    String? scheduleTime,
    int? jobScheduleId,
    bool? isAllRejected,
  }) =>
      Slot(
        notes: notes ?? this.notes,
        scheduleDate: scheduleDate ?? this.scheduleDate,
        scheduleTime: scheduleTime ?? this.scheduleTime,
        jobScheduleId: jobScheduleId ?? this.jobScheduleId,
        isAllRejected: isAllRejected ?? this.isAllRejected,
      );

  factory Slot.fromJson(String str) => Slot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Slot.fromMap(Map<String, dynamic> json) => Slot(
        notes: json["notes"],
        scheduleDate: json["schedule_date"],
        scheduleTime: json["schedule_time"],
        jobScheduleId: json["job_Schedule_Id"],
        isAllRejected: json["isAllRejected"],
      );

  Map<String, dynamic> toMap() => {
        "notes": notes,
        "schedule_date": scheduleDate,
        "schedule_time": scheduleTime,
        "job_Schedule_Id": jobScheduleId,
        "isAllRejected": isAllRejected,
      };
}
