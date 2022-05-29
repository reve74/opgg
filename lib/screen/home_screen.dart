import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:opgg/components/search_text_field.dart';
import 'package:opgg/const/colors.dart';
import 'package:opgg/model/patch_note.dart';
import 'package:opgg/screen/search_screen.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:opgg/screen/web_view_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WebViewController? controller;

  var uri =
      Uri.parse('https://www.leagueoflegends.com/ko-kr/news/tags/patch-notes/');
  List<PatchNote> notes = [];
  bool isLoading = false;

  Future getPatchNote() async {
    var res = await http.get(uri);
    final body = utf8.decode(res.bodyBytes); // 한글깨짐 변환
    final document = parser.parse(body);

    document
        .getElementsByClassName("style__WrapperInner-sc-106zuld-1 eInLGL")[0]
        .getElementsByClassName("style__Item-sc-106zuld-3 a-DAap")
        .forEach(
      (element) {
        setState(() {
          notes.add(PatchNote(
            title: element.children[0].children[0].children[1].children[0]
                .children[1].text
                .toString(),
            imagePath: element.children[0].children[0].children[0].children[0]
                .children[0].children[0].attributes['src']
                .toString(),
            link: element.children[0].attributes['href'].toString(),
          ));
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getPatchNote();
  }

  @override
  Widget topBar(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SearchScreen()));
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
        Container(
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
              notes.length == 0
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
      ],
    );
  }

  // 패치노트 카드
  Widget patchNoteCard(index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => WebViewScreen(link: notes[index].link)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                notes[index].imagePath,
                fit: BoxFit.cover,
                width: 200,
                height: 100,
              ),
            ),
            Positioned(
              left: 10.0,
              bottom: 5,
              child: Text(
                notes[index].title,
                style: TextStyle(
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
              Text(
                'OP.GG',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontFamily: 'RedHat',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
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
