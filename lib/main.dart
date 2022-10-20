import 'package:flutter/material.dart';
//maindart change test
void main() {
  runApp(const Screen1());
}

class Screen1 extends StatelessWidget {
  const Screen1({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1920,
        height: 1080,
        decoration: const BoxDecoration(
            color: Colors.white),
        child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [// 0세 데코-02
                  Container(
                    width: 356,
                    height: 329,
                      child: const Image(image: AssetImage('assets/drawable-xxhdpi/0_02.jpg')),
                  )
    ],
    )
      ],
    ),
          Column()
      ],
    )
        );
  }
}