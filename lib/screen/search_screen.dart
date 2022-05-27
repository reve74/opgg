import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/model/summoner_model.dart';
import 'package:opgg/repository/repository.dart';
import 'package:opgg/screen/info_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SummonerModel? sm;

  Future<SummonerModel> getSummonerInfo({required String summonerId}) async {
    final response =
        await SummonerRepository.getSummonerInfo(summonerId: summonerId);
    print(response);
    return response;
  }

  Future<SummonerLeagueModel> getSummonerLeagueInfo(
      {required summonerId}) async {
    final response =
        await SummonerRepository.getSummonerLeagueInfo(summonerId: summonerId);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    bool onTap = false;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
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
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
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

                          print('체크');
                          print(result);
                          // final result2 = getSummonerLeagueInfo(summonerId: result['id']);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => InfoScreen(
                                future: result,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  onTap
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              onTap = false;
                              print(onTap);
                            });
                          },
                          child: Text(
                            '취소',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
