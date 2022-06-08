import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opgg/components/grey_box.dart';
import 'package:opgg/components/info_card.dart';
import 'package:opgg/components/info_list_card.dart';
import 'package:opgg/components/match_card.dart';
import 'package:opgg/components/rank_card.dart';
import 'package:opgg/controller/summoner_controller.dart';
import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/model/summoner_model.dart';
import 'package:opgg/model/summoner_tier.dart';
import 'package:opgg/repository/repository.dart';

class InfoScreen extends GetView<SummonerController> {
  final Future<SummonerModel> future;
  // final SummonerTier smTier;

  InfoScreen({
    required this.future,
    // required this.smTier,

    Key? key,
  }) : super(key: key);
  SummonerController s = Get.put(SummonerController());

  @override
  Widget build(BuildContext context) {
    String? summonerId;
    String? puuid;

    return Scaffold(
      body: FutureBuilder<SummonerModel>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('에러가 있습니다'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          SummonerModel sm = snapshot.data!;
          summonerId = sm.id;
          puuid = sm.puuid;

          // final matchList = getMatchIdFromSummoner(puuid: puuid);
          // print(matchList);

          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                children: [
                  // 상단 카드
                  InfoCard(
                    name: '${sm.name}',
                    summonerLevel: '${sm.summonerLevel}',
                    profileIconId: '${sm.profileIconId}',
                    puuid: '${sm.puuid}',
                    onPressed: () {
                      final matchId = s.getMatchIdFromSummoner(puuid: sm.puuid);
                      final match = s.getMatch(matchId: matchId, puuid: sm.puuid);
                      print(match);
                    },
                  ),
                  const SizedBox(height: 20),
                  // 티어, 랭크 정보 표시
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<SummonerLeagueModel>(
                          future: controller.getSummonerLeagueInfo(
                              summonerId: summonerId),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text('에러가 있습니다'),
                              );
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            SummonerLeagueModel sl = snapshot.data!;
                            return RankCard(
                              // imagePath: widget.smTier.imagePath,
                              tier: sl.tier,
                              rank: sl.rank.split('').length.toString(),
                              wins: sl.wins,
                              loses: sl.losses,
                              leaguePoints: sl.leaguePoints,
                            );
                          },
                        ),

                        const SizedBox(height: 10.0),
                        // 최근 20경기 정보
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              InfoListCard(),
                              SizedBox(width: 10),
                              InfoListCard(),
                              SizedBox(width: 10),
                              InfoListCard(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  const GreyBox(),
                  // ...List.generate(
                  //   5,
                  //   (index) =>
                  FutureBuilder<List>(
                    future: controller.getMatchIdFromSummoner(puuid: sm.puuid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('에러'));
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final matchList = snapshot.data;
                      print(matchList);
                      return MatchCard(
                        matchList: matchList!,
                        puuid: sm.puuid,
                      );
                    },
                  ),
                  // ),
                ],
              ),
              // Text(widget.id),
            ],
          );
        },
      ),
    );
  }
}
