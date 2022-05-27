import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opgg/components/info_card.dart';
import 'package:opgg/model/summoner_model.dart';
import 'package:opgg/repository/repository.dart';

class InfoScreen extends StatefulWidget {
  final Future<SummonerModel> future;
  // final String id;
  // final String name;
  // final int summonerLevel;

  const InfoScreen({
    required this.future,
    // required this.id,
    // required this.name,
    // required this.summonerLevel,
    Key? key,
  }) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   SummonerRepository.getSummonerLeagueInfo(
  //       summonerId: 'wFdzQEw_3tktqVbS_yN0bWM4j3S7xrTt8BBup34vzodswg');
  // }

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
          print('조회 성공');
          return Column(
            children: [
              // Text('id : ${sm.id}'),
              InfoCard(
                name: '${sm.name}',
                summonerLevel: '${sm.summonerLevel}',
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        2,
                        (index) => Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 300,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Column(
                            children: [
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Text('name : ${sm.name}'),
              // Text('summonerLevel : ${sm.summonerLevel.toString()}'),
            ],
          );
        },
      ),
    );
  }
}
