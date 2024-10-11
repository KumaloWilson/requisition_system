import 'comment.dart';

class Note {
  String noteID;
  String title;
  String description;
  String content;
  String email;
  String addedBy;
  DateTime dateAdded;
  List<Comment> comments;

  Note({
    required this.noteID,
    required this.title,
    required this.description,
    required this.email,
    required this.content,
    required this.addedBy,
    required this.dateAdded,
    this.comments = const [],
  });

  Map<String, dynamic> toJson() => {
    'noteID': noteID,
    'title': title,
    'description': description,
    'email': email,
    'content': content,
    'addedBy': addedBy,
    'dateAdded': dateAdded.toIso8601String(),
    'comments': comments.map((comment) => comment.toJson()).toList(),
  };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    noteID: json['noteID'],
    title: json['title'],
    description: json['description'],
    email: json['email'],
    content: json['content'],
    addedBy: json['addedBy'],
    dateAdded: DateTime.parse(json['dateAdded']),
    comments: (json['comments'] as List<dynamic>)
        .map((comment) => Comment.fromJson(comment))
        .toList(),
  );
}
