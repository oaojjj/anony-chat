// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    id: json['id'] as int,
    fcmToken: json['fcmToken'] as String,
    gender: json['gender'] as String,
    city: json['city'] as String,
    university: json['university'] as String,
    major: json['major'] as String,
    birthYear: json['birthYear'] as String,
    phoneNumber: json['phoneNumber'] as String,
    studentID: json['studentID'] as int,
    possibleMessageOfSend: json['possibleMessageOfSend'] as int,
    studentCardImagePath: json['studentCardImagePath'] as String,
    isShowMyInfo: json['isShowMyInfo'] as bool,
    isNotMatchingSameUniversity: json['isNotMatchingSameUniversity'] as bool,
    isNotMatchingSameMajor: json['isNotMatchingSameMajor'] as bool,
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id ?? -1,
      'fcmToken': instance.fcmToken,
      'gender': instance.gender ?? "error",
      'city': instance.city ?? "error",
      'university': instance.university ?? "error",
      'major': instance.major ?? "error",
      'birthYear': instance.birthYear ?? "error",
      'phoneNumber': instance.phoneNumber ?? "-1",
      'studentID': instance.studentID ?? -1,
      'possibleMessageOfSend': instance.possibleMessageOfSend ?? -1,
      'studentCardImagePath': instance.studentCardImagePath,
      'isShowMyInfo': instance.isShowMyInfo ?? false,
      'isNotMatchingSameUniversity':
          instance.isNotMatchingSameUniversity ?? false,
      'isNotMatchingSameMajor': instance.isNotMatchingSameMajor ?? false,
    };
