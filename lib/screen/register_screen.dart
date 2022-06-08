import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opgg/const/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
      fontSize: 20.0,
    );

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appbar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'asset/img/op.png',
                  height: 70,
                )),
            const SizedBox(height: 20),
            Text(
              '내 소환사를 등록해주세요!',
              style: ts.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '전적을 분석해 도움을 줍니다.',
              style: ts,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                hintText: '소환사 아이디',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // onSubmitted: ,
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      '완료',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffC9CCD5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

AppBar appbar(BuildContext context) {
  return AppBar(
    bottom: PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 0),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: Get.back,
              icon: const Icon(
                Icons.clear,
                size: 28,
              ),
            ),
            Text(
              'KR',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    ),
    backgroundColor: primaryColor,
    elevation: 0.0,
    // title: ,
  );
}
