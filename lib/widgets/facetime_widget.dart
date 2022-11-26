import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smart_info_panel/api/infopanel.dart';
import 'dart:async';

import '../provider/class_data.dart';
import 'package:provider/provider.dart';

class FacetimeWidget extends StatefulWidget {
  const FacetimeWidget({Key? key}) : super(key: key);

  @override
  State<FacetimeWidget> createState() => _FacetimeWidgetState();
}

class _FacetimeWidgetState extends State<FacetimeWidget> {
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 318.w, top: 116.w),
                                child: Text("여기를 봐주세요!",
                                    style: TextStyle(
                                      fontFamily: 'GamjaFlower',
                                      color: const Color(0xff39605f),
                                      fontSize: 70.sp,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ))
                            ),
                            Container(
                                width: 562.w,
                                height: 691.w,
                                margin: EdgeInsets.only(left: 242.w, top: 60.w),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff63e6d7),
                                        width: 6.w
                                    )
                                )
                            )
                          ],
                        )
                ],
              ),
            ]
        )
    );
  }
}