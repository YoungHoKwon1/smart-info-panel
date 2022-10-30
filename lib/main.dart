import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_info_panel/classinfo30.dart';
//import 'package:easy_localization/easy_localization.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'childlifedata.dart';
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
  //static const tokenStorage = FlutterSecureStorage();
  @override
  initState() async{
    //await tokenStorage.write(key: "token", value: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWNhdGlvbiI6MSwidmVyc2lvbiI6IjAuMC40IiwiaWF0IjoxNjY2MzQ4NjA0LCJleHAiOjE2Njg5NDA2MDQsImlzcyI6ImFpam9hIn0.6IL9-icuHh8DjHJRnKol8MFz92u3bhKtZDUtqzXY5cg");
  }
  @override
  State<SmartInfoPanelMain> createState() => _SmartInfoPanelMainState();
}

class _SmartInfoPanelMainState extends State<SmartInfoPanelMain> {
  
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
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ChildLifeData()));
              // Navigator.push(context, MaterialPageRoute(builder: (context) => GraphTest()));
              Navigator.push(context, MaterialPageRoute(builder: (context) => ClassInfo30()));
            },
            child: Text('시작'),
          )),
    );
  }
}
