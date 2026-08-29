class MyNote {
  final String title;
  final String description;
  final String category;
  final DateTime dateTime;

  MyNote({
    required this.title,
    required this.description,
    required this.category,
    required this.dateTime,
  });

  // MyNote → Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  // Map → MyNote
  factory MyNote.fromMap(Map<String, dynamic> map) {
    return MyNote(
      title: map['title'],
      description: map['description'],
      category: map['category'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}