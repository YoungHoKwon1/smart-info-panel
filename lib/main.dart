import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_info_panel/childlifedata.dart';
import 'package:smart_info_panel/classinfo30.dart';
import 'package:smart_info_panel/classinfo20.dart';
import 'package:smart_info_panel/kinder_info_2.dart';
import 'package:smart_info_panel/kinder_info_3.dart';
//import 'package:easy_localization/easy_localization.dart';

import 'classinfo10.dart';
import 'classinfo30.dart';
import 'fl_graph_test.dart';

//maindart change test

final supportedLocales = [Locale('en', 'US'), Locale('ko', 'KR')];

void main() async {
  await ScreenUtil.ensureScreenSize(); //화면 비율 맞추기 위함
  // await EasyLocalization.ensureInitialized();//외국어번역

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

  //static const tokenStorage = FlutterSecureStorage();


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1920.w,
      height: 1080.w,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
          width: 200.w,
          height: 100.w,
          color: Colors.white,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChildLifeData()));
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ClassInfo20())); //성민
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ClassInfo10())); //건희
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ClassInfo30())); //영호
              // Navigator.push(context, MaterialPageRoute(builder: (context) => KinderInfo2())); //영호
              // Navigator.push(context, MaterialPageRoute(builder: (context) => KinderInfo3())); //영호
              // Navigator.push(context, MaterialPageRoute(builder: (context) => GraphTest()));
            },
            child: Text('데모 시작'),
          )),
    );
  }
}
