// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    id: json['id'] as int,
    fcmToken: json['fcmToken'] as String,
    gender: json['sex'] as String,
    city: json['city'] as String,
    university: json['university'] as String,
    major: json['major'] as String,
    birthYear: json['birthYear'] as String,
    phoneNumber: json['phoneNumber'] as String,
    studentID: json['studentID'] as int,
    possibleMessageOfSend: json['possibleMessageOfSend'] as int,
    authorization: json['authorization'] as String,
    isShowMyInfo: json['isShowMyInfo'] as bool,
    isNotMeetingSameUniversity: json['isNotMeetingSameUniversity'] as bool,
    isNotMeetingSameMajor: json['isNotMeetingSameMajor'] as bool,
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
  'id': instance.id,
  'fcmToken': instance.fcmToken,
  'sex': instance.gender,
  'city': instance.city,
  'university': instance.university,
  'major': instance.major,
  'birthYear': instance.birthYear,
  'phoneNumber': instance.phoneNumber,
  'studentID': instance.studentID,
  'possibleMessageOfSend': instance.possibleMessageOfSend,
  'authorization': instance.authorization,
  'isShowMyInfo': instance.isShowMyInfo,
  'isNotMeetingSameUniversity': instance.isNotMeetingSameUniversity,
  'isNotMeetingSameMajor': instance.isNotMeetingSameMajor,
};