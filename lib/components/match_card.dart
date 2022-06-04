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
    final response = await SummonerRepository.getMatch(matchId: matchId, puuid: puuid);

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
                future: getMatch(matchId: e.value, puuid: puuid), puuid: puuid,
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
      builder: (BuildContext context,AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('에러가 있습니다'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<MatchModel> match = snapshot.data!;
        // print(match.length);
        // match.where((puuid) => MatchModel.fromJson(json: puuid)).toList();

        print(match[0].puuid == puuid);

        print(match[0].championName);
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
                  color: Colors.indigoAccent[400],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '승',
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
                        '27:26',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.lightBlue,
                  width: 240,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        child: Image.network('https://ddragon.leagueoflegends.com/cdn/12.10.1/img/champion/${match[0].championName}.png'),
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
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '개인/2인 랭크',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('1일 전'),
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
    return Container(
      color: Colors.black,
      width: 20,
      height: 20,
    );
  }
}
