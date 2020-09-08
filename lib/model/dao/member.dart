class Member {
  int id;
  String sex;
  String region;
  String university;
  String studentCardImage;
  String birthYear;
  int studentID;
  bool isNotMeetingSameUniversity;
  bool isNotMeetingPhoneList;

  Member(
      {this.sex = '남자',
      this.region,
      this.university,
      this.studentCardImage,
      this.birthYear,
      this.studentID,
      this.isNotMeetingSameUniversity = false,
      this.isNotMeetingPhoneList = false});

  Member.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        sex = map['sex'],
        region = map['region'],
        university = map['university'],
        birthYear = map['birthYear'],
        studentID = map['studentID'],
        isNotMeetingSameUniversity = map['isNotMeetingSameUniversity'],
        isNotMeetingPhoneList = map['isNotMeetingPhoneList'];

  @override
  String toString() {
    return 'id:' +
        id.toString() +
        'sex:' +
        sex +
        '\nbirthYear:' +
        birthYear +
        '\nregion:' +
        region +
        '\nuniversity:' +
        university +
        '\nstudentID:' +
        studentID.toString() +
        '\nisNotMeetingSameUniversity:' +
        isNotMeetingSameUniversity.toString() +
        '\nisNotMeetingPhoneList:' +
        isNotMeetingPhoneList.toString();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'sex': sex,
        'region': region,
        'university': university,
        'birthYear': birthYear,
        'studentID': studentID,
        'isNotMeetingSameUniversity': isNotMeetingSameUniversity,
        'isNotMeetingPhoneList': isNotMeetingPhoneList,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Member &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          sex == other.sex &&
          region == other.region &&
          university == other.university &&
          studentCardImage == other.studentCardImage &&
          birthYear == other.birthYear &&
          studentID == other.studentID &&
          isNotMeetingSameUniversity == other.isNotMeetingSameUniversity &&
          isNotMeetingPhoneList == other.isNotMeetingPhoneList;

  @override
  int get hashCode =>
      id.hashCode ^
      sex.hashCode ^
      region.hashCode ^
      university.hashCode ^
      studentCardImage.hashCode ^
      birthYear.hashCode ^
      studentID.hashCode ^
      isNotMeetingSameUniversity.hashCode ^
      isNotMeetingPhoneList.hashCode;
}
