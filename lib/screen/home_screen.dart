import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:opgg/components/grey_box.dart';
import 'package:opgg/components/search_text_field.dart';
import 'package:opgg/const/colors.dart';
import 'package:opgg/controller/patchnote_controller.dart';
import 'package:opgg/controller/search_controller.dart';
import 'package:opgg/model/patch_note.dart';
import 'package:opgg/repository/repository.dart';
import 'package:opgg/screen/register_screen.dart';
import 'package:opgg/screen/search_screen.dart';

import 'package:opgg/screen/web_view_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<PatchNoteController> {
  HomeScreen({Key? key}) : super(key: key);
  final PatchNoteController p = Get.put(PatchNoteController());

  Future getChampions() async {
    final response = await SummonerRepository.getChampions();
    print(response.keys);
    // print(response);
    return response;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getPatchNote();
  //   // getChampions();
  // }
  //
  // @override
  // void dispose() {
  //   getPatchNote();
  //   // getChampions();
  //   super.dispose();
  // }

  @override
  Widget topBar(BuildContext context) {
    final ts = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    );

    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => SearchScreen(), binding: BindingsBuilder(() {
              Get.put(SearchController());
            }));
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (_) => SearchScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                SearchTextField(
                  enable: false,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 250,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.asset(
                                'asset/img/teemo.jpeg',
                                height: 70,
                              ),
                            ),
                            const Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              top: 0,
                              child: Center(
                                child: Text(
                                  '?',
                                  style: TextStyle(
                                      fontSize: 50, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('내 KDA는 몇점?', style: ts),
                            const SizedBox(height: 5),
                            Text('내가 가장 잘하는 챔피언은?', style: ts),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  '소환사를 검색해서 등록해주세요!',
                  style: TextStyle(fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  '나의 전적을 분석해 도움을 줍니다.',
                  style: TextStyle(fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: const Color(0xffAE0ECF8),
                  ),
                  onPressed: () {
                    Get.to(() => RegisterScreen());
                  },
                  child: const Text(
                    '소환사 등록하기',
                    style: TextStyle(
                      color: Colors.indigoAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const GreyBox(),
        Obx(
          () => Container(
            color: Colors.black87,
            height: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    '패치노트',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                controller.notes.length == 0
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: List.generate(
                              3,
                              (index) => patchNoteCard(index),
                            ).toList(),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 패치노트 카드
  Widget patchNoteCard(index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => WebViewScreen(link: controller.notes[index].link));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => WebViewScreen(link: notes[index].link)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                controller.notes[index].imagePath,
                fit: BoxFit.cover,
                width: 200,
                height: 100,
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 5,
              child: Text(
                controller.notes[index].title,
                style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appbar(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            topBar(context),
          ],
        ),
      ),
    );
  }
}

// 앱바
AppBar appbar(BuildContext context) {
  return AppBar(
    bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('asset/img/mainlogo.jpeg', height: 50,),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey[100],
                    ),
                    height: 35,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'KR',
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 8.0),
                        Image.asset(
                          'asset/img/chevron.png',
                          width: 20,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Image.asset(
                    'asset/img/sort.png',
                    width: 25,
                  ),
                ],
              ),
            ],
          ),
        )),
    backgroundColor: primaryColor,
    elevation: 0.0,
    // title: ,
  );
}
