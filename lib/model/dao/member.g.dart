// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    id: json['id'] as int,
    sex: json['sex'] as String,
    region: json['region'] as String,
    university: json['university'] as String,
    major: json['major'] as String,
    birthYear: json['birthYear'] as int,
    phoneNumber: json['phoneNumber'] as String,
    studentID: json['studentID'] as int,
    possibleMessageOfSend: json['possibleMessageOfSend'] as int,
    isAuthorization: json['isAuthorization'] as bool,
    isNotMeetingSameUniversity: json['isNotMeetingSameUniversity'] as bool,
    isNotMeetingSameMajor: json['isNotMeetingSameMajor'] as bool,
    studentCardImage: json['studentCardImage'] as File,
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'sex': instance.sex,
      'region': instance.region,
      'university': instance.university,
      'major': instance.major,
      'birthYear': instance.birthYear,
      'phoneNumber': instance.phoneNumber,
      'studentID': instance.studentID,
      'possibleMessageOfSend': instance.possibleMessageOfSend,
      'isAuthorization': instance.isAuthorization,
      'isNotMeetingSameUniversity': instance.isNotMeetingSameUniversity,
      'isNotMeetingSameMajor': instance.isNotMeetingSameMajor,
      'studentCardImage': instance.studentCardImage,
    };
