import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opgg/components/info_card.dart';
import 'package:opgg/components/info_list_card.dart';
import 'package:opgg/components/rank_card.dart';
import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/model/summoner_model.dart';
import 'package:opgg/model/summoner_tier.dart';
import 'package:opgg/repository/repository.dart';

class InfoScreen extends StatefulWidget {
  final Future<SummonerModel> future;
  final SummonerTier smTier;
  // final SummonerLeagueModel smLeague;
  // final String id;
  // final String name;
  // final int summonerLevel;

  const InfoScreen({
    required this.future,
    required this.smTier,
    // required this.smLeague,
    // required this.smModel,
    // required this.id,
    // required this.name,
    // required this.summonerLevel,
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

  @override
  Widget build(BuildContext context) {
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

          print('-------');
          print(sm.id);
          final league = getSummonerLeagueInfo(summonerId: sm.id);
          print(league);

          print('조회 성공');
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Column(
                children: [
                  // Text('id : ${sm.id}'),
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
                        RankCard(
                          imagePath: widget.smTier.imagePath,
                          tier: widget.smTier.tier,
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
                    color: Colors.grey[300],
                  ),
                  ...List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
