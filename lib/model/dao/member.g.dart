// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    userID: json['userID'] as int,
    authID: json['authID'] as String,
    fcmToken: json['fcmToken'] as String,
    gender: json['gender'] as String,
    city: json['city'] as String,
    university: json['university'] as String,
    department: json['department'] as String,
    birthYear: json['birthYear'] as int,
    phoneNumber: json['phoneNumber'] as String,
    studentID: json['studentID'] as int,
    possibleMessageOfSend: json['possibleMessageOfSend'] as int,
    studentCardImage: json['studentCardImage'] as File,
    isShowMyInfo: json['isShowMyInfo'] as bool,
    isNotMatchingSameUniversity: json['isNotMatchingSameUniversity'] as bool,
    isNotMatchingSameDepartment: json['isNotMatchingSameDepartment'] as bool,
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'userID': instance.userID ?? -1,
      'authID': instance.authID ?? -1,
      'fcmToken': instance.fcmToken,
      'gender': instance.gender ?? "null",
      'city': instance.city ?? "null",
      'university': instance.university ?? "null",
      'department': instance.department ?? "null",
      'birthYear': instance.birthYear ?? -1,
      'phoneNumber': instance.phoneNumber ?? "null",
      'studentID': instance.studentID ?? -1,
      'possibleMessageOfSend': instance.possibleMessageOfSend ?? -1,
      'studentCardImage': instance.studentCardImage,
      'isShowMyInfo': instance.isShowMyInfo ?? false,
      'isNotMatchingSameUniversity':
          instance.isNotMatchingSameUniversity ?? false,
      'isNotMatchingSameDepartment': instance.isNotMatchingSameDepartment ?? false,
    };
