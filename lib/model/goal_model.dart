class GoalModel {
  final String? id;
  final DateTime createdAt;
  final String goalTitle;
  final double amount;
  final DateTime completionDate;
  final String type;
  final List<InstalmentModel> instalment;

  GoalModel({
    this.id,
    required this.createdAt,
    required this.type,
    required this.goalTitle,
    required this.amount,
    required this.completionDate,
    this.instalment = const <InstalmentModel>[],
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
        id: json['id'],
        createdAt: DateTime.parse(json['createdAt']),
        type: json['type'],
        goalTitle: json['goal_title'],
        amount: json['goal_amount'],
        completionDate: DateTime.parse(json['completion_date']),
        instalment: json['instalment'] != null
            ? List<InstalmentModel>.from(
                json['instalment'].map(
                  (e) => InstalmentModel.fromJson(e),
                ),
              )
            : <InstalmentModel>[],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'type': type,
        'goal_title': goalTitle,
        'goal_amount': amount,
        'completion_date': completionDate.toIso8601String(),
        'instalment': List.from(instalment.map((e) => e.toJson())),
      };

  GoalModel copy(
    String id, {
    DateTime? createdAt,
    String? goalTitle,
    String? type,
    double? amount,
    DateTime? completionDate,
    List<InstalmentModel>? instalment,
  }) =>
      GoalModel(
        id: id,
        createdAt: createdAt ?? this.createdAt,
        type: type ?? this.type,
        goalTitle: goalTitle ?? this.goalTitle,
        amount: amount ?? this.amount,
        completionDate: completionDate ?? this.completionDate,
        instalment: instalment ?? this.instalment,
      );
}

class InstalmentModel {
  final double amount;
  final DateTime date;

  InstalmentModel({required this.amount, required this.date});

  factory InstalmentModel.fromJson(Map<String, dynamic> json) => InstalmentModel(
        amount: json['amount'],
        date: DateTime.parse(json['date']),
      );

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'date': date.toIso8601String(),
      };
}
