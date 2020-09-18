import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  int id;
  String sex;
  String region;
  String university;
  String major;
  int birthYear;
  String phoneNumber;
  int studentID;
  int possibleMessageOfSend;
  String authorization;
  bool isNotMeetingSameUniversity;
  bool isNotMeetingSameMajor;
  File studentCardImage;

  Member(
      {this.id,
      this.sex = '남자',
      this.region,
      this.university,
      this.major,
      this.birthYear,
      this.phoneNumber,
      this.studentID,
      this.possibleMessageOfSend = 5,
      this.authorization = 'authorizationsWaiting',
      this.isNotMeetingSameUniversity = false,
      this.isNotMeetingSameMajor = false,
      this.studentCardImage
      });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);

  @override
  String toString() {
    return 'Member{sex: $sex, region: $region, university: $university, major: $major, birthYear: $birthYear, phoneNumber: $phoneNumber, studentID: $studentID, isNotMeetingSameUniversity: $isNotMeetingSameUniversity, isNotMeetingSameMajor: $isNotMeetingSameMajor, studentCardImage: $studentCardImage}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Member &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          sex == other.sex &&
          region == other.region &&
          university == other.university &&
          major == other.major &&
          birthYear == other.birthYear &&
          phoneNumber == other.phoneNumber &&
          studentID == other.studentID &&
          possibleMessageOfSend == other.possibleMessageOfSend &&
          authorization == other.authorization &&
          isNotMeetingSameUniversity == other.isNotMeetingSameUniversity &&
          isNotMeetingSameMajor == other.isNotMeetingSameMajor &&
          studentCardImage == other.studentCardImage;

  @override
  int get hashCode =>
      id.hashCode ^
      sex.hashCode ^
      region.hashCode ^
      university.hashCode ^
      major.hashCode ^
      birthYear.hashCode ^
      phoneNumber.hashCode ^
      studentID.hashCode ^
      possibleMessageOfSend.hashCode ^
      authorization.hashCode ^
      isNotMeetingSameUniversity.hashCode ^
      isNotMeetingSameMajor.hashCode ^
      studentCardImage.hashCode;
}
