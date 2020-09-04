class Member {
  String sex;
  String region; // 지역
  String university;
  String studentCard;
  String birthYear;
  int studentID;
  bool isNotMeetingSameUniversity = false;
  bool isNotMeetingPhoneList = false;

  @override
  String toString() {
    return 'sex=' + sex +
        'region=' + region +
        'university' + university +
        'studentCard' + studentCard +
        'studentID' + studentID.toString() +
        'birthYear' + birthYear.toString() +
        'isNotMeetingSameUniversity' + isNotMeetingSameUniversity.toString() +
        'isNotMeetingPhoneList' + isNotMeetingPhoneList.toString();
  }
}
