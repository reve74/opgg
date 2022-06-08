import 'dart:convert';

import 'package:get/get.dart';
import 'package:opgg/const/data.dart';
import 'package:opgg/model/patch_note.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class PatchNoteController extends GetxController {
  static PatchNoteController get to => Get.find();

  WebViewController? controller;
  var uri = Uri.parse(PATCH_NOTE);

  // List<PatchNote> notes = [];
  // bool isLoading = false;
  RxList<PatchNote> notes = <PatchNote>[].obs;

  @override
  void onInit() async{
    super.onInit();
    getPatchNote();
  }

  Future getPatchNote() async {
    var res = await http.get(uri);
    final body = utf8.decode(res.bodyBytes); // 한글깨짐 변환
    final document = parser.parse(body);

    document
        .getElementsByClassName("style__WrapperInner-sc-106zuld-1 eInLGL")[0]
        .getElementsByClassName("style__Item-sc-106zuld-3 a-DAap")
        .forEach(
      (element) {
        // setState(() {
        notes.add(PatchNote(
          title: element
              .children[0].children[0].children[1].children[0].children[1].text
              .toString(),
          imagePath: element.children[0].children[0].children[0].children[0]
              .children[0].children[0].attributes['src']
              .toString(),
          link: element.children[0].attributes['href'].toString(),
        ));
        // });
      },
    );
  }
}
