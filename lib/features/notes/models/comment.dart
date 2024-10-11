class Comment {
  String addedBy;
  String description;
  DateTime dateAdded;

  Comment({
    required this.addedBy,
    required this.description,
    required this.dateAdded,
  });

  Map<String, dynamic> toJson() => {
    'addedBy': addedBy,
    'description': description,
    'dateAdded': dateAdded.toIso8601String(),
  };

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    addedBy: json['addedBy'],
    description: json['description'],
    dateAdded: DateTime.parse(json['dateAdded']),
  );
}
