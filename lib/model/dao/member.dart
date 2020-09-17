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
  bool isAuthorization;
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
      this.isAuthorization = false,
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
}
