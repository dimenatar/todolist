import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  String text;
  Timestamp date;
  Task({required this.id, required this.title, this.text = "", required this.date});

  static fromJson(r) {
    return Task(
      id: r['id'],
      title: r['title'],
      text: r['text'],
      date: r['date'],
    );
  }

    Map<String, dynamic> toJson() =>
        {
          'id': id,
          'title': title,
          'text': text,
          'date': date,
        };

}