import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opgg/const/colors.dart';
import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/model/summoner_model.dart';
import 'package:opgg/repository/repository.dart';
import 'package:opgg/repository/tier_level.dart';
import 'package:opgg/screen/info_screen.dart';
import 'package:opgg/screen/test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SummonerModel? sm;

  Future<SummonerModel> getSummonerInfo({required String summonerId}) async {
    final summonerModels =
        await SummonerRepository.getSummonerInfo(summonerId: summonerId);
    // print(summonerModels);
    return summonerModels;
  }

  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // late Future<String> _history;
  // // late Future<String> value;
  //
  // Future<void> _incrementCounter() async {
  //   final SharedPreferences prefs = await _prefs;
  //   // final String value = (prefs.get('testString')as String);
  //   setState(() {
  //     _history = prefs.setStringList('testString', ['개발']).then((bool success) {
  //       return _history;
  //     });
  //     print(_history);
  //   });
  // }
  //
  //
  // @override
  // void initState() {
  //   _incrementCounter();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                            filled: true,
                            fillColor: primaryColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              // borderSide: BorderSide(color: Colors.black)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
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
                            setState(() {
                              final result = getSummonerInfo(summonerId: value);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => InfoScreen(
                                    future: result,
                                    // smTier: tierLevel[6],
                                    // id: sm!.id,
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 8,
              color: Colors.grey[200],
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '최근 검색',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '전체 삭제',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            _searchHistory(),
          ],
        ),
      ),
    );
  }

  Widget _searchHistory() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: List.generate(
        5,
        (index) => ListTile(
          title: Text('$index'),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.clear),
          ),
        ),
      ).toList(),
    );
  }
}
