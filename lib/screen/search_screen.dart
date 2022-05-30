import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opgg/const/colors.dart';
import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/model/summoner_model.dart';
import 'package:opgg/repository/repository.dart';
import 'package:opgg/repository/tier_level.dart';
import 'package:opgg/screen/info_screen.dart';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
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
                          // FutureBuilder<SummonerModel>(
                          //   future: result,
                          //   builder: (context, snapshot) {
                          //     if(snapshot.hasError) {
                          //       return const Center(child: Text('에러가 있습니다'));
                          //     }
                          //     if(!snapshot.hasData) {
                          //       return const Center(child: CircularProgressIndicator());
                          //     }
                          //     SummonerModel sm = snapshot.data!;
                          //     print(sm);
                          //     print(sm.id);
                          //     return Container();
                          //   },
                          // );
                          // final result2 = getSummonerLeagueInfo(summonerId: result);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => InfoScreen(
                                future: result,
                                smTier: tierLevel[6],
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
      ),
    );
  }
}
