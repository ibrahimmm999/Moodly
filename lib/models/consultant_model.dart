import 'package:equatable/equatable.dart';

class ConsultantModel extends Equatable {
  final String id;
  final String name;
  final String photoUrl;
  final String phone;
  final String openTime;
  final String address;
  final String province;

  const ConsultantModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.phone,
    required this.openTime,
    required this.address,
    required this.province,
  });

  // Untuk Get
  factory ConsultantModel.fromJson(String id, Map<String, dynamic> json) =>
      ConsultantModel(
        id: id,
        name: json['name'],
        photoUrl: json['photoUrl'],
        phone: json['phone'],
        openTime: json['openTime'],
        address: json['address'],
        province: json['province'],
      );

  // Untuk post
  Map<String, dynamic> toJson() => {
        'name': name,
        'photoUrl': photoUrl,
        'phone': phone,
        'openTime': openTime,
        'address': address,
        'province': province,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        phone,
        openTime,
        address,
        province,
      ];
}
