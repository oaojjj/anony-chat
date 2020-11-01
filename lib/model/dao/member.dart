import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member {
  int userID; // 회원번호
  String authID; // 카카오톡 아이디 번호
  String fcmToken;
  String gender;
  String city;
  String university;
  String department;
  int birthYear;
  String phoneNumber;
  int studentID;
  int studentImageNumber;
  int possibleMessageOfSend;
  bool isShowMyInfo;
  bool isNotMatchingSameUniversity;
  bool isNotMatchingSameDepartment;
  File studentCardImage;

  Member(
      {this.userID,
      this.authID,
      this.fcmToken,
      this.gender = '남자',
      this.city,
      this.university,
      this.department,
      this.birthYear,
      this.phoneNumber,
      this.studentID,
      this.studentImageNumber,
      this.possibleMessageOfSend = 2,
      this.isShowMyInfo = false,
      this.isNotMatchingSameUniversity = false,
      this.isNotMatchingSameDepartment = false,
      this.studentCardImage});

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);

  @override
  String toString() {
    return 'Member{userID: $userID,authID: $authID, fcmToken: $fcmToken, gender: $gender, city: $city, university: $university, department: $department, birthYear: $birthYear, phoneNumber: $phoneNumber, studentID: $studentID, studentImageNumber: $studentImageNumber,possibleMessageOfSend: $possibleMessageOfSend, isShowMyInfo: $isShowMyInfo, isNotMatchingSameUniversity: $isNotMatchingSameUniversity, isNotMatchingSameDepartment: $isNotMatchingSameDepartment, studentCardImage: $studentCardImage}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Member &&
          runtimeType == other.runtimeType &&
          userID == other.userID &&
          authID == other.authID &&
          fcmToken == other.fcmToken &&
          gender == other.gender &&
          city == other.city &&
          university == other.university &&
          department == other.department &&
          birthYear == other.birthYear &&
          phoneNumber == other.phoneNumber &&
          studentID == other.studentID &&
          possibleMessageOfSend == other.possibleMessageOfSend &&
          isShowMyInfo == other.isShowMyInfo &&
          isNotMatchingSameUniversity == other.isNotMatchingSameUniversity &&
          isNotMatchingSameDepartment == other.isNotMatchingSameDepartment &&
          studentCardImage == other.studentCardImage;

  @override
  int get hashCode =>
      userID.hashCode ^
      authID.hashCode ^
      fcmToken.hashCode ^
      gender.hashCode ^
      city.hashCode ^
      university.hashCode ^
      department.hashCode ^
      birthYear.hashCode ^
      phoneNumber.hashCode ^
      studentID.hashCode ^
      possibleMessageOfSend.hashCode ^
      isShowMyInfo.hashCode ^
      isNotMatchingSameUniversity.hashCode ^
      isNotMatchingSameDepartment.hashCode ^
      studentCardImage.hashCode;
}
