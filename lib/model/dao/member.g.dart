// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  if (json['gender'] == 1)
    json['gender'] = '남자';
  else if (json['gender'] == 0) json['gender'] = '여자';
  return Member(
    userID: json['id'] as int,
    authID: json['authID'] as String,
    fcmToken: json['fcmToken'] as String,
    gender: json['gender'] as String,
    city: json['address'] as String,
    university: json['school'] as String,
    department: json['department'] as String,
    birthYear: json['birth_year'] as int,
    phoneNumber: json['num'] as String,
    studentID: json['student_id'] as int,
    studentImageNumber: json['img'] as int,
    possibleMessageOfSend: json['possibleMessageOfSend'] as int,
    studentCardImage: json['studentCardImage'] as File,
    isShowMyInfo: (json['provide'] == 1 ? false : true),
    isNotMatchingSameUniversity: (json['school_matching'] == 1 ? true : false),
    isNotMatchingSameDepartment: (json['department_matching'] == 1
        ? true
        : false),
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) =>
    <String, dynamic>{
      'id': instance.userID ?? -1,
      'authID': instance.authID ?? -1,
      'fcmToken': instance.fcmToken,
      'gender': instance.gender ?? "null",
      'address': instance.city ?? "null",
      'school': instance.university ?? "null",
      'department': instance.department ?? "null",
      'birth_year': instance.birthYear ?? -1,
      'num': instance.phoneNumber ?? "null",
      'studentID': instance.studentID ?? -1,
      'img': instance.studentImageNumber ?? -1,
      'possibleMessageOfSend': instance.possibleMessageOfSend ?? -1,
      'studentCardImage': instance.studentCardImage,
      'provide': instance.isShowMyInfo ?? false,
      'school_matching': instance.isNotMatchingSameUniversity ?? false,
      'department_matching': instance.isNotMatchingSameDepartment ?? false,
    };
