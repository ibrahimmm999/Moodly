import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MoodDataModel extends Equatable {
  final Timestamp date;
  final double score;

  const MoodDataModel({
    required this.date,
    required this.score,
  });

  factory MoodDataModel.fromJson(Map<String, dynamic> json) {
    return MoodDataModel(
      date: json['date'],
      score: json['score'].toDouble(),
    );
  }
  Map<String, dynamic> toJson() => {
        'date': date,
        'score': score,
      };

  @override
  List<Object?> get props => [
        date,
        score,
      ];
}
