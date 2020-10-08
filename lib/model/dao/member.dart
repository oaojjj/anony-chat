import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  int id;
  String fcmToken;
  String gender;
  String city;
  String university;
  String major;
  String birthYear;
  String phoneNumber;
  int studentID;
  int possibleMessageOfSend;
  String authorization;
  bool isShowMyInfo;
  bool isNotMeetingSameUniversity;
  bool isNotMeetingSameMajor;

  // File studentCardImage;

  Member({
    this.id,
    this.fcmToken,
    this.gender = '남자',
    this.city,
    this.university,
    this.major,
    this.birthYear,
    this.phoneNumber,
    this.studentID,
    this.possibleMessageOfSend = 2,
    this.authorization = 'authorizationsWaiting',
    this.isShowMyInfo = false,
    this.isNotMeetingSameUniversity = false,
    this.isNotMeetingSameMajor = false,
    //this.studentCardImage
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);

  @override
  String toString() {
    return 'Member{id: $id, fcmToken: $fcmToken, gender: $gender, city: $city, university: $university, major: $major, birthYear: $birthYear, phoneNumber: $phoneNumber, studentID: $studentID, possibleMessageOfSend: $possibleMessageOfSend, authorization: $authorization, isShowMyInfo: $isShowMyInfo, isNotMeetingSameUniversity: $isNotMeetingSameUniversity, isNotMeetingSameMajor: $isNotMeetingSameMajor}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Member &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fcmToken == other.fcmToken &&
          gender == other.gender &&
          city == other.city &&
          university == other.university &&
          major == other.major &&
          birthYear == other.birthYear &&
          phoneNumber == other.phoneNumber &&
          studentID == other.studentID &&
          possibleMessageOfSend == other.possibleMessageOfSend &&
          authorization == other.authorization &&
          isShowMyInfo == other.isShowMyInfo &&
          isNotMeetingSameUniversity == other.isNotMeetingSameUniversity &&
          isNotMeetingSameMajor == other.isNotMeetingSameMajor;

  @override
  int get hashCode =>
      id.hashCode ^
      fcmToken.hashCode ^
      gender.hashCode ^
      city.hashCode ^
      university.hashCode ^
      major.hashCode ^
      birthYear.hashCode ^
      phoneNumber.hashCode ^
      studentID.hashCode ^
      possibleMessageOfSend.hashCode ^
      authorization.hashCode ^
      isShowMyInfo.hashCode ^
      isNotMeetingSameUniversity.hashCode ^
      isNotMeetingSameMajor.hashCode;
}
