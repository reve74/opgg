import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:opgg/const/data.dart';
import 'package:opgg/model/match_model.dart';
import 'package:opgg/repository/repository.dart';

class MatchCard extends StatelessWidget {
  List matchList;
  String puuid;

  MatchCard({
    required this.matchList,
    required this.puuid,
    Key? key,
  }) : super(key: key);

  Future<List<MatchModel>> getMatch({required matchId, required puuid}) async {
    // Map<, MatchModel> matches = {};
    final response =
        await SummonerRepository.getMatch(matchId: matchId, puuid: puuid);

    // List<Future> futures = [];
    // final results = await Future.wait(futures);
    //
    // for(int i =0; i<matchList.length; i++) {
    //   final key = matchList.elementAt(i);
    //   final value = results[i];
    // }

    // print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text('${matchList.toList()}'),
        ...matchList
            .asMap()
            .entries
            .map(
              (e) => Card(
                future: getMatch(matchId: e.value, puuid: puuid),
                puuid: puuid,
              ),
            )
            .toList(),
      ],
    );
  }
}

class Card extends StatelessWidget {
  final Future<List<MatchModel>> future;
  final String puuid;

  const Card({
    required this.future,
    required this.puuid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MatchModel>>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('에러가 있습니다'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<MatchModel> match = snapshot.data!;

        final myMatch =
            match.where((element) => element.puuid.contains(puuid)).toList();

        final myMatchDetails = myMatch[0];
        final gameDuration = (myMatchDetails.challenges['gameLength'] / 60)
            .toStringAsFixed(2)
            .split('.');

        // match.where((puuid) => MatchModel.fromJson(json: puuid)).toList();

        // print(match.map((e) => e.puuid == puuid));

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 50,
                  color: myMatchDetails.win
                      ? Colors.indigoAccent[400]
                      : Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (myMatchDetails.win)
                        const Text(
                          '승',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      else
                        const Text(
                          '패',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 6.0),
                        child: Divider(
                          height: 0.5,
                          thickness: 1.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${gameDuration[0]}:${(int.parse(gameDuration[1]) * 6 / 10).floor()}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: 240,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                                CHAMPION_API+'${myMatch[0].championName}.png', fit: BoxFit.cover,
                              width: 45,
                              height: 45,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              iconCard(),
                              const SizedBox(
                                height: 5,
                              ),
                              iconCard(),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              iconCard(),
                              const SizedBox(
                                height: 5,
                              ),
                              iconCard(),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${myMatchDetails.kills}/${myMatchDetails.deaths}/${myMatchDetails.assists}',
                                style: TextStyle(fontSize: 22.0),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                '${((myMatchDetails.kills+myMatchDetails.assists)/myMatchDetails.deaths).toStringAsFixed(2)}:1 평점',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          itemCard(
                            netWork: ITEM_API + '${myMatch[0].item0}.png',
                            hasData: myMatch[0].item0,
                          ),
                          itemCard(
                            netWork: ITEM_API + '${myMatch[0].item1}.png',
                            hasData: myMatch[0].item1,
                          ),
                          itemCard(
                            netWork: ITEM_API + '${myMatch[0].item2}.png',
                            hasData: myMatch[0].item2,
                          ),
                          itemCard(
                            netWork: ITEM_API + '${myMatch[0].item3}.png',
                            hasData: myMatch[0].item3,
                          ),
                          itemCard(
                            netWork: ITEM_API + '${myMatch[0].item4}.png',
                            hasData: myMatch[0].item4,
                          ),
                          itemCard(
                            netWork: ITEM_API + '${myMatch[0].item5}.png',
                            hasData: myMatch[0].item5,
                          ),
                          itemCard(
                            netWork: ITEM_API + '${myMatch[0].item6}.png',
                            hasData: myMatch[0].item6,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '개인/2인 랭크',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500]),
                          ),
                          Text(
                            '1일 전',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget iconCard() {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        color: Colors.black,
        width: 20,
        height: 20,
      ),
    );
  }

  Widget itemCard({required String netWork, required int hasData}) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey.withOpacity(0.5),
        ),
        width: 23,
        height: 23,
        child: hasData != 0
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(netWork),
              )
            : null,
      ),
    );
  }
}
