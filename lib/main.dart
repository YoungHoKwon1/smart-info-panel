import 'package:flutter/material.dart';
//maindart change test
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1920,
        height: 1080,
        decoration: const BoxDecoration(
            color: Color(0xffffffff)
        )
        @override
        Widget build(BuildContext context) {
      return Container(
        width: 1048,
        height: 880,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(20)
            ),
            border: Border.all(
                color: const Color(0x6663e6d7),
                width: 1
            ),
            boxShadow: [BoxShadow(
                color: const Color(0x29b1b1b1),
                offset: Offset(-2,2),
                blurRadius: 6,
                spreadRadius: 0
            ), BoxShadow(
                color: const Color(0x29dbdbdb),
                offset: Offset(-2,-4),
                blurRadius: 6,
                spreadRadius: 0
            )] ,
            color: const Color(0xffffffff)
        )
    )
    )
  }
}