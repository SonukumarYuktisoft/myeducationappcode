class NoteModel {
  final String id;
  final String title;
  final String description;
  final String pdfUrl;
  final String thumbnailUrl;
  final String category;
  final String teacherName;
  final DateTime createdAt;
  final bool isFree;
  final bool isPdf;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.pdfUrl,
    required this.thumbnailUrl,
    required this.category,
    required this.teacherName,
    required this.createdAt,
    this.isFree = true,
    this.isPdf = true,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      pdfUrl: json['pdfUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      category: json['category'],
      teacherName: json['teacherName'],
      createdAt: DateTime.parse(json['createdAt']),
      isFree: json['isFree'] ?? true,
      isPdf: json['isPdf'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'pdfUrl': pdfUrl,
      'thumbnailUrl': thumbnailUrl,
      'category': category,
      'teacherName': teacherName,
      'createdAt': createdAt.toIso8601String(),
      'isFree': isFree,
      'isPdf': isPdf,
    };
  }
}