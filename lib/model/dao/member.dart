class Member {
  int id;
  String sex;
  String region;
  String university;
  String birthYear;
  int studentID;
  int possibleMessageOfSend;
  bool isNotMeetingSameUniversity;
  bool isNotMeetingPhoneList;

  Member(
      {this.sex = '남성',
      this.region,
      this.university,
      this.birthYear,
      this.studentID,
      this.possibleMessageOfSend = 5,
      this.isNotMeetingSameUniversity = false,
      this.isNotMeetingPhoneList = false});

  Member.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        sex = map['sex'],
        region = map['region'],
        university = map['university'],
        birthYear = map['birthYear'],
        studentID = map['studentID'],
        possibleMessageOfSend = map['possibleMessageOfSend'],
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
        '\possibleMessageOfSend:' +
        possibleMessageOfSend.toString() +
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
        'possibleMessageOfSend': possibleMessageOfSend,
        'isNotMeetingSameUniversity': isNotMeetingSameUniversity,
        'isNotMeetingPhoneList': isNotMeetingPhoneList,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Member &&
          runtimeType == other.runtimeType &&
          sex == other.sex &&
          region == other.region &&
          university == other.university &&
          birthYear == other.birthYear &&
          isNotMeetingSameUniversity == other.isNotMeetingSameUniversity &&
          isNotMeetingPhoneList == other.isNotMeetingPhoneList;

  @override
  int get hashCode =>
      sex.hashCode ^
      region.hashCode ^
      university.hashCode ^
      birthYear.hashCode ^
      isNotMeetingSameUniversity.hashCode ^
      isNotMeetingPhoneList.hashCode;
}
