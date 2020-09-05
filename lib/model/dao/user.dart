class User {
  String sex;
  String region;
  String university;
  String studentCardImage;
  String birthYear;
  int studentID;
  bool isNotMeetingSameUniversity;
  bool isNotMeetingPhoneList;

  User(
      {this.sex='남자',
      this.region,
      this.university,
      this.studentCardImage,
      this.birthYear,
      this.studentID,
      this.isNotMeetingSameUniversity=false,
      this.isNotMeetingPhoneList=false});

  @override
  String toString() {
    return 'sex:' +
        sex +
        '\nbirthYear:' +
        birthYear+
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
}
