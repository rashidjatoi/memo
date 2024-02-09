class NotesModel {
  String? title;
  String? description;
  String? notesId;

  NotesModel({
    this.title,
    this.description,
    this.notesId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'notesId': notesId,
    };
  }

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      title: json['title'],
      description: json['description'],
      notesId: json['notesId'],
    );
  }
}
