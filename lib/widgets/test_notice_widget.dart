import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_info_panel/provider/notice_data.dart';
import 'package:provider/provider.dart';

class TestNoticeWidget extends StatefulWidget {
  const TestNoticeWidget({Key? key}) : super(key: key);

  @override
  State<TestNoticeWidget> createState() => _TestNoticeWidgetState();
}

class _TestNoticeWidgetState extends State<TestNoticeWidget> {
  bool newsExist = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 480.w,
              height: 300.w,
              margin: EdgeInsets.only(left: 32.w, top: 32.w),
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
                          child: Text(context.watch<NoticedataProvider>().news,
                              style: TextStyle(
                                fontFamily: 'NotSanaKR',
                                color: const Color(0xff898989),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ))),
                      Container(
                          margin: EdgeInsets.only(left: 27.w, top: 30.w),
                          child: Text(
                              context
                                      .watch<NoticedataProvider>()
                                      .months
                                      .toString() +
                                  '월 ' +
                                  context
                                      .watch<NoticedataProvider>()
                                      .weeks
                                      .toString() +
                                  '주 ' +
                                  context
                                      .watch<NoticedataProvider>()
                                      .names
                                      .toString() +
                                  '주요행사',
                              style: TextStyle(
                                fontFamily: 'NotSanaKR',
                                color: const Color(0xff39605f),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ))),
                      Container(
                          margin: EdgeInsets.only(left: 27.w, top: 15.w),
                          child:
                              Text(context.watch<NoticedataProvider>().weekinfo,
                                  style: TextStyle(
                                    fontFamily: 'NotSanaKR',
                                    color: const Color(0xff39605f),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ))),
                      Container(
                          width: 200,
                          margin: EdgeInsets.only(left: 27.w, top: 20.w),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Text(
                                      context
                                          .watch<NoticedataProvider>()
                                          .NewsComment,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontFamily: 'NotSanaKR',
                                        color: const Color(0xff000000),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      ))),
                            ],
                          )),
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
                                color: const Color(0xff898989),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ))),
                      for (int i = 0; i < context.watch<NoticedataProvider>().specialDays.length; i++) ...[
                        if (context.watch<NoticedataProvider>().specialDays[i] == context.watch<NoticedataProvider>().now) ...[
                          Container(
                              margin: EdgeInsets.only(left: 27.w, top: 40.w),
                              child: Text(
                                  context.watch<NoticedataProvider>().specialNews[i],
                                  style: TextStyle(
                                    fontFamily: 'NotSanaKR',
                                    color: const Color(0xff39605f),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ))
                          )
                        ]
                      ],
                      // if(context.watch<NoticedataProvider>().now == context.watch<NoticedataProvider>().days)...[
                      //   Container(
                      //       margin: EdgeInsets.only(left: 27.w, top: 40.w),
                      //   child:
                      //   Text(context.watch<NoticedataProvider>().specialNews[0],
                      //     style: TextStyle(
                      //       fontFamily:'NotSanaKR',
                      //       color: const Color(0xff39605f),
                      //       fontSize: 18.sp,
                      //       fontWeight: FontWeight.w500,
                      //       fontStyle: FontStyle.normal,
                      //     )
                      //   )
                      //   )
                      // ]else...[
                      //   Container(
                      //       margin: EdgeInsets.only(left: 27.w, top: 40.w),
                      //       child: Text("오늘은 일정 없음",
                      //       style: TextStyle(
                      //         fontFamily:'NotSanaKR',
                      //         color: const Color(0xff39605f),
                      //         fontSize: 18.sp,
                      //         fontWeight: FontWeight.w500,
                      //         fontStyle: FontStyle.normal,
                      //       )
                      //   )
                      //   )
                      // ],

                      // Container(
                      //     margin: EdgeInsets.only(left: 20.w, top: 30.w),
                      //     child: Text("친구한테 생일축하한다고 말해주세요!(등의 한마디)",
                      //         style: TextStyle(
                      //           fontFamily: 'NotSanaKR',
                      //           color: const Color(0xff000000),
                      //           fontSize: 16.sp,
                      //           fontWeight: FontWeight.w500,
                      //           fontStyle: FontStyle.normal,
                      //         ))),
                    ],
                  )
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
                ))),
        for (int i = 0; i < context.watch<NoticedataProvider>().ro; i++) ...[
          Row(children: [
            for (int j = 0;
                j < context.watch<NoticedataProvider>().co;
                j++) ...[
              Column(
                children: [
                  if (j == 0) ...[
                    Container(
                      width: 200.w,
                      height: 200.w,
                      margin: EdgeInsets.only(left: 98.w, top: 30.w),
                      child: context.watch<NoticedataProvider>().imageList[
                          context.watch<NoticedataProvider>().co * i + j],
                    )
                  ] else ...[
                    Container(
                      width: 200.w,
                      height: 200.w,
                      margin: EdgeInsets.only(left: 20.w, top: 30.w),
                      child: Center(
                          child: context.watch<NoticedataProvider>().imageList[
                              context.watch<NoticedataProvider>().co * i + j]),
                    )
                  ],
                ],
              )
            ]
          ]),
        ],
      ],
    );
  }
}
