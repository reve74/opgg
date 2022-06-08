import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opgg/components/grey_box.dart';
import 'package:opgg/const/colors.dart';
import 'package:opgg/controller/search_controller.dart';
import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/model/summoner_model.dart';
import 'package:opgg/repository/repository.dart';
import 'package:opgg/repository/tier_level.dart';
import 'package:opgg/screen/info_screen.dart';

class SearchScreen extends GetView<SearchController> {
  SearchScreen({Key? key}) : super(key: key);

  SummonerModel? sm;

  Future<SummonerModel> getSummonerInfo({required String summonerId}) async {
    final summonerModels =
        await SummonerRepository.getSummonerInfo(summonerId: summonerId);
    print(summonerModels);
    return summonerModels;
  }

  @override
  Widget build(BuildContext context) {
    print(controller.history.length);

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey, width: 1),
                              ),
                              filled: true,
                              fillColor: primaryColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                // borderSide: BorderSide(color: Colors.black)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: const EdgeInsets.all(0),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey[500],
                              ),
                              hintText: '소환사 검색',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onSubmitted: (value) {
                              controller.search(value);
                              final result = getSummonerInfo(summonerId: value);
                              Get.to(
                                () => InfoScreen(
                                  future: result,
                                ),
                              );
                              // setState(() {
                              //   final result = getSummonerInfo(summonerId: value);
                              //   Get.to(
                              //     () => InfoScreen(
                              //       future: result,
                              //     ),
                              //   );
                              // });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const GreyBox(),
              const SizedBox(height: 10),
              controller.history.length != 0
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '최근 검색',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.deleteAllSearchList();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    '전체 삭제',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _searchHistory(),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[200],
                        ),
                        height: 80,
                        child: Center(
                          child: Text(
                            '최근 검색 내역이 없습니다.',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchHistory() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(
        controller.history.length,
        (index) => ListTile(
          onTap: () {
            // controller.searchSummoner(controller.history[index]);
            final result =
                getSummonerInfo(summonerId: controller.history[index]);
            Get.to(() => InfoScreen(future: result));
          },
          title: Text(controller.history[index]),
          trailing: IconButton(
            onPressed: () {
              controller.deleteSearchList(controller.history[index]);
            },
            icon: Icon(Icons.clear),
          ),
        ),
      ).toList(),
    );
  }
}
