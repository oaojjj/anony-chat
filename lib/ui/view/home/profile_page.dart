import 'package:anony_chat/database/shared_preferences_controller.dart';
import 'package:anony_chat/model/dao/member.dart';
import 'package:anony_chat/ui/widget/bottom_button.dart';
import 'package:anony_chat/ui/widget/loading.dart';
import 'package:anony_chat/viewmodel/member_model.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  MemberModel _memberModel = MemberModel();
  Member _member;
  Member _fixProfile;

  List<String> _items = [];

  // true#남성 false#여성
  bool sexBtnColor = true;
  bool loading = true;

  // test data
  List<String> _itemsBirth = List<String>.generate(30, (i) {
    return (i + 1970).toString();
  });
  List<String> _itemsRegion = ['대구', '부산', '서울'];

  bool _fixColor = false;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fixColor = !(_member == _fixProfile);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('프로필'), centerTitle: true),
        body: _profileForm(_fixProfile),
      ),
    );
  }

  Widget _profileForm(Member member) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 24.0),
              Text('회원번호 #${member.id}', style: TextStyle(fontSize: 18.0)),
              Text(member.university, style: TextStyle(fontSize: 18.0)),
              SizedBox(height: 16.0),
              Divider(
                  color: Colors.black,
                  thickness: 1.0,
                  indent: 16.0,
                  endIndent: 16.0),
            ],
          ),
        ),
        SizedBox(height: 24.0),
        Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonTheme(
                  minWidth: 120.0,
                  height: 50.0,
                  child: FlatButton(
                    child: Text('남성', style: TextStyle(fontSize: 20.0)),
                    onPressed: () => setState(() => member.sex = '남성'),
                    color: member.sex == '남성'
                        ? Colors.amberAccent
                        : Colors.black26,
                  ),
                ),
                SizedBox(width: 24.0),
                ButtonTheme(
                  minWidth: 120.0,
                  height: 50.0,
                  child: FlatButton(
                    child: Text('여성', style: TextStyle(fontSize: 20.0)),
                    onPressed: () => setState(() => member.sex = '여성'),
                    color: member.sex == '여성'
                        ? Colors.amberAccent
                        : Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Text('태어난 해', style: TextStyle(fontSize: 24.0)),
                  SizedBox(height: 16.0),
                  Text('지역', style: TextStyle(fontSize: 24.0))
                ]),
                Column(children: [
                  // 객체 자체를 참조해야 setState 에서 참조 가능해서 변경 #primitive type은 불가
                  _buildDropDownButton(_items[0], member.birthYear, member),
                  SizedBox(height: 16.0),
                  _buildDropDownButton(_items[1], member.region, member)
                ])
              ],
            ),
          ],
        ),
        SizedBox(height: 24.0),
        Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('같은 대학교 학생 안만나기', style: TextStyle(fontSize: 18.0)),
              SizedBox(width: 8.0),
              Container(
                child: Switch(
                  value: member.isNotMeetingSameUniversity,
                  onChanged: (value) =>
                      setState(() => member.isNotMeetingSameUniversity = value),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('전화번호 목록 친구 안만나기', style: TextStyle(fontSize: 18.0)),
              SizedBox(width: 8.0),
              Container(
                child: Switch(
                    value: member.isNotMeetingSameMajor,
                    onChanged: (value) =>
                        setState(() => member.isNotMeetingSameMajor = value)),
              ),
            ]),
          ],
        ),
        SizedBox(height: 24.0),
        BottomButton(
          onPressed: _fixColor
              ? () {
                  _memberModel.updateProfile(_fixProfile);
                  _member = Member.fromJson(_fixProfile.toJson());
                  setState(() => _fixColor = false);
                }
              : null,
          text: '수정',
        ),
      ],
    );
  }

  Widget _buildDropDownButton(item, dynamic selectedValue, Member member) {
    return Container(
      height: 40.0,
      width: 100.0,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: item.selected,
          items: item.list.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          onChanged: (value) {
            setState(() => item.selected = value);
            _setDropDownValue(item.title, item.selected, member);
          },
        ),
      ),
    );
  }

  void _setDropDownValue(String title, String value, Member member) {
    switch (title) {
      case '지역':
        member.region = value;
        break;
      case '태어난해':
        member.birthYear = int.parse(value);
        break;
      default:
        throw Exception('set drop_down_value error');
        break;
    }
  }

  // TODO 수정 성공시 토스트메시지 띄우기
  _fetchData() async {
    _member = await SPController.loadProfile();
    _fixProfile = Member.fromJson(_member.toJson());
    _initUI();
    setState(() => loading = false);
  }

  _initUI() {
    sexBtnColor = _member.sex == '남성';
  }


}
