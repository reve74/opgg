// import 'package:flutter/material.dart';
//
// void main() {
//   var userId = "test5";
//
//   List list = [];
//   Member member1 = Member(1, "test");
//   Member member2 = Member(2, "test2");
//   Member member3 = Member(3, "test3");
//   Member member4 = Member(4, "test4");
//   Member member5 = Member(5, "test5");
//   Member member6 = Member(5, "test6");
//   Member member7 = Member(5, "test7");
//   Member member8 = Member(5, "test8");
//   Member member9 = Member(5, "test9");
//   Member member10 = Member(5, "test10");
//   list.add(member1);
//   list.add(member2);
//   list.add(member3);
//   list.add(member4);
//   list.add(member5);
//   list.add(member6);
//   list.add(member7);
//   list.add(member8);
//   list.add(member9);
//   list.add(member10);
//
//   var findMember = list.where((element) {
//     return userId == element.name;}).toList();
//
//   print(findMember[0]);
//
//
//
// }
//
// class Member {
//
//   var idx;
//   var name;
//   Member(this.idx, this.name);
//
// }




import 'package:flutter/material.dart';
import 'package:opgg/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
