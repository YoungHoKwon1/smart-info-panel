import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_info_panel/childlifedata.dart';
import 'package:smart_info_panel/classinfo20.dart';

import 'package:smart_info_panel/classinfo30.dart';
import 'package:smart_info_panel/teacher_info.dart';

import 'package:smart_info_panel/kinder_info_2.dart';
import 'package:smart_info_panel/kinder_info_3.dart';


import 'classinfo10.dart';
import 'classinfo30.dart';
import 'fl_graph_test.dart';

import 'dart:async';
//maindart change test

final supportedLocales = [Locale('en', 'US'), Locale('ko', 'KR')];

void main() async {
  await ScreenUtil.ensureScreenSize(); //화면 비율 맞추기 위함

  runApp(SmartInfoPanel());
}

//기본적인 앱들어갈때 세팅할것들
class SmartInfoPanel extends StatelessWidget {
  const SmartInfoPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: (ctx, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'NotoSansKR',
          ),
          home: const SmartInfoPanelMain(),
        );
      });
}

class SmartInfoPanelMain extends StatefulWidget {
  const SmartInfoPanelMain({Key? key}) : super(key: key);

  @override
  State<SmartInfoPanelMain> createState() => _SmartInfoPanelMainState();
}

class _SmartInfoPanelMainState extends State<SmartInfoPanelMain> {
  ///routing 순서, 20초마다 넘김
  ///어린이집소개페이지(KinderInfo2,3)
  ///선생님소개(TeacherInfo)
  ///학급소개 페이지(ClassInfo10,20,30)
  ///학급공지 페이지()
  ///영유아 인식 페이지
  ///아이생활 데이터(ChildLifeData)
  @override
  void initState() {
    super.initState();
    _callApi();
    // 자동 라우팅, Timer()쓰려면 import 'dart:async'; 필요
    // Timer(Duration(seconds: 20), () {
    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>KinderInfo2()));
    // });
  }

  void _callApi() async {

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        width: 1920.w,
        height: 980.w,
        child: Container(
            width: 200.w,
            height: 100.w,
            color: Colors.white,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ChildLifeData()));
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ClassInfo20())); //성민
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ClassInfo10())); //건희
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ClassInfo30())); //영호
                // Navigator.push(context, MaterialPageRoute(builder: (context) => KinderInfo2())); //영호

                Navigator.push(context, MaterialPageRoute(builder: (context) => KinderInfo3())); //영호

                // Navigator.push(context, MaterialPageRoute(builder: (context) => GraphTest()));
                // Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherInfo())); //선생님소개
              },
              child: Text('데모 시작'),
            )),
      ),
    );
  }
}
