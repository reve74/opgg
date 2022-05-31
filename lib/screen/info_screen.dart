import 'package:flutter/material.dart';
import 'package:opgg/components/info_card.dart';
import 'package:opgg/components/info_list_card.dart';
import 'package:opgg/components/match_card.dart';
import 'package:opgg/components/rank_card.dart';
import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/model/summoner_model.dart';
import 'package:opgg/model/summoner_tier.dart';
import 'package:opgg/repository/repository.dart';

class InfoScreen extends StatefulWidget {
  final Future<SummonerModel> future;
  // final SummonerTier smTier;

  const InfoScreen({
    required this.future,
    // required this.smTier,

    Key? key,
  }) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

  Future<SummonerLeagueModel> getSummonerLeagueInfo(
      {required summonerId}) async {
    final response =
        await SummonerRepository.getSummonerLeagueInfo(summonerId: summonerId);

    return response;
  }

  Future<List> getMatchIdFromSummoner({required puuid}) async{
    final response = await SummonerRepository.getMatchIdFromSummoner(puuid: puuid);
    // List matchList = [];
    // matchList.addAll(response);

    print(response);

    return response;
  }


  Future getMatch({required matchId}) async {
    final response = await SummonerRepository.getMatch(matchId: matchId);

    print(response);
  }


  @override
  Widget build(BuildContext context) {
    String? summonerId;
    String? puuid;

    return Scaffold(
      body: FutureBuilder<SummonerModel>(
        future: widget.future,
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

          final matchList = getMatchIdFromSummoner(puuid: puuid);
          print(matchList);
          // final res = match.add(matchList);


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
                  ),
                  const SizedBox(height: 20),
                  // 티어, 랭크 정보 표시
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<SummonerLeagueModel>(
                          future: getSummonerLeagueInfo(summonerId: summonerId),
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
                            children: [
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
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                  ...List.generate(
                    5,
                    (index) => MatchCard(),
                  ),
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
