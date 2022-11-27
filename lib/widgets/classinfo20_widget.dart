import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_info_panel/api/infopanel.dart';
import 'dart:async';

import '../provider/class_data.dart';
import 'package:provider/provider.dart';

class ClassInfo20Widget extends StatefulWidget {
  const ClassInfo20Widget({Key? key}) : super(key: key);

  @override
  State<ClassInfo20Widget> createState() => _ClassInfo20WidgetState();
}

class _ClassInfo20WidgetState extends State<ClassInfo20Widget> {
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 410.w,
              height: 278.w,
              margin: EdgeInsets.only(left: 43.w, top: 8.w),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/class_info_deco/1class.png.png'))),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin:
                      EdgeInsets.only(left: 40.w, top: 127.w),
                      child: Text(context.watch<ClassDataProvider>().className,
                          style: TextStyle(
                            fontFamily: 'GamjaFlower',
                            color: const Color(0xff39605f),
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          )),
                    ),
                    Container(
                      width: 270.w,
                      height: 40.w,
                      margin: EdgeInsets.only(top: 15.w),
                      child: Center(
                        child: Text(
                          context.watch<ClassDataProvider>().classInfo[0].toString() +
                              '세 | ' +
                              context.watch<ClassDataProvider>().classInfo[1].toString() +
                              '명 | 남:' +
                              context.watch<ClassDataProvider>().classInfo[2].toString() +
                              '명 여:' +
                              context.watch<ClassDataProvider>().classInfo[3].toString() +
                              '명',
                          style: TextStyle(fontSize: 17.sp,
                            color: const Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///담임
            for (int i = 0; i < context.watch<ClassDataProvider>().teacherNum; i++) ...[
              Column(
                children: [
                  Container(
                    width: 180.w,
                    height: 180.w,
                    margin: EdgeInsets.only(left: 20.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(250),
                        child: context.watch<ClassDataProvider>().teacherImage[i],

                    ),

                  ),
                  Container(
                    width: 180.w,
                    height: 45.w,
                    margin: EdgeInsets.only(left: 30.w),
                    decoration: BoxDecoration(
                        color: const Color(0xffc7f7f5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        context.watch<ClassDataProvider>().teacherName[i],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: '.AppleSystemUIFont',
                        ),
                        strutStyle: StrutStyle(
                          fontSize: 18.sp,
                          forceStrutHeight: true,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ]

            ///담임
          ],
        ),

        ///아이들
        for (int i = 0; i < context.watch<ClassDataProvider>().row; i++) ...[
          Row(
            children: [
              for (int j = 0; j < context.watch<ClassDataProvider>().column; j++) ...[
                Column(
                  //사진+이름배치를 위해 column으로 시작
                  children: [
                    if (j == 0) ...[
                      Container(
                          width: 116.w,
                          height: 116.w,
                          margin: EdgeInsets.only(left: 132.w, top: 66.w),
                          child:ClipRRect(
                              borderRadius: BorderRadius.circular(250),
                          child: context.watch<ClassDataProvider>().childrenImage[context.watch<ClassDataProvider>().column * i + j]
                          ),
                      ),
                      Container(
                        width: 116.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                            color: const Color(0xffc7f7f5),
                            borderRadius:
                            BorderRadius.circular(17.5)),
                        margin: EdgeInsets.only(left: 132.w),
                        child: Center(
                          child: Text(context.watch<ClassDataProvider>().childrenName[context.watch<ClassDataProvider>().column * i + j],
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                color: const Color(0xff000000),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      )
                    ]else ...[
                      Container(
                        width: 116.w,
                        height: 116.w,
                        margin: EdgeInsets.only(left: 50.w, top: 66.w),
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(250),
                        child: Center(
                            child: context.watch<ClassDataProvider>().childrenImage[context.watch<ClassDataProvider>().column * i + j]),),
                      ),
                      Container(
                        width: 116.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                            color: const Color(0xffc7f7f5),
                            borderRadius:
                            BorderRadius.circular(17.5)),
                        margin: EdgeInsets.only(left: 50.w),
                        child: Center(
                          child: Text(context.watch<ClassDataProvider>().childrenName[context.watch<ClassDataProvider>().column * i + j],
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                color: const Color(0xff000000),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      )
                    ],
                  ],
                )
              ]
            ],
          )
        ],

        ///아이들
        ///나머지 아이들
        if (context.watch<ClassDataProvider>().rest != 0) ...[
          Row(
            children: [
              for (int j = 0; j < context.watch<ClassDataProvider>().rest; j++) ...[
                Column(
                  //사진+이름배치를 위해 column으로 시작
                  children: [
                    if (j == 0) ...[
                      Container(
                          width: 116.w,
                          height: 116.w,
                          margin: EdgeInsets.only(left: 133.w, top: 30.w),
                          child:ClipRRect(
                              borderRadius: BorderRadius.circular(250),
                          child: context.watch<ClassDataProvider>().childrenImage[context.watch<ClassDataProvider>().row * context.watch<ClassDataProvider>().column + j]))
                    ] else ...[
                      Container(
                          width: 116.w,
                          height: 116.w,
                          margin: EdgeInsets.only(left: 50.w, top: 30.w),
                          child:ClipRRect(
                              borderRadius: BorderRadius.circular(250),
                          child: Center(
                              child: context.watch<ClassDataProvider>().childrenImage[
                              context.watch<ClassDataProvider>().row * context.watch<ClassDataProvider>().column + j])))
                    ],
                    Container(
                      width: 116.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffc7f7f5),
                          borderRadius:
                          BorderRadius.circular(17.5)),
                      margin: EdgeInsets.only(left: 132.w),
                      child: Center(
                        child:
                        Text(context.watch<ClassDataProvider>().childrenName[context.watch<ClassDataProvider>().row * context.watch<ClassDataProvider>().column + j],
                            style: TextStyle(
                              fontFamily: 'NotoSansKR',
                              color: const Color(0xff000000),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                    )
                  ],

                  ///나머지 아이들
                )
              ]
            ],
          )
        ]
      ],
    );
  }
}
