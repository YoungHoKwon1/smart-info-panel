import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_info_panel/api/infopanel.dart';
import 'package:smart_info_panel/provider/notice_data.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import '../provider/class_data.dart';
import 'package:provider/provider.dart';

class NoticeWidget extends StatefulWidget {
  const NoticeWidget({Key? key}) : super(key: key);

  @override
  State<NoticeWidget> createState() => _NoticeWidgetState();
}


class _NoticeWidgetState extends State<NoticeWidget> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
            children: [
                 Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 480.w,
                          height: 300.w,
                          margin: EdgeInsets.only(left: 10.w, top: 32.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0x6663e6d7),
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(20.w),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29b1b1b1),
                                offset: Offset(-2.w, 2.w),
                                blurRadius: 6.w,
                                spreadRadius: 0.w,
                              ),
                              BoxShadow(
                                color: const Color(0x29dbdbdb),
                                offset: Offset(-2.w, -4.w),
                                blurRadius: 6.w,
                                spreadRadius: 0.w,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 27.w, top: 29.w),
                                      child: Text(context.watch<NoticedataProvider>().news,
                                          style: TextStyle(
                                            fontFamily: 'NotSanaKR',
                                            color: const Color(0xff898989),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ))
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 27.w, top: 30.w),
                                      child: Text(context.watch<NoticedataProvider>().months.toString() + '월' + context.watch<NoticedataProvider>().weeks.toString() + '주'+ context.watch<NoticedataProvider>().names.toString() +'주요행사',
                                          style: TextStyle(
                                            fontFamily: 'NotSanaKR',
                                            color: const Color(0xff39605f),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ))
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 27.w, top: 15.w),
                                      child: Text(context.watch<NoticedataProvider>().weekinfo,
                                          style: TextStyle(
                                            fontFamily: 'NotSanaKR',
                                            color: const Color(0xff39605f),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ))
                                  ),

                                  Container(
                                      width: 200,
                                      margin: EdgeInsets.only(
                                          left: 27.w, top: 20.w),
                                      child: Row(
                                        children: [
                                          Flexible(
                                              child: Text(context.watch<NoticedataProvider>().NewsComment,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontFamily: 'NotSanaKR',
                                                    color: const Color(
                                                        0xff000000),
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                  )
                                              )),
                                        ],
                                      )
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                                  Container(
                                    width: 480.w,
                                    height: 300.w,
                                    margin: EdgeInsets.only(left: 22.w, top: 32.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color(0x6663e6d7),
                                        width: 1.w,
                                      ),
                                      borderRadius: BorderRadius.circular(20.w),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x29b1b1b1),
                                          offset: Offset(-2.w, 2.w),
                                          blurRadius: 6.w,
                                          spreadRadius: 0.w,
                                        ),
                                        BoxShadow(
                                          color: const Color(0x29dbdbdb),
                                          offset: Offset(-2.w, -4.w),
                                          blurRadius: 6.w,
                                          spreadRadius: 0.w,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.only(left: 27.w, top: 29.w),
                                                child: Text(context.watch<NoticedataProvider>().today,
                                                    style: TextStyle(
                                                      fontFamily: 'NotSanaKR',
                                                      color: const Color(
                                                          0xff898989),
                                                      fontSize: 18.sp,
                                                      fontWeight: FontWeight.w700,
                                                      fontStyle: FontStyle.normal,
                                                    ))
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 27.w, top: 65.w),
                                                    child: Text("오늘은",
                                                        style: TextStyle(
                                                          fontFamily: 'GamjaFlower',
                                                          color: const Color(
                                                              0xff39605f),
                                                          fontSize: 30.sp,
                                                          fontWeight: FontWeight.w400,
                                                          fontStyle: FontStyle.normal,
                                                        ))
                                                ),
                                                Container(
                                                  width: 70.w,
                                                  height: 70.w,
                                                  margin: EdgeInsets.only(left: 20.w, top: 40.w),
                                                  child: const Center(
                                                    child: Image(
                                                        image: AssetImage(
                                                            'assets/childlifedata/baby_sample.png')),
                                                  ),
                                                ),
                                                Container(
                                                  width: 70.w,
                                                  height: 70.w,
                                                  margin: EdgeInsets.only(left: 19.w, top: 40.w),
                                                  child: const Center(
                                                    child: Image(
                                                        image: AssetImage(
                                                            'assets/childlifedata/baby_sample.png')),
                                                  ),
                                                ),
                                                Container(
                                                  width: 70.w,
                                                  height: 70.w,
                                                  margin: EdgeInsets.only(left: 19.w, top: 40.w),
                                                  child: const Center(
                                                    child: Image(
                                                        image: AssetImage(
                                                            'assets/childlifedata/baby_sample.png')),
                                                  ),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(left: 24.w, top: 65.w),
                                                    child: Text("생일!",
                                                        style: TextStyle(
                                                          fontFamily: 'GamjaFlower',
                                                          color: const Color(0xff39605f),
                                                          fontSize: 30.sp,
                                                          fontWeight: FontWeight.w400,
                                                          fontStyle: FontStyle.normal,
                                                        ))
                                                ),
                                              ],
                                            ),
                                            Row(
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(left: 130.w, top: 10.w),
                                                      child: Text("김아가",
                                                          style: TextStyle(
                                                            fontFamily: 'GamjaFlower',
                                                            color: const Color(0xff39605f),
                                                            fontSize: 20.sp,
                                                            fontWeight: FontWeight.w400,
                                                            fontStyle: FontStyle.normal,
                                                          ))
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(left: 41.w, top: 10.w),
                                                      child: Text("박모세",
                                                          style: TextStyle(
                                                            fontFamily: 'GamjaFlower',
                                                            color: const Color(0xff39605f),
                                                            fontSize: 20.sp,
                                                            fontWeight: FontWeight.w400,
                                                            fontStyle: FontStyle.normal,
                                                          ))
                                                  ),
                                                  Container(
                                                      margin: EdgeInsets.only(left: 41.w, top: 10.w),
                                                      child: Text("이자랑",
                                                          style: TextStyle(
                                                            fontFamily: 'GamjaFlower',
                                                            color: const Color(0xff39605f),
                                                            fontSize: 20.sp,
                                                            fontWeight: FontWeight.w400,
                                                            fontStyle: FontStyle.normal,
                                                          ))
                                                  ),
                                                ]
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(left: 20.w, top: 30.w),
                                                child: Text("친구한테 생일축하한다고 말해주세요!(등의 한마디)",
                                                    style: TextStyle(
                                                      fontFamily: 'NotSanaKR',
                                                      color: const Color(0xff000000),
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.normal,
                                                    ))
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 50.w, top: 50.w),
                                  child: Text("행사제목 (날짜)",
                                      style: TextStyle(
                                        fontFamily: 'NotSanaKR',
                                        color: const Color(0xff39605f),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ))
                              ),
                              for(int i = 0; i < context.watch<NoticedataProvider>().ro; i++)...[
                                Row(
                                    children: [
                                      for(int j = 0; j < context.watch<NoticedataProvider>().co; j++)...[
                                        Column(
                                          children: [
                                            if(j == 0)...[
                                              Container(
                                                width: 200.w,
                                                height: 200.w,
                                                margin: EdgeInsets.only(left: 60.w, top: 10.w),
                                                child: context.watch<NoticedataProvider>().imageList[context.watch<NoticedataProvider>().co * i + j],
                                              )
                                            ] else
                                              ...[
                                                Container(
                                                  width: 200.w,
                                                  height: 200.w,
                                                  margin: EdgeInsets.only(
                                                      left: 20.w, top: 20.w),
                                                  child: Center(
                                                      child: context.watch<NoticedataProvider>().imageList[context.watch<NoticedataProvider>().co * i + j]
                                                  ),
                                                )
                                              ],
                                          ],
                                        )
                                    ]]),
                                Row(
                                  children: [
                                    Container(
                                      width: 1000.w,
                                      height: 97.w,
                                      margin: EdgeInsets.only(left: 5.w, top: 5.w),
                                      decoration: BoxDecoration(
                                          color: const Color(0xff707070),
                                          border: Border.all(
                                            color: const Color(0xffffffff),
                                            width: 1.w,
                                          )
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ],
                          ),

            ],
        ),
    );
  }
}
